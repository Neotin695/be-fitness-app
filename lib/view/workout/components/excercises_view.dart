import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/core/service/enumservice/target_muscles.dart';
import 'package:be_fitness_app/models/excercise_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart';

import '../screens/play_excercise_page.dart';

class ExcerciseView extends StatefulWidget {
  final List<dynamic> arguments;
  const ExcerciseView({super.key, required this.arguments});

  @override
  State<ExcerciseView> createState() => _ExcerciseViewState();
}

class _ExcerciseViewState extends State<ExcerciseView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('excercises')
          .doc('excercise')
          .collection(collectionName())
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final firstExcercise = ExcerciseModel.fromMap(
              snapshot.data!.docs.first.data() as Map<String, dynamic>);

          return Stack(
            children: [
              Image.asset(
                MediaConst.images[index()],
                width: double.infinity,
                height: 50.h,
                fit: BoxFit.cover,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 30.h,
                      color: Colors.transparent,
                    ),
                    Container(
                      color: Colors.white,
                      height: 15.h,
                      child: Card(
                        elevation: 4,
                        child: Center(
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: GifView.network(
                                firstExcercise.gifUrl,
                                width: 30.w,
                                height: 30.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(firstExcercise.name),
                            trailing: const Icon(Icons.arrow_forward_rounded),
                            subtitle: Text(TargetMusclesService()
                                .convertEnumToString(
                                    firstExcercise.targetMuscles)),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PlayExcercisePage.routeName,
                                  arguments: firstExcercise);
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 100.h,
                      child: Card(
                        elevation: 6,
                        child: ListView(
                          children: snapshot.data!.docs.map((e) {
                            final excercise = ExcerciseModel.fromMap(
                                e.data() as Map<String, dynamic>);
                            return firstExcercise != excercise
                                ? Column(
                                    children: [
                                      ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: GifView.network(
                                            excercise.gifUrl,
                                            width: 20.w,
                                            height: 20.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: Text(excercise.name),
                                        subtitle: Text(TargetMusclesService()
                                            .convertEnumToString(
                                                excercise.targetMuscles)),
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              PlayExcercisePage.routeName,
                                              arguments: excercise);
                                        },
                                      ),
                                      const Divider(),
                                    ],
                                  )
                                : const SizedBox();
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Center(
            child: SvgPicture.asset(
          MediaConst.empty,
          width: 30.w,
          height: 30.h,
        ));
      }),
    );
  }

  collectionName() => widget.arguments[0];

  int index() => int.parse(widget.arguments[1].toString());
}
