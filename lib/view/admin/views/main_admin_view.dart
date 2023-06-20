import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../models/request_online_coach.dart';
import '../pages/review_page.dart';

class MainAdminView extends StatelessWidget {
  const MainAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    excuteFetchData(cubit);
    return SafeArea(
      child: RefreshIndicator(
        displacement: 500,
        onRefresh: () => cubit.fetchRequests(),
        child: BlocBuilder<AdminCubit, AdminState>(
          buildWhen: ((previous, current) => previous != current),
          builder: (contxt, state) {
            if (state is FailureState) {
              return Center(
                  child: SvgPicture.asset('assets/icons/empty.svg',
                      width: 30.w, height: 30.h));
            } else if (state is FetchRequestsState) {
              if (state.requests.isEmpty) {
                return Center(
                    child: SvgPicture.asset(
                  'assets/icons/empty.svg',
                  width: 30.w,
                  height: 30.h,
                ));
              }
              return ListView.builder(
                itemCount: state.requests.length,
                itemBuilder: (context, index) {
                  final request = state.requests[index];

                  return RequestItem(
                    request: request,
                    cubit: cubit,
                  );
                },
              );
            } else if (state is LoadingRequestState) {
              return Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                      color: Theme.of(context).colorScheme.surfaceTint,
                      size: 35.sp));
            }
            return Center(
                child: SvgPicture.asset(
              'assets/icons/empty.svg',
              width: 30.w,
              height: 30.h,
            ));
          },
        ),
      ),
    );
  }

  excuteFetchData(cubit) async {
    await cubit.fetchRequests();
  }
}

class RequestItem extends StatelessWidget {
  final RequestOnlineCoachModel request;
  final AdminCubit cubit;
  const RequestItem({super.key, required this.request, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(request.personalImg),
        radius: 35,
      ),
      onTap: () {
        Navigator.pushNamed(context, ReviewPage.routeName, arguments: request);
      },
      title: Text(request.fulName, style: TextStyle(fontSize: 15.sp)),
      subtitle: Text(request.nationalId,
          style: TextStyle(
              fontSize: 13.sp, color: Theme.of(context).colorScheme.primary)),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15.sp,
      ),
    );
  }
}
