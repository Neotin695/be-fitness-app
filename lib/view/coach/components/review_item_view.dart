import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../models/review_model.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;
  const ReviewItem({
    super.key, required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(review.profilePhoto),
                radius: 20,
              ),
              SizedBox(width: 2.w),
              Text(review.userName),
              const Spacer(),
              Text(review.date),
            ],
          ),
          Text(review.discriptionReview),
        ],
      ),
    );
  }
}