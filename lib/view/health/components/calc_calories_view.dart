import 'package:be_fitness_app/view/health/cubit/health_cubit.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CalcCaloriesView extends StatefulWidget {
  const CalcCaloriesView({super.key});

  @override
  State<CalcCaloriesView> createState() => _CalcCaloriesViewState();
}

class _CalcCaloriesViewState extends State<CalcCaloriesView> {
  late HealthCubit cubit;

  @override
  void initState() {
    cubit = HealthCubit.get(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                customCardInput(context, funMin: () {
                  if (cubit.age > 15) {
                    --cubit.age;
                  }
                }, funAdd: () {
                  if (cubit.age < 80) {
                    ++cubit.age;
                  }
                },
                    value: cubit.age,
                    label: 'AGE',
                    heroAdd: 'age add',
                    heroMin: 'age min'),
                customCardInput(context, funMin: () {
                  if (cubit.weight > 40) {
                    --cubit.weight;
                  }
                }, funAdd: () {
                  if (cubit.weight < 100) {
                    ++cubit.weight;
                  }
                },
                    value: cubit.weight,
                    label: 'WEIGHT',
                    heroAdd: 'weight add',
                    heroMin: 'weight min'),
              ],
            ),
            SizedBox(height: 5.h),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Column(
                  children: [
                    Text(
                      'HEIGHT (CM)',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 13.sp),
                    ),
                    Text(
                      cubit.height.toString().substring(0, 3),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 20.sp),
                    ),
                    Slider(
                      value: cubit.height,
                      onChanged: (value) {
                        cubit.height = value;
                        setState(() {});
                      },
                      min: 130,
                      max: 200,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'GENDER',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 13.sp),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'I\'m',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 24.sp),
                        ),
                        SizedBox(width: 5.w),
                        const Text('female'),
                        SizedBox(width: 1.w),
                        Switch(
                          value: cubit.genderSelected,
                          onChanged: (value) {
                            cubit.genderSelected = value;
                            setState(() {});
                          },
                        ),
                        SizedBox(width: 1.w),
                        const Text('male'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  final result = cubit.calcCalories();
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'BMR RESULT',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                result.toString().substring(0, 4),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 30.sp),
                              ),
                              SizedBox(height: 2.h),
                              const Text('CALORIES / DAY'),
                              SizedBox(height: 4.h),
                              Icon(
                                cubit.genderSelected
                                    ? Icons.male
                                    : Icons.female,
                                size: 50.sp,
                              ),
                              SizedBox(height: 2.h),
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close'))
                            ],
                          ),
                        );
                      });
                },
                child: const Text('Calculate')),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Card customCardInput(BuildContext context,
      {funMin, funAdd, value, label, heroMin, heroAdd}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 13.sp),
            ),
            Text(
              '${value}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.small(
                  heroTag: heroMin,
                  onPressed: () => setState(() => funMin()),
                  child: Text('-',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15.sp)),
                ),
                FloatingActionButton.small(
                  heroTag: heroAdd,
                  onPressed: () => setState(() => funAdd()),
                  child: Text('+',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: 15.sp)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
