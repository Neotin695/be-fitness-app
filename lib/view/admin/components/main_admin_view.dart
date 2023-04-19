import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../models/request_online_coach.dart';
import '../view/review_page.dart';

class MainAdminView extends StatelessWidget {
  const MainAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    excuteFetchData(cubit);
    return RefreshIndicator(
      onRefresh: () => cubit.fetchRequests(),
      child: BlocBuilder<AdminCubit, AdminState>(
        buildWhen: ((previous, current) => previous != current),
        builder: (contxt, state) {
          if (state is FailureFetchRequests) {
            return Center(
                child: SvgPicture.asset('assets/icons/empty.svg',
                    width: 30.w, height: 30.h));
          } else if (state is FetchRequestsState) {
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
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
              child: SvgPicture.asset(
            'assets/icons/empty.svg',
            width: 30.w,
            height: 30.h,
          ));
        },
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
      leading: Image.network(
        request.personalImg,
        width: 10.w,
        height: 10.h,
      ),
      title: Text(request.fulName, style: TextStyle(fontSize: 15.sp)),
      subtitle: Text(request.nationalId, style: TextStyle(fontSize: 12.sp)),
      trailing: IconButton(
        icon: Icon(
          Icons.more_horiz,
          size: 15.sp,
        ),
        onPressed: () {
          Navigator.pushNamed(context, ReviewPage.routeName,
              arguments: request);
        },
      ),
    );
  }
}
