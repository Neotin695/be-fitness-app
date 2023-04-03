// ignore: depend_on_referenced_packages
import 'package:be_fitness_app/core/service/internet_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  static AuthCubit get(context) => BlocProvider.of(context);
  AuthCubit() : super(AuthInitial());
  Future<UserCredential> _signInWithGoogle() async {
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
    bool isConnected = await InternetService().isConnected();
    print(isConnected);
    if (!isConnected) {
      emit(const AuthFailure(
          messsage:
              'No internet!, Please check your connection and try agian'));
      return;
    }
    try {
      final auth = await _signInWithGoogle();
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
