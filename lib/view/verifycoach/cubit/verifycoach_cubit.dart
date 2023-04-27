import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/models/rating_model.dart';
import 'package:be_fitness_app/models/request_online_coach.dart';

import '../../../models/address_model.dart';

part 'verifycoach_state.dart';

class VerifyCoachCubit extends Cubit<VerifyCoachState> with PickMedia {
  static VerifyCoachCubit get(context) => BlocProvider.of(context);
  VerifyCoachCubit() : super(VerifyCoachInitial());
  final TextEditingController name = TextEditingController();
  final TextEditingController certificateId = TextEditingController();
  final TextEditingController nationalId = TextEditingController();

  final GlobalKey<FormState> key = GlobalKey();

  final _store = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance.currentUser;
  StreamSubscription? streamSubscription;

  AddressModel address = AddressModel(
      name: '', postalCode: '', country: '', subLocality: '', locality: '');
  String selectedGender = 'male';
  int currentStep = 0;
  DateTime birthDate = DateTime.now();

  RequestOnlineCoachModel request = RequestOnlineCoachModel(
      nationalIdFrontImg: '',
      nationalIdBakcImg: '',
      certificateIdImg: '',
      personalImg: '',
      fulName: '',
      userId: '',
      birthDate: '',
      nationalId: '',
      certificateId: '',
      address: AddressModel(
          name: '',
          postalCode: '',
          country: '',
          subLocality: '',
          locality: ''));

  File src = File('');

  Future<String> pickSingleImg() async {
    try {
      return await pickSingleImage(ImageSource.camera);
    } catch (e) {
      return '';
    }
  }

  Future<String> pickSingleDoc(BuildContext context) async {
    try {
      return await pickDocument(context, ScannerFileSource.CAMERA);
    } catch (e) {
      return '';
    }
  }

  Future<void> sentRequest() async {
    if (!key.currentState!.validate()) {
      return;
    }
    if (isFilesEmpty) {
      emit(const RequestSentFailure(message: 'some document not set'));
      return;
    }

    if (address.country.isEmpty) {
      emit(const RequestSentFailure(message: 'please get your address first'));
      return;
    }

    final tempDownUrl = await uploadFiles();
    if (tempDownUrl.isEmpty) {
      emit(const RequestSentFailure(message: 'somthing want wrong!'));
      return;
    }
    request = initDataReq(tempDownUrl);
    final coachData = initDataCoach();

    _store.collection(LogicConst.users).doc(_auth!.uid).set(coachData.toMap());
    _store.collection(LogicConst.requests).doc(_auth!.uid).set(request.toMap());
    FirebaseFirestore.instance
        .collection(LogicConst.tempUser)
        .doc(coachData.id)
        .update({LogicConst.status: LogicConst.unauthenticate});
    emit(RequestSentSucess());

    resetData();
  }

  bool get isFilesEmpty {
    return request.certificateIdImg.isEmpty ||
        request.nationalIdBakcImg.isEmpty ||
        request.nationalIdFrontImg.isEmpty ||
        request.personalImg.isEmpty;
  }

  void resetData() {
    address = AddressModel(
        name: '', postalCode: '', country: '', subLocality: '', locality: '');
    request = RequestOnlineCoachModel(
        nationalIdFrontImg: '',
        nationalIdBakcImg: '',
        certificateIdImg: '',
        personalImg: '',
        userId: '',
        fulName: '',
        birthDate: '',
        nationalId: '',
        certificateId: '',
        address: address);
    name.clear();
    certificateId.clear();
    nationalId.clear();
  }

  Future<List<String>> uploadFiles() async {
    emit(ImgUploading());
    try {
      final result = await uploadMultiFiles([
        request.nationalIdFrontImg,
        request.nationalIdBakcImg,
        request.certificateIdImg,
        request.personalImg
      ], _storage.ref(_auth!.uid));

      emit(ImgUploadSucess());
      return result;
    } on FirebaseException catch (e) {
      emit(ImgUploadFailure(message: e.toString()));
      return [];
    } catch (e) {
      emit(ImgUploadFailure(message: e.toString()));
      return [];
    }
  }

  RequestOnlineCoachModel initDataReq(List<String> tempDownUrl) {
    return RequestOnlineCoachModel(
        nationalIdFrontImg: tempDownUrl[0],
        nationalIdBakcImg: tempDownUrl[1],
        certificateIdImg: tempDownUrl[2],
        personalImg: tempDownUrl[3],
        userId: FirebaseAuth.instance.currentUser!.uid,
        fulName: name.text,
        birthDate: DateFormat('yyyy-mm/dd').format(birthDate),
        nationalId: nationalId.text,
        certificateId: certificateId.text,
        address: address);
  }

  CoachModel initDataCoach() {
    return CoachModel(
        id: _auth!.uid,
        state: false,
        isCoach: true,
        userName: name.text,
        email: _auth!.email!,
        birthDate: DateFormat('yyyy-mm-dd').format(birthDate),
        address: address,
        certificateId: certificateId.text,
        nationalId: nationalId.text,
        profilePhoto: request.personalImg,
        gender: GenderService().convertStringToEnum(selectedGender),
        rating: RatingModel(
          totalRating: 0,
          ratingCount: const [],
          ratingAverage: 0,
        ),
        subscribers: const []);
  }

  void checkCoachState() {
    streamSubscription?.cancel();
    streamSubscription = _store
        .collection(LogicConst.tempUser)
        .doc(_auth!.uid)
        .snapshots()
        .listen((event) {
      var state = (event.data() as Map<String, dynamic>)[LogicConst.status];

      if (state == LogicConst.authenticate) {
        emit(AceeptedState());
      } else if (state == LogicConst.newTxt) {
        emit(RejectState());
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription?.cancel();
    return super.close();
  }
}
