import 'dart:async';

import 'package:be_fitness_app/core/appconstance/map_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  final Completer<GoogleMapController> mapController = Completer();
  LatLng targetLocation = const LatLng(30.2177, 31.2639);
  LocationData? currentLocation;
  LatLng sourceLocation = const LatLng(6.8206, 30.8025);
  Location location = Location();

  List<LatLng> polylineCoordinates = [];
  late GoogleMapController newCameraPosition;
  @override
  void initState() {
    //getPolyPoint();
    if (mounted) {
      getLocation();
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    location = Location();
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation != null
        ? GoogleMap(
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!),
            ),
            // polylines: {
            //   Polyline(
            //       polylineId: const PolylineId('route'),
            //       points: polylineCoordinates,
            //       color: primaryColor)
            // },
            markers: {
              Marker(
                markerId: const MarkerId('target'),
                position: targetLocation,
              ),
              Marker(
                markerId: const MarkerId('destination'),
                position: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
              ),
            },
            onTap: (latlng) async {
              if (mounted) {
                setState(() {
                  targetLocation = latlng;
                });
              }
              await getPolyPoint();
            },
            onMapCreated: (GoogleMapController controller) {
              if (mounted) {
                setState(() {
                  mapController.complete(controller);
                });
              }
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: LoadingAnimationWidget.dotsTriangle(
                        color: Theme.of(context).colorScheme.surfaceTint,
                        size: 35.sp)),
                SizedBox(height: 2.h),
                Text(
                  'please wait we locating your location',
                  style: TextStyle(fontSize: 20.sp),
                ),
              ],
            ),
          );
  }

  void getLocation() async {
    location.getLocation().then((value) {
      if (mounted) {
        setState(() {
          currentLocation = value;
        });
      }
    });
    newCameraPosition = await mapController.future;
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> getPolyPoint() async {
    PolylinePoints points = PolylinePoints();

    PolylineResult result = await points.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(targetLocation.latitude, targetLocation.longitude),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }
}
