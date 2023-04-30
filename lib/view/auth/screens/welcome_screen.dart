import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../components/auth_view.dart';
import '../components/video_background_widget.dart';
import '../cubit/auth_cubit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = 'welcome screen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
                  if (mounted) {
                    setState(() {
                      isMute = !isMute ? true : false;
                    });
                  }
                },
                icon: Icon(
                  isMute ? Icons.volume_off_outlined : Icons.volume_up_outlined,
                  color: Colors.white,
                )),
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
            child: const FormWidget(),
          )
        ],
      ),
    );
  }
}
