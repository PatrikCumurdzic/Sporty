import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controllers/event_controller.dart';
import 'package:myapp/screens/profile/widgets/textFieldWidget.dart';
import 'package:myapp/screens/drawer/settings.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key key}) : super(key: key);

  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final eventController = Get.find<EventController>();
  String address = "";
  @override
  void dispose() {
    super.dispose();
    eventController.dateTimeController.clear();
    eventController.sportController.clear();
    eventController.locationController.clear();
    eventController.noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: primaryColors,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                if (eventController.eventData.value.sport == null ||
                    eventController.eventData.value.address == null ||
                    eventController.eventData.value.dateTime == null) {
                  Get.snackbar("Error", "Please fill all fields.",
                      colorText: Colors.white,
                      backgroundColor: Colors.red[300]);
                } else {
                  eventController.createEvent();
                }
              },
              child: Text(
                "Create",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Create event",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment(-1, 0),
                child: Text(
                  "Sport",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TypeAheadField(
                    hideOnEmpty: true,
                    debounceDuration: Duration(milliseconds: 500),
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: eventController.sportController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Sport")),
                    suggestionsCallback: (searchText) =>
                        eventController.searchSport(searchText),
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.name),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      eventController.eventData.value.sport = suggestion.name;
                      eventController.sportController.text = suggestion.name;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFieldWidget(
                  controller: eventController.dateTimeController,
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: eventController.eventData.value.dateTime ??
                            DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(new DateTime.now().year + 1));

                    var time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                            hour: eventController
                                    .eventData.value.dateTime?.hour ??
                                DateTime.now().hour,
                            minute: 0));
                    if (date != null && time != null) {
                      var dateTime = DateTime(date.year, date.month, date.day,
                          time.hour, time.minute);
                      eventController.eventData.value.dateTime = dateTime;
                      eventController.dateTimeController.text =
                          "${DateFormat("EEEE, dd.MM").format(dateTime)} in ${time.hour}:${time.minute} ${time.period.index == 0 ? "AM" : "PM"}";
                    }
                  },
                  hintText: "Date time",
                  label: 'Date time',
                  readOnly: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFieldWidget(
                  controller: eventController.locationController,
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlacePicker(
                          apiKey: "AIzaSyDuA9CFyKpXtn0GjfMFvevDm8jzzj4_X7s",
                          forceSearchOnZoomChanged: true,
                          automaticallyImplyAppBarLeading: false,
                          selectInitialPosition: true,
                          onPlacePicked: (result) {
                            eventController.locationController.text =
                                result.formattedAddress;
                            eventController.eventData.value.address =
                                result.formattedAddress;
                            eventController.eventData.value.lat =
                                result.geometry.location.lat;
                            eventController.eventData.value.lng =
                                result.geometry.location.lng;
                            Navigator.of(context).pop();
                          },
                          initialPosition: LatLng(45.391461, 14.371965),
                          useCurrentLocation: true,
                        ),
                      ),
                    );
                  },
                  hintText: "Location",
                  label: 'Location',
                  readOnly: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Text(
                    "Total participants",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        eventController.decrease();
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: primaryColors,
                        size: 60,
                      ),
                      iconSize: 60,
                    ),
                    Expanded(
                        child: Obx(() => Text(
                              eventController.participantNumber.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ))),
                    IconButton(
                      onPressed: () {
                        eventController.increase();
                      },
                      icon: Icon(
                        Icons.add_circle,
                        color: primaryColors,
                        size: 60,
                      ),
                      iconSize: 60,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFieldWidget(
                  controller: eventController.noteController,
                  label: 'Note',
                  maxLines: 5,
                  onChanged: (note) {
                    eventController.eventData.value.note = note.trim();
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
