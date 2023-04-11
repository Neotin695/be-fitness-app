import 'package:be_fitness_app/core/service/internet_service.dart';
import 'package:be_fitness_app/models/request_online_coach.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  static AdminCubit get(context) => BlocProvider.of(context);
  AdminCubit() : super(AdminInitial());

  final _store = FirebaseFirestore.instance;

  Future<void> fetchRequests() async {
    emit(LoadingRequestState());
    List<RequestOnlineCoachModel> tempRequests = [];
    if (!await isConnected) {
      emitFailure();
      return;
    }
    try {
      _store.collection('requests').get().then((value) {
        for (var doc in value.docs) {
          tempRequests.add(RequestOnlineCoachModel.fromMap(doc.data()));
          //print(doc.data());
        }
        emit(FetchRequestsState(requests: tempRequests));
      });
    } on FirebaseException catch (e) {
      emit(FailureFetchRequests(message: e.toString()));
    } catch (e) {
      emit(FailureFetchRequests(message: e.toString()));
    }
  }

  Future<bool> get isConnected async => await InternetService().isConnected();

  Future<void> accepteRequest(id) async {
    if (!await isConnected) {
      emitFailure();
      return;
    }
    _store.collection('requests').doc(id).delete();
    await _store.collection('coachs').doc(id).update({'state': true});
     await _store.collection('tempuser').doc(id).update({'status': 'authenticate'});
    emit(AccepteRequest());
  }

  void emitFailure() {
    return emit(const FailureFetchRequests(
        message:
            'no internet connection!, please check you internet and try again'));
  }

  Future<void> rejectRequest(id) async {
    if (!await isConnected) {
      emitFailure();
      return;
    }
    await _store.collection('tempuser').doc(id).update({'status': 'new'});
    await _store.collection('coachs').doc(id).delete();
    _store.collection('requests').doc(id).delete();
    emit(RejectRequest());
  }
}
