import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/appconstance/app_constance.dart';
import '../../../core/service/enumservice/gender_service.dart';
import '../../../core/service/enumservice/level_service.dart';
import '../../../core/service/internet_service.dart';
import '../../../models/trainee_model.dart';

part 'getstarted_state.dart';

class GetstartedCubit extends Cubit<GetstartedState> with PickMedia {
  static GetstartedCubit get(context) => BlocProvider.of(context);
  GetstartedCubit() : super(GetstartedInitial());
  final TextEditingController userName = TextEditingController();
  double height = 0;
  double weight = 0;
  int age = 0;

  final GlobalKey<FormState> key = GlobalKey();
  final PageController controller = PageController();

  String genderSelected = 'male';
  String levelSelected = 'intermediate';

  Color? unselectedColor = const Color(0xFF00210B);
  String imagePath = '';
  int index = 0;

  final ages = List.generate(100, (index) => index);
  final levels = [
    AppConst.beginnerTxt,
    AppConst.intermediateTxt,
    AppConst.advancedTxt
  ];
  final List<double> weights =
      List.generate(100, (index) => double.parse(index.toString()));

  final List<double> heights =
      List.generate(201, (index) => double.parse(index.toString()));

  AddressModel address = AddressModel(
      name: '', postalCode: '', country: '', subLocality: '', locality: '');

  final _store = FirebaseFirestore.instance.collection(LogicConst.users);
  final _storage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance.currentUser!;

  TraineeModel initData(profilePhoto, token) {
    return TraineeModel(
      id: _auth.uid,
      userName: _auth.displayName!,
      age: age + 1,
      address: address,
      profilePhoto: profilePhoto,
      token: token,
      email: _auth.email!,
      gender: GenderService().convertStringToEnum(genderSelected),
      level: LevelService().convertStringToEnum(levelSelected),
      height: height + 1,
      weight: weight + 1,
    );
  }

  Future<void> uploadData() async {
    if (!await InternetService().isConnected()) {
      emit(const UploadFailure(
          message: 'No internet!, please your connection and try again'));
      return;
    }

    final profilePhoto = await uploadProfilePhoto();
    final token = await FirebaseMessaging.instance.getToken();
    final trainee = initData(profilePhoto, token);
    try {
      _store.doc(trainee.id).set(trainee.toMap());
      emit(UploadSucess());
      FirebaseFirestore.instance
          .collection(LogicConst.tempUser)
          .doc(trainee.id)
          .update({LogicConst.status: LogicConst.authenticate});
    } on FirebaseException catch (e) {
      emit(UploadFailure(message: e.toString()));
    }
  }

  Future<String> uploadProfilePhoto() async {
    if (imagePath.isNotEmpty) {
      final task = await uploadSingleFile(imagePath, _storage.ref(_auth.uid));

      if (task.state == TaskState.running) {
        emit(UploadLoading());
      }

      if (task.state == TaskState.success) {
        emit(UploadSucess());
        return await task.ref.getDownloadURL();
      }
    }
    return '';
  }

  void resetValues() {
    userName.clear();
    age = 0;
    weight = 0;
    height = 0;
    genderSelected = 'male';
    levelSelected = 'intermediate';
    address = AddressModel(
        name: '', postalCode: '', country: '', subLocality: '', locality: '');
  }
}
