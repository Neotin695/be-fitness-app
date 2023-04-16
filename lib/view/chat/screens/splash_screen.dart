import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../components/video_background_widget.dart';
import '../../../../../core/appconstance/app_constance.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  isMute ? Icons.volume_off_outlined : Icons.volume_up_outlined,
                  color: Colors.white,
                )),
          ),
          formWidget()
        ],
      ),
    );
  }

  formWidget() {
    return Column(
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
          onPressed: () {},
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
}
