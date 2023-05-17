import 'package:be_fitness_app/core/sharedwidget/custom_button.dart';
import 'package:be_fitness_app/view/auth/screens/auth_signup_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../core/service/decisions_tree.dart';
import '../../../core/sharedwidget/custom_paint.dart';
import '../../getstarted/screens/getstarted_page.dart';
import '../../home/screens/home_layout_page.dart';
import '../cubit/auth_cubit.dart';

class AuthSignInView extends StatefulWidget {
  const AuthSignInView({super.key});

  @override
  State<AuthSignInView> createState() => _AuthSignInViewState();
}

class _AuthSignInViewState extends State<AuthSignInView> {
  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSucess) {
        } else if (state is AuthFailure) {
          showErrorMessage(context, state);
        } else if (state is AuthLoading) {}
      },
      child: SafeArea(
        child: Form(
          key: cubit.formKeySignIn,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              customImageBackground(context),
              rectangleDig(width: -160.w, height: -14.h),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: InputDecoration(
                            labelStyle:
                                TextStyle(fontSize: 16.sp, color: Colors.white),
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
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(fontSize: 15.sp),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await cubit.signInWithGoogle().then((value) =>
                                  Navigator.pushReplacementNamed(
                                      context, DecisionsTree.routeName));
                            },
                            icon: SvgPicture.asset(
                                'assets/icons/google_button.svg')),
                        SizedBox(width: 4.w),
                        BeButton(
                          onPressed: () async {
                            await cubit.signInWithEmail().then((value) =>
                                Navigator.pushReplacementNamed(
                                    context, DecisionsTree.routeName));
                          },
                          radius: 30,
                          text: 'Sign In',
                          icon: SvgPicture.asset(MediaConst.arrow),
                          width: 40.w,
                          hegiht: 7.h,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        SizedBox(width: 5.w),
                      ],
                    )
                  ],
                ),
              ))
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
            child: Image.asset('assets/images/background_login.png',
                width: double.infinity, fit: BoxFit.cover, height: 45.h)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                        'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ))),
              SizedBox(width: 3.w),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AuthSignUpPage.routeName);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  )),
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
