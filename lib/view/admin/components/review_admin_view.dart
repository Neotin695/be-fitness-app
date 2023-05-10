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
        child: Column(
          children: [
            SizedBox(height: 3.h),
            CarouselSlider(
              options: CarouselOptions(height: 40.h),
              items: [
                request.personalImg,
                request.certificateIdImg,
                request.nationalIdBakcImg,
                request.nationalIdFrontImg
              ].map((img) {
                return CachedNetworkImage(
                  imageUrl: img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (_, url) => SizedBox(
                      height: 10.h, child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                );
              }).toList(),
            ),
            SizedBox(height: 2.h),
            ListTile(
              title: Text(request.fulName, style: TextStyle(fontSize: 17.sp)),
              subtitle: Text(request.birthDate,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 13.sp)),
            ),
            const Divider(),
            const Divider(),
            ListTile(
              title: Text(
                  '${request.address.name}, ${request.address.country}, ${request.address.locality}, ${request.address.postalCode},',
                  style: TextStyle(fontSize: 17.sp)),
              subtitle: Text('Address',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 12.sp)),
            ),
            const Divider(),
            ListTile(
              title: Text(request.certificateId,
                  style: TextStyle(fontSize: 17.sp)),
              subtitle: Text('Certificate Number',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 12.sp)),
            ),
            const Divider(),
            ListTile(
              title:
                  Text(request.nationalId, style: TextStyle(fontSize: 17.sp)),
              subtitle: Text('National Id Number',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 12.sp)),
            ),
            const Divider(),
            SizedBox(height: 2.h),
            buttonSection(context, cubit, request),
          ],
        ),
      ),
    );
  }

  Widget buttonSection(
      BuildContext context, AdminCubit cubit, RequestOnlineCoachModel request) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: 'accepted',
            onPressed: () {
              cubit.accepteRequest(request.userId).then((value) {
                Navigator.pop(context);
              });
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            child: const Icon(Icons.done),
          ),
          FloatingActionButton(
            heroTag: 'reject',
            onPressed: () {
              cubit.rejectRequest(request.userId).then((value) {
                Navigator.pop(context);
              });
            },
            child: const Icon(Icons.close),
          )
        ],
      ),
    );
  }
}
