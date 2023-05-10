import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/appconstance/media_constance.dart';
import '../../../models/review_model.dart';

class ReviewItem extends StatelessWidget {
  final ReviewModel review;
  const ReviewItem({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                review.profilePhoto.isEmpty
                    ? const CircleAvatar(
                        foregroundImage: AssetImage(MediaConst.person),
                        radius: 20,
                      )
                    : CircleAvatar(
                        foregroundImage: NetworkImage(review.profilePhoto),
                        radius: 20,
                      ),
                SizedBox(width: 2.w),
                Text(review.userName),
                const Spacer(),
                Text(review.date),
              ],
            ),
            SizedBox(height: 5.h),
            Text(review.discriptionReview),
          ],
        ),
      ),
    );
  }
}
