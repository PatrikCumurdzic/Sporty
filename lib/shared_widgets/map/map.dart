import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controllers/event_controller.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({Key key}) : super(key: key);

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(45.391461, 14.371965),
    zoom: 14.4746,
  );

  @override
  void dispose() {
    super.dispose();
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<EventController>(
          init: Get.find<EventController>(),
          builder: (EventController eventController) {
            return GoogleMap(
              markers: Set.from(eventController.listOfEvents.value.map((e) => Marker(
                  infoWindow: InfoWindow(
                      title: "${e.sport} ${e.dateTime.day == DateTime.now().day && e.dateTime.month == DateTime.now().month ? 'Today in ${DateFormat(
                          "hh:mm",
                        ).format(e.dateTime)}' : DateFormat("EEEE, dd.MM in hh:mm").format(e.dateTime)} ",
                      snippet: e.address),
                  markerId: MarkerId(e.id),
                  position: LatLng(e.lat, e.lng)))),
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            );
          }),
    );
  }
}
