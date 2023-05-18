import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/view/health/cubit/health_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:sizer/sizer.dart';

class HealthView extends StatefulWidget {
  const HealthView({super.key});

  @override
  State<HealthView> createState() => _HealthViewState();
}

class _HealthViewState extends State<HealthView> {
  bool found = false;
  @override
  Widget build(BuildContext context) {
    final cubit = HealthCubit.get(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 1.5.h,
          ),
          child: Column(
            children: [
              SizedBox(height: 2.h),
              Text(
                'Calculate what you eat',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3.h,
                ),
                child: TextField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 13.sp),
                  controller: cubit.searchController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                      hintText: 'Search',
                      suffixIcon: InkWell(
                        child: const Icon(Icons.search),
                        onTap: () async {
                          if (cubit.searchController.text.isNotEmpty) {
                            await cubit.searchNutrient().then((value) {
                              value.fold((l) => found = l,
                                  (r) => cubit.healthModel = r);
                            });
                            cubit.updateValue();
                            cubit.searchController.clear();
                            setState(() {});
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(height: 3.h),
              cubit.healthModel != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          title: Text(cubit.healthModel!.cautions.toString()),
                        ),
                        ListTile(
                          title: const Text('Calories'),
                          trailing: progress(cubit.calories),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                              'Fat (${cubit.healthModel!.totalNuration.fat.unit})'),
                          subtitle: Text(
                            'Fat (${cubit.healthModel!.totalNuration.fat.label})',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: progress(cubit.fat),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                              'Procnt (${cubit.healthModel!.totalNuration.procnt.unit})'),
                          subtitle: Text(
                            'Fat (${cubit.healthModel!.totalNuration.procnt.label})',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: progress(cubit.procnt),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                              'chole (${cubit.healthModel!.totalNuration.chole.unit})'),
                          subtitle: Text(
                            'Fat (${cubit.healthModel!.totalNuration.chole.label})',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: progress(cubit.chole),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                              'NA (${cubit.healthModel!.totalNuration.na.unit})'),
                          subtitle: Text(
                            'Fat (${cubit.healthModel!.totalNuration.na.label})',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: progress(cubit.na),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                              'CA (${cubit.healthModel!.totalNuration.ca.unit})'),
                          subtitle: Text(
                            'Fat (${cubit.healthModel!.totalNuration.ca.label})',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: progress(cubit.ca),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                              'ZN (${cubit.healthModel!.totalNuration.zn.unit})'),
                          subtitle: Text(
                            'Fat (${cubit.healthModel!.totalNuration.zn.label})',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: progress(cubit.zn),
                        ),
                        const Divider(),
                        ListTile(
                          title: Text(
                              'Chocdf (${cubit.healthModel!.totalNuration.chocdf.unit})'),
                          subtitle: Text(
                            'Fat (${cubit.healthModel!.totalNuration.chocdf.label})',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          trailing: progress(cubit.chocdf),
                        ),
                        const Divider(),
                      ],
                    )
                  : Center(
                      child: SvgPicture.asset(
                        MediaConst.empty,
                        width: 20.w,
                        height: 20.h,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget progress(notifier) {
    return SimpleCircularProgressBar(
      size: 40.sp,
      progressStrokeWidth: 5,
      animationDuration: 3,
      valueNotifier: notifier,
      maxValue: notifier.value,
      mergeMode: true,
      onGetText: (double value) {
        TextStyle centerTextStyle = TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
          color: Colors.greenAccent,
        );

        return Text(
          '${value.toInt()}',
          style: centerTextStyle,
        );
      },
    );
  }
}
