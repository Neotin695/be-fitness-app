import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../components/video_background_widget.dart';
import '../../../../../core/appconstance/app_constance.dart';
import '../cubit/auth_cubit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSucess) {
              if (state.isNewUser) {
                getStarted();
              } else {
                gotoHome();
              }
            } else if (state is AuthFailure) {
              showErrorMessage(context, state).show();
            }
          },
          child: Stack(
            children: [
              BackgroundVideoPlayer(
                isMute: isMute,
              ),
              Container(color: Colors.black54),
              Positioned(
                top: 20,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        isMute = !isMute ? true : false;
                      });
                    },
                    icon: Icon(
                      isMute
                          ? Icons.volume_off_outlined
                          : Icons.volume_up_outlined,
                      color: Colors.white,
                    )),
              ),
              formWidget(context)
            ],
          ),
        ),
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

  formWidget(ctx) {
    return Column(
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
          onPressed: () {},
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
        TextButton(
          onPressed: () => onPressed(ctx),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Continue with your existing account',
                style: TextStyle(fontSize: 10),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 10,
              )
            ],
          ),
        ),
        SizedBox(height: 5.h)
      ],
    );
  }

  void getStarted() {}

  void gotoHome() {}

  void onPressed(BuildContext ctx) {
    showBottomSheet<void>(
        context: ctx,
        builder: (_) {
          return Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.black26),
            height: 20.h,
            child: Center(
              child: ElevatedButton.icon(
                  onPressed: () async {
                    await context.read<AuthCubit>().signIn();
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('SignIn With Google')),
            ),
          );
        });
  }
}
