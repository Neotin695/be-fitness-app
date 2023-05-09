import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:be_fitness_app/core/appconstance/media_constance.dart';
import 'package:be_fitness_app/view/coach/components/review_item_view.dart';
import 'package:be_fitness_app/view/coach/cubit/coach_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:sizer/sizer.dart';

import '../../../models/review_model.dart';
import '../screens/add_review_page.dart';

class DisplayReviewsView extends StatefulWidget {
  final String userId;

  const DisplayReviewsView({super.key, required this.userId});

  @override
  State<DisplayReviewsView> createState() => _DisplayReviewsViewState();
}

class _DisplayReviewsViewState extends State<DisplayReviewsView> {
  @override
  Widget build(BuildContext context) {
    final cubit = CoachCubit.get(context);
    return StreamBuilder(
      stream: cubit.store
          .collection(LogicConst.users)
          .doc(widget.userId)
          .collection(LogicConst.reviews)
          .snapshots(),
      builder: (context, snashot) {
        if (snashot.hasData) { 
          final List<ReviewModel> reviews = List.from(
              snashot.data!.docs.map((doc) => ReviewModel.fromMap(doc.data())));
          double totalRate = 0;
          reviews.map<double>((e) => totalRate += e.rate);
          return Column(
            children: [
              RatingSummary(
                counter: reviews.length,
                average: reviews.length / totalRate,
                showAverage: true,
                counterFiveStars: 5,
                counterFourStars: 4,
                counterThreeStars: 3,
                counterTwoStars: 2,
                counterOneStars: 1,
              ),
              Expanded(
                child: ListView(
                  children: reviews.map<Widget>((review) {
                    return ReviewItem(
                      review: review,
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
                      arguments: widget.userId,
                    );
                  },
                  child: const Text('Write a Review'),
                ),
              )
            ],
          );
        } else if (snashot.connectionState == ConnectionState.waiting) {
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
