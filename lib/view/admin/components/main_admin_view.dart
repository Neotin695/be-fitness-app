import 'package:be_fitness_app/view/admin/cubit/admin_cubit.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../models/request_online_coach.dart';
import '../view/review_page.dart';

class MainAdminView extends StatelessWidget {
  const MainAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    AdminCubit cubit = AdminCubit.get(context);
    excuteFetchData(cubit);
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (contxt, state) {
        if (state is FailureFetchRequests) {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              onCancelBtnTap: () => Navigator.pop(context),
              cancelBtnText: 'Got it',
              text: state.message,
              title: state.message);
          return const SizedBox();
        } else if (state is FetchRequestsState) {
          return RefreshIndicator(
            onRefresh: () async => await cubit.fetchRequests(),
            child: ListView.builder(
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                final request = state.requests[index];
                print(request);
                return RequestItem(
                  request: request,
                  cubit: cubit,
                );
              },
            ),
          );
        } else if (state is LoadingRequestState) {
          return const Center(child: CircularProgressIndicator());
        }
        return const SizedBox();
      },
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
