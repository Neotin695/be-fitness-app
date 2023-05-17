// ignore: depend_on_referenced_packages
import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/service/internet_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static AuthCubit get(context) => BlocProvider.of(context);

  AuthCubit() : super(AuthInitial());

  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKeySignIn = GlobalKey();
  final GlobalKey<FormState> formKeySignUp = GlobalKey();

  final store = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  final auth = FirebaseAuth.instance;

  bool visibility = true;

  Future<void> signInWithEmail() async {
    bool isConnected = await InternetService().isConnected();
    if (!isConnected) {
      emit(const AuthFailure(
          message: 'No internet!, Please check your connection and try agian'));
      return;
    }
    if (!formKeySignIn.currentState!.validate()) {
      return;
    }
    emit(AuthLoading());
    await auth.signInWithEmailAndPassword(
        email: email.text, password: password.text);
    emit(const AuthSucess(isNewUser: false));
  }

  Future<void> signUpWithEmail() async {
    print('clicked');
    bool isConnected = await InternetService().isConnected();
    if (!isConnected) {
      emit(const AuthFailure(
          message: 'No internet!, Please check your connection and try agian'));
      return;
    }
    if (!formKeySignUp.currentState!.validate()) {
      return;
    }
    emit(AuthLoading());
    final UserCredential login = await auth.createUserWithEmailAndPassword(
        email: email.text, password: password.text);
    await auth.currentUser!.updateDisplayName(userName.text);
    if (login.additionalUserInfo!.isNewUser) {
      initUser(login.user!.uid);
      emit(AuthSucess(isNewUser: login.additionalUserInfo!.isNewUser));
    }
    emit(const AuthSucess(isNewUser: true));
  }

  Future<UserCredential> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    bool isConnected = await InternetService().isConnected();
    if (!isConnected) {
      emit(const AuthFailure(
          message: 'No internet!, Please check your connection and try agian'));
      return;
    }
    try {
      final auth = await _signInWithGoogle();
      if (auth.additionalUserInfo != null &&
          auth.additionalUserInfo!.isNewUser) {
        initUser(auth.user!.uid);
        emit(AuthSucess(isNewUser: auth.additionalUserInfo!.isNewUser));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.toString()));
    } on PlatformException catch (e) {
      emit(AuthFailure(message: e.toString()));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> initUser(uid) async {
    FirebaseFirestore.instance
        .collection(LogicConst.tempUser)
        .doc(uid)
        .set({LogicConst.status: LogicConst.newTxt});
  }
}
