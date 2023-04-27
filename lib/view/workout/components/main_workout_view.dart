import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../screens/excercises_page.dart';

class MainWorkoutView extends StatefulWidget {
  const MainWorkoutView({super.key});

  @override
  State<MainWorkoutView> createState() => _MainWorkoutViewState();
}

class _MainWorkoutViewState extends State<MainWorkoutView> {
  @override
  Widget build(BuildContext context) {
    //WorkoutCubit cubit = WorkoutCubit.get(context);
    return Container(
      height: 100.h,
      margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: ListView.builder(
          itemCount: LogicConst.bodyPart.length,
          itemBuilder: (conext, index) {
            final bodyPart = LogicConst.bodyPart[index];
            final image = MediaConst.images[index];
            return Column(
              children: [
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  title: Text(
                    bodyPart,
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  trailing: const Icon(Icons.arrow_forward_outlined),
                  onTap: () {
                    Navigator.pushNamed(context, ExcercisePage.routeName,
                        arguments: [bodyPart, index]);
                  },
                ),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
