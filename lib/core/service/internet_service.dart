import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetService {
  final Connectivity connectivity = Connectivity();
  Future<bool> isConnected() async {
    bool connectionState = await InternetConnectionChecker().hasConnection;
    connectivity.onConnectivityChanged.listen((event) async {
      if (event != ConnectivityResult.none) {
        connectionState = await InternetConnectionChecker().hasConnection;
      } else {}
    });
    return connectionState;
  }
}
