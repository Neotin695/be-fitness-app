// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signIn() async {
    try {
      final auth = await signInWithGoogle();
      if (auth.additionalUserInfo != null) {
        emit(AuthSucess(isNewUser: auth.additionalUserInfo!.isNewUser));
      } else {
        emit(const AuthFailure(
            messsage: 'somthing wont wrong! please try again later'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(messsage: e.toString()));
    } on PlatformException catch (e) {
      emit(AuthFailure(messsage: e.toString()));
    } catch (e) {
      emit(AuthFailure(messsage: e.toString()));
    }
  }
}
