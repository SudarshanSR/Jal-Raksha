import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

final LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 100,
);

Future<CameraPosition> getPosition() async {
  Position position = await Geolocator.getCurrentPosition(
    locationSettings: locationSettings,
  );

  return CameraPosition(
    target: LatLng(position.latitude, position.longitude),
    zoom: 10.0,
  );
}

class MapParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapParentWidgetState();
}

class _MapParentWidgetState extends State<MapParentWidget> {
  final Completer<MapLibreMapController> mapController = Completer();
  bool canInteractWithMap = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: canInteractWithMap
          ? FloatingActionButton(
              onPressed: _moveCameraToCurrentLocation,
              mini: true,
              child: const Icon(Icons.restore),
            )
          : null,
      body: FutureBuilder<CameraPosition>(
        future: getPosition(),
        builder: (context, AsyncSnapshot<CameraPosition> snapshot) {
          if (snapshot.hasData) {
            return MapLibreMap(
              onMapCreated: (controller) => mapController.complete(controller),
              initialCameraPosition: snapshot.data!,
              onStyleLoadedCallback: () =>
                  setState(() => canInteractWithMap = true),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  void _moveCameraToCurrentLocation() {
    mapController.future.then((c) {
      getPosition().then((pos) {
        return c.animateCamera(CameraUpdate.newCameraPosition(pos));
      });
    });
  }
}
