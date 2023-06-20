import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/models/coach_model.dart';
import 'package:be_fitness_app/view/coach/views/review_item_view.dart';
import 'package:be_fitness_app/view/coach/cubit/coach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:sizer/sizer.dart';

import '../../../models/review_model.dart';
import '../pages/add_review_page.dart';

class DisplayReviewsView extends StatefulWidget {
  final CoachModel coach;

  const DisplayReviewsView({super.key, required this.coach});

  @override
  State<DisplayReviewsView> createState() => _DisplayReviewsViewState();
}

class _DisplayReviewsViewState extends State<DisplayReviewsView> {
  bool isFirst = true;

  @override
  void dispose() {
    isFirst = true;
    super.dispose();
  }

  double totalRate = 0;

  @override
  Widget build(BuildContext context) {
    final cubit = CoachCubit.get(context);
    return StreamBuilder(
      stream: cubit.store
          .collection(LogicConst.users)
          .doc(widget.coach.id)
          .collection(LogicConst.reviews)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<ReviewModel> reviews = List.from(snapshot.data!.docs
              .map((doc) => ReviewModel.fromMap(doc.data())));

          if (isFirst) {
            var rates = reviews.map<double>((e) {
              return e.rate;
            }).toList();

            for (var element in rates) {
              totalRate += element;
            }
            cubit.ratingSummary(reviews);
            isFirst = false;
          }
          return Column(
            children: [
              Visibility(
                visible: reviews.isNotEmpty,
                child: Expanded(
                  child: RatingSummary(
                    counter: reviews.length,
                    average: (totalRate / reviews.length),
                    showAverage: true,
                    counterFiveStars: cubit.fiveStar,
                    counterFourStars: cubit.fourStar,
                    counterThreeStars: cubit.threeStar,
                    counterTwoStars: cubit.twoStar,
                    counterOneStars: cubit.oneStar,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: reviews.map<Widget>((review) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      child: ReviewItem(
                        review: review,
                      ),
                    );
                  }).toList(),
                ),
              ),
              Visibility(
                visible: !alreadyReview(reviews, cubit),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AddReviewPage.routeName,
                      arguments: widget.coach.id,
                    );
                  },
                  child: const Text('Write a Review'),
                ),
              ),
              SizedBox(height: 3.h),
            ],
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
                color: Theme.of(context).colorScheme.surfaceTint, size: 35.sp),
          );
        }
        return Center(child: SvgPicture.asset(MediaConst.empty));
      },
    );
  }

  Iterable<ReviewModel> getReviewOfCurrentUser(
          List<ReviewModel> reviews, CoachCubit cubit) =>
      reviews.where((element) => element.userId == cubit.auth.uid);

  bool alreadyReview(List<ReviewModel> reviews, CoachCubit cubit) {
    bool isFound = false;
    for (var element in reviews) {
      if (element.userId == cubit.auth.uid) {
        isFound = true;
      } else {
        isFound = false;
      }
    }
    return isFound;
  }
}
