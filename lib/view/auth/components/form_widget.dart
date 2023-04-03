import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/app_constance.dart';
import '../../getstarted/screens/getstarted_screen.dart';
import '../../home/screens/home_layout.dart';
import '../cubit/auth_cubit.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSucess) {
          if (state.isNewUser) {
            getStarted(context);
          } else {
            gotoHome(context);
          }
        } else if (state is AuthFailure) {
          showErrorMessage(context, state).show();
        }
      },
      child: Column(
        children: [
          Expanded(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppConstance.LOGO_TEXT,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  AppConstance.SUBTITLE_LOGO,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      letterSpacing: 2),
                ),
              ],
            ),
          )),
          ElevatedButton(
            onPressed: () => getStarted(context),
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(80.w, 6.h))),
            child: const Text('START'),
          ),
          SizedBox(height: 4.h),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 28.w,
                  child: const Divider(
                    color: Colors.white54,
                    thickness: 1,
                  ),
                ),
                const Center(
                    child: Text(
                  'Already our user?',
                  style: TextStyle(color: Colors.white54),
                )),
                SizedBox(
                    width: 28.w,
                    child: const Divider(
                      color: Colors.white54,
                      thickness: 1,
                    )),
              ],
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                await cubit.signIn();
              },
              icon: const Icon(Icons.login),
              label: const Text('SignIn With Google')),
          SizedBox(height: 5.h)
        ],
      ),
    );
  }

  AwesomeDialog showErrorMessage(BuildContext context, AuthFailure state) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: state.messsage,
      btnCancelOnPress: () {},
    );
  }

  void getStarted(context) {
    Navigator.pushNamed(context, GetStartedScreen.routeName);
    
  }

  void gotoHome(context) {
    Navigator.pushReplacementNamed(context, HomeLayoutScreen.routeName);
  }
}
