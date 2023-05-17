import 'dart:ui';

import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/target_muscles.dart';
import 'package:be_fitness_app/models/excercise_model.dart';
import 'package:be_fitness_app/view/musicplayer/screens/music_player_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gif_view/gif_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class ExcerciseView extends StatefulWidget {
  final List<dynamic> arguments;
  const ExcerciseView({super.key, required this.arguments});

  @override
  State<ExcerciseView> createState() => _ExcerciseViewState();
}

class _ExcerciseViewState extends State<ExcerciseView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('excercises')
          .doc('excercise')
          .collection(collectionName())
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return Stack(
            children: [
              Image.asset(
                MediaConst.images[index()],
                width: double.infinity,
                height: 100.h,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(
                  height: 100.h,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: 100.h,
                child: ListView(
                  children: snapshot.data!.docs.map(
                    (e) {
                      final excercise = ExcerciseModel.fromMap(
                          e.data() as Map<String, dynamic>);
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MusicPlayerPage.routeName,
                              arguments: [index(), excercise]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                child: GifView.network(
                                  excercise.gifUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  colorBlendMode: BlendMode.darken,
                                  height: 30.h,
                                  color: const Color.fromARGB(108, 0, 0, 0),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 3.w,
                                      bottom: 1.h,
                                      right: 3.w,
                                    ),
                                    child: Text(
                                      excercise.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 18.sp),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 3.w,
                                      bottom: 1.h,
                                      right: 3.w,
                                    ),
                                    child: Text(
                                      TargetMusclesService()
                                          .convertEnumToString(
                                              excercise.targetMuscles),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 18.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
                color: Theme.of(context).colorScheme.surfaceTint, size: 35.sp),
          );
        }
        return Center(
          child: SvgPicture.asset(
            MediaConst.empty,
            width: 30.w,
            height: 30.h,
          ),
        );
      }),
    );
  }

  collectionName() => widget.arguments[0];

  int index() => int.parse(widget.arguments[1].toString());
}
