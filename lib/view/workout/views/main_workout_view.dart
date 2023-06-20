import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../pages/excercises_page.dart';

class MainWorkoutView extends StatefulWidget {
  const MainWorkoutView({super.key});

  @override
  State<MainWorkoutView> createState() => _MainWorkoutViewState();
}

class _MainWorkoutViewState extends State<MainWorkoutView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text('WELCOME TO BE FITNESS,',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Text('Good Morning',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 18.sp)),
        ),
        SizedBox(height: 3.h),
        ListTile(
          title: Text('Workout Categories', style: TextStyle(fontSize: 15.sp)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: LogicConst.bodyPart.length,
            itemBuilder: (conext, index) {
              final bodyPart = LogicConst.bodyPart[index];
              final image = MediaConst.images[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ExcercisePage.routeName,
                      arguments: [bodyPart, index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Image.asset(
                          image,
                          color: Colors.black38,
                          colorBlendMode: BlendMode.darken,
                          width: double.infinity,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 3.h),
                          child: Text(
                            bodyPart,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20.sp),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
