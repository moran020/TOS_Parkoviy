import 'dart:convert';
import 'package:flutter/services.dart';

Future<Houses> getHousesList() async {
  var jsonData = await rootBundle.loadString('assets/json/houses.json');
  var data = json.decode(jsonData);
  return Houses.fromJson(data);
}

class Houses {
  List<House>? house;

  Houses({this.house});

  Houses.fromJson(Map<String, dynamic> json) {
    if (json['house'] != null) {
      house = <House>[];
      json['house'].forEach((v) {
        house!.add(House.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (house != null) {
      data['house'] = house!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class House {
  String? iD;
  List<Caretaker>? caretaker;
  String? city;
  String? street;
  String? house;
  int? year;
  String? serviceProvider;
  List<Refurbishment>? refurbishment;
  double? longitude;
  double? latitude;

  House(
      {this.iD,
      this.caretaker,
      this.city,
      this.street,
      this.house,
      this.year,
      this.serviceProvider,
      this.refurbishment,
      this.longitude,
      this.latitude});

  House.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    if (json['caretaker'] != null) {
      caretaker = <Caretaker>[];
      json['caretaker'].forEach((v) {
        caretaker!.add(Caretaker.fromJson(v));
      });
    }
    city = json['city'];
    street = json['street'];
    house = json['house'];
    year = json['year'];
    serviceProvider = json['service_provider'];
    if (json['refurbishment'] != null) {
      refurbishment = <Refurbishment>[];
      json['refurbishment'].forEach((v) {
        refurbishment!.add(Refurbishment.fromJson(v));
      });
    }
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    if (caretaker != null) {
      data['caretaker'] = caretaker!.map((v) => v.toJson()).toList();
    }
    data['city'] = city;
    data['street'] = street;
    data['house'] = house;
    data['year'] = year;
    data['service_provider'] = serviceProvider;
    if (refurbishment != null) {
      data['refurbishment'] = refurbishment!.map((v) => v.toJson()).toList();
    }
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}

class Caretaker {
  String? caretakerName;
  String? caretakerSurname;
  String? caretakerDadname;
  String? initials;
  String? contact;

  Caretaker(
      {this.caretakerName,
      this.caretakerSurname,
      this.caretakerDadname,
      this.initials,
      this.contact});

  Caretaker.fromJson(Map<String, dynamic> json) {
    caretakerName = json['caretakerName'];
    caretakerSurname = json['caretakerSurname'];
    caretakerDadname = json['caretakerDadname'];
    initials = json['initials'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caretakerName'] = caretakerName;
    data['caretakerSurname'] = caretakerSurname;
    data['caretakerDadname'] = caretakerDadname;
    data['initials'] = initials;
    data['contact'] = contact;
    return data;
  }
}

class Refurbishment {
  List<Roof>? roof;
  List<Front>? front;
  List<Electronics>? electronics;
  List<Water>? water;
  List<Sewerage>? sewerage;
  List<Heating>? heating;
  List<Gas>? gas;

  Refurbishment(
      {this.roof,
      this.front,
      this.electronics,
      this.water,
      this.sewerage,
      this.heating,
      this.gas});

  Refurbishment.fromJson(Map<String, dynamic> json) {
    if (json['roof'] != null) {
      roof = <Roof>[];
      json['roof'].forEach((v) {
        roof!.add(Roof.fromJson(v));
      });
    }
    if (json['front'] != null) {
      front = <Front>[];
      json['front'].forEach((v) {
        front!.add(Front.fromJson(v));
      });
    }
    if (json['electronics'] != null) {
      electronics = <Electronics>[];
      json['electronics'].forEach((v) {
        electronics!.add(Electronics.fromJson(v));
      });
    }
    if (json['water'] != null) {
      water = <Water>[];
      json['water'].forEach((v) {
        water!.add(Water.fromJson(v));
      });
    }
    if (json['sewerage'] != null) {
      sewerage = <Sewerage>[];
      json['sewerage'].forEach((v) {
        sewerage!.add(Sewerage.fromJson(v));
      });
    }
    if (json['heating'] != null) {
      heating = <Heating>[];
      json['heating'].forEach((v) {
        heating!.add(Heating.fromJson(v));
      });
    }
    if (json['gas'] != null) {
      gas = <Gas>[];
      json['gas'].forEach((v) {
        gas!.add(Gas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roof != null) {
      data['roof'] = roof!.map((v) => v.toJson()).toList();
    }
    if (front != null) {
      data['front'] = front!.map((v) => v.toJson()).toList();
    }
    if (electronics != null) {
      data['electronics'] = electronics!.map((v) => v.toJson()).toList();
    }
    if (water != null) {
      data['water'] = water!.map((v) => v.toJson()).toList();
    }
    if (sewerage != null) {
      data['sewerage'] = sewerage!.map((v) => v.toJson()).toList();
    }
    if (heating != null) {
      data['heating'] = heating!.map((v) => v.toJson()).toList();
    }
    if (gas != null) {
      data['gas'] = gas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roof {
  int? maintenanceYear;
  bool? condition;

  Roof({this.maintenanceYear, this.condition});

  Roof.fromJson(Map<String, dynamic> json) {
    maintenanceYear = json['maintenanceYear'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenanceYear'] = maintenanceYear;
    data['condition'] = condition;
    return data;
  }
}

class Front {
  int? maintenanceYear;
  bool? condition;

  Front({this.maintenanceYear, this.condition});

  Front.fromJson(Map<String, dynamic> json) {
    maintenanceYear = json['maintenanceYear'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenanceYear'] = maintenanceYear;
    data['condition'] = condition;
    return data;
  }
}

class Electronics {
  int? maintenanceYear;
  bool? condition;

  Electronics({this.maintenanceYear, this.condition});

  Electronics.fromJson(Map<String, dynamic> json) {
    maintenanceYear = json['maintenanceYear'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenanceYear'] = maintenanceYear;
    data['condition'] = condition;
    return data;
  }
}

class Water {
  int? maintenanceYear;
  bool? condition;

  Water({this.maintenanceYear, this.condition});

  Water.fromJson(Map<String, dynamic> json) {
    maintenanceYear = json['maintenanceYear'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenanceYear'] = maintenanceYear;
    data['condition'] = condition;
    return data;
  }
}

class Sewerage {
  int? maintenanceYear;
  bool? condition;

  Sewerage({this.maintenanceYear, this.condition});

  Sewerage.fromJson(Map<String, dynamic> json) {
    maintenanceYear = json['maintenanceYear'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenanceYear'] = maintenanceYear;
    data['condition'] = condition;
    return data;
  }
}

class Heating {
  int? maintenanceYear;
  bool? condition;

  Heating({this.maintenanceYear, this.condition});

  Heating.fromJson(Map<String, dynamic> json) {
    maintenanceYear = json['maintenanceYear'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenanceYear'] = maintenanceYear;
    data['condition'] = condition;
    return data;
  }
}

class Gas {
  int? maintenanceYear;
  bool? condition;

  Gas({this.maintenanceYear, this.condition});

  Gas.fromJson(Map<String, dynamic> json) {
    maintenanceYear = json['maintenanceYear'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenanceYear'] = maintenanceYear;
    data['condition'] = condition;
    return data;
  }
}
