import 'dart:convert';
import 'package:flutter/services.dart';

Future<Organizations> getOrganizationsList() async {
  var jsonData = await rootBundle.loadString('assets/json/organizations.json');
  var data = json.decode(jsonData);
  return Organizations.fromJson(data);
}

class Organizations {
  List<Organization>? organization;

  Organizations({this.organization});

  Organizations.fromJson(Map<String, dynamic> json) {
    if (json['organization'] != null) {
      organization = <Organization>[];
      json['organization'].forEach((v) {
        organization!.add(Organization.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (organization != null) {
      data['organization'] = organization!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Organization {
  String? iD;
  String? name;
  String? type;
  String? abbreviation;
  String? shortDescr;
  String? longDescr;
  String? street;
  String? house;
  double? longitude;
  double? latitude;
  String? image;

  Organization(
      {this.iD,
      this.name,
      this.type,
      this.abbreviation,
      this.shortDescr,
      this.longDescr,
      this.street,
      this.house,
      this.longitude,
      this.latitude,
      this.image});

  Organization.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['name'];
    type = json['type'];
    abbreviation = json['abbreviation'];
    shortDescr = json['short_descr'];
    longDescr = json['long_descr'];
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
    data['abbreviation'] = abbreviation;
    data['short_descr'] = shortDescr;
    data['long_descr'] = longDescr;
    data['street'] = street;
    data['house'] = house;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['image'] = image;
    return data;
  }
}
