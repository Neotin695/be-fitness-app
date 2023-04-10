import 'dart:io';

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
  final _storage = FirebaseStorage.instance.ref();
  final _auth = FirebaseAuth.instance.currentUser;

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
      birthDate: '',
      nationalId: '',
      ceritifcateId: '');

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

    _store.collection('coachs').doc(_auth!.uid).set(coachData.toMap());
    _store.collection('requests').add(requestData.toMap());
    FirebaseFirestore.instance
        .collection('tempuser')
        .doc(coachData.id)
        .update({"status": 'notAccepted'});
    emit(RequestSentSucess());

    resetData();
  }

  void resetData() {
    request = RequestOnlineCoachModel(
        nationalIdFrontImg: '',
        nationalIdBakcImg: '',
        certificateIdImg: '',
        personalImg: '',
        fulName: '',
        birthDate: '',
        nationalId: '',
        ceritifcateId: '');
    name.clear();
    address = AddressModel(
        name: '', postalCode: '', country: '', subLocality: '', locality: '');
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
          .child(_auth!.uid)
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
        fulName: name.text,
        birthDate: DateFormat.yMd().format(birthDate),
        nationalId: nationalId.text,
        ceritifcateId: certificateId.text);
  }

  CoachModel initDataCoach() {
    return CoachModel(
        id: _auth!.uid,
        state: false,
        userName: name.text,
        email: _auth!.email!,
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
}
