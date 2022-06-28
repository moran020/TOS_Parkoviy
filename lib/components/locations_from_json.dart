import 'dart:convert';
import 'package:flutter/services.dart';

Future<Locations> getLocationsList() async {
  var jsonData = await rootBundle.loadString('assets/json/locations.json');
  var data = json.decode(jsonData);
  return Locations.fromJson(data);
}

class Locations {
  List<Location>? location;

  Locations({this.location});

  Locations.fromJson(Map<String, dynamic> json) {
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(Location.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String? iD;
  String? name;
  String? type;
  String? condition;
  String? finance;
  String? fullDescr;
  String? street;
  String? house;
  double? longitude;
  double? latitude;
  String? image;

  Location(
      {this.iD,
      this.name,
      this.type,
      this.condition,
      this.finance,
      this.fullDescr,
      this.street,
      this.house,
      this.longitude,
      this.latitude,
      this.image});

  Location.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['name'];
    type = json['type'];
    condition = json['condition'];
    finance = json['finance'];
    fullDescr = json['full_descr'];
    street = json['street'];
    house = json['house'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['name'] = name;
    data['type'] = type;
    data['condition'] = condition;
    data['finance'] = finance;
    data['full_descr'] = fullDescr;
    data['street'] = street;
    data['house'] = house;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['image'] = image;
    return data;
  }
}
