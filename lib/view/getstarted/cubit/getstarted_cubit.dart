import 'package:be_fitness_app/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/service/enumservice/gender_service.dart';
import '../../../core/service/enumservice/level_service.dart';
import '../../../core/service/internet_service.dart';
import '../../../models/trainee_model.dart';

part 'getstarted_state.dart';

class GetstartedCubit extends Cubit<GetstartedState> {
  static GetstartedCubit get(context) => BlocProvider.of(context);
  GetstartedCubit() : super(GetstartedInitial());
  final TextEditingController userName = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController age = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey();

  String genderSelected = 'male';
  String levelSelected = 'intermediate';
  AddressModel address = AddressModel(
      name: '', postalCode: '', country: '', subLocality: '', locality: '');

  final _store = FirebaseFirestore.instance.collection('trainee');
  final _auth = FirebaseAuth.instance.currentUser;

  TraineeModel initData() {
    return TraineeModel(
        id: _auth!.uid,
        userName: userName.text,
        age: int.parse(age.text),
        address: address,
        profilePhoto: '',
        email: _auth!.email!,
        gender: GenderService().convertStringToEnum(genderSelected),
        level: LevelService().convertStringToEnum(levelSelected),
        height: double.parse(height.text),
        weight: double.parse(weight.text));
  }

  Future<void> uploadData() async {
    if (!await InternetService().isConnected()) {
      emit(const UploadFailure(
          message: 'No internet!, please your connection and try again'));
      return;
    }
    if (!key.currentState!.validate()) return;
    if (address.country.isEmpty) {
      emit(const UploadFailure(message: 'please bring address'));
    }
    emit(UploadLoading());
    final trainee = initData();
    try {
      _store.doc(trainee.id).set(trainee.toMap());
      emit(UploadSucess());
    } on FirebaseException catch (e) {
      emit(UploadFailure(message: e.toString()));
    }
  }

  Future<AddressModel> _getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    return AddressModel(
        name: placemark.name!,
        postalCode: placemark.postalCode!,
        country: placemark.country!,
        subLocality: placemark.subLocality!,
        locality: placemark.locality!);
  }

  void resetValues() {
    userName.clear();
    age.clear();
    weight.clear();
    height.clear();
    genderSelected = 'male';
    levelSelected = 'intermediate';
    address = AddressModel(
        name: '', postalCode: '', country: '', subLocality: '', locality: '');
  }

  Future<AddressModel> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition();
    return _getAddressFromLatLong(position);
  }
}
