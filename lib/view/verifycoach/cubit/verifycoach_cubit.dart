import 'dart:async';
import 'dart:io';

import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/gender_service.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/models/rating_model.dart';
import 'package:be_fitness_app/models/request_online_coach.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/address_model.dart';

part 'verifycoach_state.dart';

class VerifyCoachCubit extends Cubit<VerifyCoachState> {
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

  Future<String> pickDocument(context) async {
    try {
      File? scannedDoc = await DocumentScannerFlutter.launch(
        context,
        source: ScannerFileSource.CAMERA,
      );
      if (scannedDoc == null) {
        return '';
      } else {
        return scannedDoc.path;
      }
    } on PlatformException {
      return '';
    }
  }

  final ImagePicker _imagePicker = ImagePicker();

  Future<String> pickPersonalImg() async {
    try {
      final file = await _imagePicker.pickImage(source: ImageSource.camera);
      if (file == null) {
        return '';
      } else {
        return file.path;
      }
    } on PlatformException catch (e) {
      return '';
    }
  }

  Future<void> sentRequest() async {
    if (!key.currentState!.validate()) {
      return;
    }
    if (request.certificateIdImg.isEmpty ||
        request.nationalIdBakcImg.isEmpty ||
        request.nationalIdFrontImg.isEmpty ||
        request.personalImg.isEmpty) {
      emit(const RequestSentFailure(message: 'some document not set'));
      return;
    }

    if (address.country.isEmpty) {
      emit(const RequestSentFailure(message: 'please get your address first'));
      return;
    }

    final tempDownUrl = await uploadFiles();
    if (tempDownUrl.isEmpty) {
      emit(RequestSentFailure(message: 'somthing want wrong! $tempDownUrl'));
      return;
    }
    final requestData = initDataReq(tempDownUrl);
    final coachData = initDataCoach();

    _store.collection(LogicConst.coache).doc(_auth!.uid).set(coachData.toMap());
    _store
        .collection(LogicConst.requests)
        .doc(_auth!.uid)
        .set(requestData.toMap());
    FirebaseFirestore.instance
        .collection(LogicConst.tempUser)
        .doc(coachData.id)
        .update({LogicConst.status: LogicConst.unauthenticate});
    emit(RequestSentSucess());

    resetData();
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
    List<String> tempDownloadUrl = [];
    List<String> tempPaths = [
      request.nationalIdFrontImg,
      request.nationalIdBakcImg,
      request.certificateIdImg,
      request.personalImg
    ];
    emit(ImgUploading());
    for (var path in tempPaths) {
      final task = await _storage
          .ref(_auth!.uid)
          .child(path.split('/').last)
          .putFile(File(path));
      if (task.state == TaskState.running) {
      } else if (task.state == TaskState.success) {
        tempDownloadUrl.add(await task.ref.getDownloadURL());
      } else if (task.state == TaskState.error) {
        emit(const ImgUploadFailure(
            message: 'somthing want wrong!, please try agai'));
        tempDownloadUrl.clear();
        continue;
      }
    }
    emit(ImgUploadSucess());
    return tempDownloadUrl;
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

  Future<String> retrieveLostData() async {
    final response = await _imagePicker.retrieveLostData();
    if (response.isEmpty) {
      return '';
    }
    if (response.file != null) {
      return response.file!.path;
    } else {
      return '';
    }
  }

  CoachModel initDataCoach() {
    return CoachModel(
        id: _auth!.uid,
        state: false,
        userName: name.text,
        email: _auth!.email!,
        birthDate: DateFormat('yyyy-mm-dd').format(birthDate),
        address: address,
        certificateId: certificateId.text,
        nationalId: nationalId.text,
        profilePhoto: '',
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
