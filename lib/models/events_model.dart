import 'package:flutter/material.dart';

class EventModel {
  String photo;
  String name;
  String person;
  String venue;
  String descr;

  EventModel(
      {@required this.photo,
      @required this.name,
      @required this.person,
      @required this.venue,
      @required this.descr});

  factory EventModel.fromjson(Map<String, dynamic> json) {
    return EventModel(
        photo: json["photo"],
        name: json["name"],
        person: json["person"],
        venue: json["venue"],
        descr: json["description"]?? "some description on event");//to be added later
  }
}
