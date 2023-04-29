import 'package:be_fitness_app/core/service/interfaces/serivce_mixin.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/models/trainee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/profile_coach_view.dart';
import '../components/profile_trainee_view.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> with PickMedia {
  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileCubit() : super(ProfileInitial());
  final store = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance.currentUser!;

  String imagePath = '';

  Either<CoachModel, TraineeModel> _checkUser(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    try {
      if (data.containsKey('isCoach') && data['isCoach'] == true) {
        return Left(CoachModel.fromMap(data));
      } else {
        return Right(TraineeModel.fromMap(data));
      }
    } catch (e) {
      rethrow;
    }
  }

  Widget checkUserType(DocumentSnapshot snapshot) {
    return _checkUser(snapshot).fold((l) => ProfileCoachView(coachModel: l),
        (r) => ProfileTraineeView(traineeModel: r));
  }

  Future<String> uploadProfilePhoto() async {
    final task = await uploadSingleFile(imagePath, _storage.ref(auth.uid));
    if (task.state == TaskState.running) {
      emit(UploadingDataState());
      return '';
    } else if (task.state == TaskState.error) {
      emit(const UploadFailureState(
          message: ' somthing went wrong!, please try again later'));
      return '';
    }
    emit(UploadSuccess());
    return await task.ref.getDownloadURL();
  }
}
