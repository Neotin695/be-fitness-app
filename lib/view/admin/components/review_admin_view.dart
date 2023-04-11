import 'package:be_fitness_app/models/request_online_coach.dart';
import 'package:be_fitness_app/view/admin/view/main_admin_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../cubit/admin_cubit.dart';

class ReviewAdminView extends StatelessWidget {
  final RequestOnlineCoachModel request;
  const ReviewAdminView({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 3.h),
              CarouselSlider(
                options: CarouselOptions(height: 30.h),
                items: [
                  request.personalImg,
                  request.certificateIdImg,
                  request.nationalIdBakcImg,
                  request.nationalIdFrontImg
                ].map((img) {
                  return CachedNetworkImage(
                    imageUrl: img,
                    placeholder: (_, url) => SizedBox(
                        height: 10.h,
                        width: 10.w,
                        child: const CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  );
                }).toList(),
              ),
              SizedBox(height: 2.h),
              customContainerWidget(request, [
                Text('Nmae: ${request.fulName}',
                    style: TextStyle(fontSize: 17.sp)),
                const Divider(),
                Text('BirthDate: ${request.birthDate}',
                    style: TextStyle(fontSize: 17.sp)),
              ]),
              SizedBox(height: 2.h),
              customContainerWidget(request, [
                Text(
                    'Address: ${request.address.name}, ${request.address.country}, ${request.address.locality}, ${request.address.postalCode},',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.sp)),
              ]),
              SizedBox(height: 2.h),
              customContainerWidget(request, [
                Text('National Id: ${request.nationalId}',
                    style: TextStyle(fontSize: 17.sp)),
                const Divider(),
                Text('Certificate Id: ${request.certificateId}',
                    style: TextStyle(fontSize: 17.sp)),
              ]),
              SizedBox(height: 2.h),
              buttonSection(context, cubit, request),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<AdminCubit, AdminState> buttonSection(
      BuildContext context, AdminCubit cubit, RequestOnlineCoachModel request) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (state is AccepteRequest) {
        } else if (state is RejectRequest) {}
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  cubit.accepteRequest(request.userId).then((value) {
                    Navigator.pushReplacementNamed(
                        context, MainAdminPage.routeName);
                  });
                },
                icon: const Icon(Icons.done),
                label: const Text('Confirm'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  cubit.rejectRequest(request.userId).then((value) {
                    Navigator.pushReplacementNamed(
                        context, MainAdminPage.routeName);
                  });
                },
                icon: const Icon(Icons.close),
                label: const Text('Decline'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  customContainerWidget(RequestOnlineCoachModel request, List<Widget> widgets) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Column(
        children: widgets,
      ),
    );
  }
}
