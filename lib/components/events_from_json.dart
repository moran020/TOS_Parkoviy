import 'dart:convert';
import 'package:flutter/services.dart';

Future<Events> getEventsList() async {
  var jsonData = await rootBundle.loadString('assets/json/events.json');
  var data = json.decode(jsonData);
  return Events.fromJson(data);
}

class Events {
  List<Event>? event;

  Events({this.event});

  Events.fromJson(Map<String, dynamic> json) {
    if (json['event'] != null) {
      event = <Event>[];
      json['event'].forEach((v) {
        event!.add(Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (event != null) {
      data['event'] = event!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Event {
  String? iD;
  String? eventName;
  List<EventType>? eventType;
  String? description;
  String? place;
  String? date;
  String? time;
  double? longitude;
  double? latitude;
  String? image;

  Event(
      {this.iD,
      this.eventName,
      this.eventType,
      this.description,
      this.place,
      this.date,
      this.time,
      this.longitude,
      this.latitude,
      this.image});

  Event.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    eventName = json['eventName'];
    if (json['eventType'] != null) {
      eventType = <EventType>[];
      json['eventType'].forEach((v) {
        eventType!.add(EventType.fromJson(v));
      });
    }
    description = json['description'];
    place = json['place'];
    date = json['date'];
    time = json['time'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['eventName'] = eventName;
    if (eventType != null) {
      data['eventType'] = eventType!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    data['place'] = place;
    data['date'] = date;
    data['time'] = time;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['image'] = image;
    return data;
  }
}

class EventType {
  bool? culture;
  bool? sport;
  bool? education;
  bool? ecology;
  bool? family;
  bool? voluntiiring;

  EventType(
      {this.culture,
      this.sport,
      this.education,
      this.ecology,
      this.family,
      this.voluntiiring});

  EventType.fromJson(Map<String, dynamic> json) {
    culture = json['culture'];
    sport = json['sport'];
    education = json['education'];
    ecology = json['ecology'];
    family = json['family'];
    voluntiiring = json['voluntiiring'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['culture'] = culture;
    data['sport'] = sport;
    data['education'] = education;
    data['ecology'] = ecology;
    data['family'] = family;
    data['voluntiiring'] = voluntiiring;
    return data;
  }
}
