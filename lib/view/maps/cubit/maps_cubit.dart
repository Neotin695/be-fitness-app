import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/appconstance/map_const.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  static MapsCubit get(context) => BlocProvider.of(context);
  MapsCubit() : super(MapsInitial());
  final Completer<GoogleMapController> mapController = Completer();
  LatLng targetLocation = const LatLng(37.4221, -122.0841);
  LocationData? currentLocation;
  LatLng sourceLocation = const LatLng(37.4221, -122.0841);
  Location location = Location();
  List<LatLng> polylineCoordinates = [];
  late GoogleMapController newCameraPosition;
  void getLocation() async {
    location.getLocation().then((value) => currentLocation = value);
    newCameraPosition = await mapController.future;
  }

  Future<void> getPolyPoint() async {
    PolylinePoints points = PolylinePoints();

    PolylineResult result = await points.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(targetLocation.latitude, targetLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
  }

  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var position = await Geolocator.getCurrentPosition();

    return LatLng(position.latitude, position.longitude);
  }
}
