import 'package:be_fitness_app/core/appconstance/logic_constance.dart';
import 'package:dio/dio.dart';

class PushNotification {
  Future<bool> snetNotification(String token, String body, String title) async {
    final dio = Dio(
      BaseOptions(
        baseUrl: LogicConst.baseUrlFirebase,
        headers: <String, dynamic>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${LogicConst.serverKey}',
        },
      ),
    );

    final response = await dio.post(
      dio.options.baseUrl,
      data: <String, dynamic>{
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTER_NOTIFICATION_CLICK',
          'status': 'done',
          'body': body,
          'title': title,
        },
        'notification': <String, dynamic>{
          'title': title,
          'body': body,
          'android_channel_id': 'dbfood',
        },
        'to': token,
      },
    );
    return response.statusCode == 200;
  }
}
