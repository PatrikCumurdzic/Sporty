import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class Location extends StatefulWidget {
  const Location({Key key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  PickResult selectedPlace;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      PlacePicker(
        apiKey: "AIzaSyDuA9CFyKpXtn0GjfMFvevDm8jzzj4_X7s",
        initialPosition: LatLng(45.391461, 14.371965),
        useCurrentLocation: true,
        selectInitialPosition: true,

        //usePlaceDetailSearch: true,
        onPlacePicked: (result) {
          selectedPlace = result;
          Navigator.of(context).pop();
          setState(() {});
        },
      ),
      selectedPlace == null
          ? Container()
          : Text(selectedPlace.formattedAddress ?? ""),
    ]);
  }
}
