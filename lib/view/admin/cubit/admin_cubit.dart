import 'package:be_fitness_app/core/appconstance/app_constance.dart';
import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/target_muscles.dart';
import 'package:be_fitness_app/core/service/internet_service.dart';
import 'package:be_fitness_app/models/excercise_model.dart';
import 'package:be_fitness_app/models/request_online_coach.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  static AdminCubit get(context) => BlocProvider.of(context);
  AdminCubit() : super(AdminInitial());

  final _store = FirebaseFirestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController excerciseName = TextEditingController();
  final TextEditingController gifUrl = TextEditingController();

  String selectedBodyPart = 'body part';
  String selectedTargetMuscles = 'target muscles';

  bool isSelected() =>
      selectedBodyPart != 'body part' &&
      selectedTargetMuscles != 'target muscles' &&
      selectedTime != defaultTime;

  Duration selectedTime = const Duration(seconds: 0);
  Duration defaultTime = const Duration(seconds: 0);

  Future<void> uploadExcercise() async {
    emit(UploadingExcercise());
    if (formKey.currentState!.validate()) {}
    if (!await InternetService().isConnected()) {
      emitFailure();
      return;
    }
    await _store
        .collection(LogicConst.excercises)
        .doc(LogicConst.excercise)
        .collection(selectedBodyPart)
        .doc()
        .set(initModel().toMap());
    emit(UploadedExcercise());
    resetData();
  }

  ExcerciseModel initModel() {
    return ExcerciseModel(
        gifUrl: gifUrl.text,
        name: excerciseName.text,
        targetMuscles:
            TargetMusclesService().convertStringToEnum(selectedTargetMuscles),
        timer: [selectedTime.inMinutes, selectedTime.inSeconds]);
  }

  void resetData() {
    selectedBodyPart = 'body part';
    selectedTargetMuscles = 'target muscles';
    selectedTime = const Duration(seconds: 0);
    excerciseName.clear();
    gifUrl.clear();
  }

  Future<void> fetchRequests() async {
    emit(LoadingRequestState());
    List<RequestOnlineCoachModel> tempRequests = [];
    if (!await isConnected) {
      emitFailure();
      return;
    }
    try {
      _store.collection(LogicConst.requests).get().then((value) {
        for (var doc in value.docs) {
          tempRequests.add(RequestOnlineCoachModel.fromMap(doc.data()));
          //print(doc.data());
        }
        emit(FetchRequestsState(requests: tempRequests));
      });
    } on FirebaseException catch (e) {
      emit(FailureState(message: e.toString()));
    } catch (e) {
      emit(FailureState(message: e.toString()));
    }
  }

  Future<bool> get isConnected async => await InternetService().isConnected();

  Future<void> accepteRequest(id) async {
    if (!await isConnected) {
      emitFailure();
      return;
    }
    _store.collection(LogicConst.requests).doc(id).delete();
    await _store
        .collection(LogicConst.users)
        .doc(id)
        .update({LogicConst.state: true});
    await _store
        .collection(LogicConst.tempUser)
        .doc(id)
        .update({LogicConst.status: LogicConst.authenticate});
    try {
      await FirebaseStorage.instance.ref(id).delete();

      emit(RejectRequest());
    } on FirebaseException catch (e) {
      emit(FailureState(message: e.toString()));
    } catch (e) {
      emit(FailureState(message: e.toString()));
    }
    emit(AccepteRequest());
  }

  void emitFailure() {
    return emit(const FailureState(message: AppConst.noInternet));
  }

  Future<void> rejectRequest(id) async {
    if (!await isConnected) {
      emitFailure();
      return;
    }
    await _store
        .collection(LogicConst.tempUser)
        .doc(id)
        .update({LogicConst.status: LogicConst.newTxt});
    await _store.collection(LogicConst.users).doc(id).delete();
    await _store.collection(LogicConst.requests).doc(id).delete();
    try {
      await FirebaseStorage.instance.ref(id).delete();

      emit(RejectRequest());
    } on FirebaseException catch (e) {
      emit(FailureState(message: e.toString()));
    } catch (e) {
      emit(FailureState(message: e.toString()));
    }
  }
}
