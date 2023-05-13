import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

import '../cubit/coach_cubit.dart';

class AddReviewView extends StatefulWidget {
  final String userId;
  const AddReviewView({super.key, required this.userId});

  @override
  State<AddReviewView> createState() => _AddReviewViewState();
}

class _AddReviewViewState extends State<AddReviewView> {
  double valu = 1;
  @override
  Widget build(BuildContext context) {
    final cubit = CoachCubit.get(context);
    return SafeArea(
      child: Column(
        children: [
          Center(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: RatingBar.builder(
                  initialRating: cubit.reviewRate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  glow: false,
                  itemCount: 5,
                  itemSize: 50,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                  onRatingUpdate: (rating) {
                    cubit.reviewRate = rating;
                    setState(() {});
                  },
                )),
          ),
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 3.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: TextField(
                minLines: 3,
                maxLines: 5,
                style: Theme.of(context).textTheme.bodyMedium,
                controller: cubit.descController,
                decoration: const InputDecoration(
                  hintText: 'Review (Optional)',
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  await cubit.uploadReview(widget.userId).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: const Text('Send')),
          ),
        ],
      ),
    );
  }
}
