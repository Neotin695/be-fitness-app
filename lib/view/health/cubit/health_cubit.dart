import 'package:be_fitness_app/models/health_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/appconstance/logic_constance.dart';

part 'health_state.dart';

class HealthCubit extends Cubit<HealthState> {
  static HealthCubit get(context) => BlocProvider.of(context);
  HealthCubit() : super(HealthInitial());
  final TextEditingController searchController = TextEditingController();
  final dioOption = Dio(BaseOptions(baseUrl: LogicConst.baseUrlEdamam));

  int age = 20;
  int weight = 50;
  double height = 150;
  bool genderSelected = true;

  HealthModel? healthModel;

  ValueNotifier<double>? calories = ValueNotifier(0.0);
  ValueNotifier<double>? fat = ValueNotifier(0.0);
  ValueNotifier<double>? procnt = ValueNotifier(0.0);
  ValueNotifier<double>? chole = ValueNotifier(0.0);
  ValueNotifier<double>? na = ValueNotifier(0.0);
  ValueNotifier<double>? ca = ValueNotifier(0.0);
  ValueNotifier<double>? zn = ValueNotifier(0.0);
  ValueNotifier<double>? chocdf = ValueNotifier(0.0);

  double calcCalories() {
    switch (genderSelected) {
      case true:
        return 88.36 + (13.4 * weight + (4.8 * height) - (5.7 * age));
      case false:
        return 447.6 + (9.2 * weight + (3.1 * height) - (4.3 * age));
      default:
        return 0;
    }
  }

  updateValue() {
    calories!.value = healthModel!.calories;
    fat!.value = healthModel!.totalNuration.fat.quantity;
    procnt!.value = healthModel!.totalNuration.procnt.quantity;
    chole!.value = healthModel!.totalNuration.chole.quantity;
    na!.value = healthModel!.totalNuration.na.quantity;
    ca!.value = healthModel!.totalNuration.ca.quantity;
    zn!.value = healthModel!.totalNuration.zn.quantity;
    chocdf!.value = healthModel!.totalNuration.chocdf.quantity;
  }

  Future<Either<bool, HealthModel>> searchNutrient() async {
    emit(LoadingState());
    try {
      final response = await dioOption.get<Map<String, dynamic>>(
          dioOption.options.baseUrl,
          queryParameters: {
            LogicConst.appId: LogicConst.appIdVal,
            LogicConst.appKey: LogicConst.appKeyVal,
            LogicConst.nuraitionType: 'logging',
            LogicConst.ingr: searchController.text
          });
      emit(NutrientLoaded());

      if (response.statusCode == 200) {
        return Right(HealthModel.fromMap(response.data!));
      }
      return const Left(false);
    } on DioError catch (e) {
      debugPrint(e.toString());
      emit(ErrorState(message: e.toString()));
      return const Left(false);
    }
  }
}
