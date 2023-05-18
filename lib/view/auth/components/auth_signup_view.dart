import 'package:be_fitness_app/core/service/decisions_tree.dart';
import 'package:be_fitness_app/view/auth/screens/auth_sign_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../core/sharedwidget/custom_button.dart';
import '../../../core/sharedwidget/custom_paint.dart';
import '../../getstarted/screens/getstarted_page.dart';
import '../../home/screens/home_layout_page.dart';
import '../cubit/auth_cubit.dart';

class AuthSignUpView extends StatefulWidget {
  const AuthSignUpView({super.key});

  @override
  State<AuthSignUpView> createState() => _AuthSignUpViewState();
}

class _AuthSignUpViewState extends State<AuthSignUpView> {
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSucess) {
          Navigator.pop(context);
          if (cubit.formKeySignUp.currentState!.validate()) {
            Navigator.pushReplacementNamed(context, AuthSignInPage.routeName);
          }
        } else if (state is AuthFailure) {
          Navigator.pop(context);
          showErrorMessage(context, state);
        } else if (state is AuthLoading) {
          CoolAlert.show(context: context, type: CoolAlertType.loading);
        }
      },
      child: SafeArea(
        child: Form(
          key: cubit.formKeySignUp,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              customImageBackground(context),
              rectangleDig(width: -160.w, height: -14.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: TextFormField(
                          controller: cubit.email,
                          style: Theme.of(context).textTheme.bodyMedium,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'invalid email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: TextFormField(
                          controller: cubit.password,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.visibility,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context).textTheme.bodyMedium,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontSize: 16.sp, color: Colors.white),
                              labelText: 'Password',
                              suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      cubit.visibility = !cubit.visibility;
                                    });
                                  },
                                  child: Icon(cubit.visibility
                                      ? Icons.visibility
                                      : Icons.visibility_off))),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.w),
                        child: TextFormField(
                          controller: cubit.userName,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your username';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
                            labelText: 'UserName',
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await cubit.signInWithGoogle().then((value) =>
                                    Navigator.pushReplacementNamed(
                                        context, DecisionsTree.routeName));
                              },
                              icon: SvgPicture.asset(MediaConst.google)),
                          SizedBox(width: 4.w),
                          BeButton(
                            onPressed: () async =>
                                await cubit.signUpWithEmail().then((value) {}),
                            radius: 30,
                            icon: SvgPicture.asset(MediaConst.arrow),
                            width: 40.w,
                            text: 'Sign Up',
                            hegiht: 7.h,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          SizedBox(width: 7.w),
                        ],
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customImageBackground(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                    Colors.black,
                    Colors.transparent,
                  ],
                  stops: [
                    0,
                    0.3,
                    1,
                    1
                  ]).createShader(
                Rect.fromLTRB(
                  0,
                  0,
                  0,
                  rect.width,
                ),
              );
            },
            blendMode: BlendMode.dstATop,
            child: Image.asset('assets/images/background_signup.png',
                width: double.infinity, fit: BoxFit.cover, height: 45.h)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AuthSignInPage.routeName);
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  )),
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              width: 3))),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ))),
              SizedBox(width: 3.w),
            ],
          ),
        )
      ],
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
    Navigator.pushReplacementNamed(context, HomeLayoutPage.routeName);
  }
}
