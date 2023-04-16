import 'package:cool_alert/cool_alert.dart';
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
        } else if (state is AuthFailure) {
          showErrorMessage(context, state);
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
                  AppConst.brandTxt,
                  style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  AppConst.subTitleLogo,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      letterSpacing: 2),
                ),
              ],
            ),
          )),
          ElevatedButton.icon(
              onPressed: () async {
                await cubit.signIn();
              },
              icon: const Icon(Icons.login),
              label: const Text('SignIn With Google')),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  void showErrorMessage(BuildContext context, AuthFailure state) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: 'Error',
      text: state.message,
      onCancelBtnTap: () => Navigator.pop(context),
    );
  }

  void getStarted(context) {
    Navigator.pushNamed(context, GetStartedScreen.routeName);
  }

  void gotoHome(context) {
    Navigator.pushReplacementNamed(context, HomeLayoutScreen.routeName);
  }
}
