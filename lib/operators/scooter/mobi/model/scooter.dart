import 'dart:ffi';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Scooter implements ModelInterface {
  dynamic qrCode;
  dynamic latitude;
  dynamic longitude;
  dynamic model;
  dynamic battery;


  dynamic tripTime;
  dynamic tripDistance;
  dynamic active;

  Scooter({
    this.battery,
    this.qrCode,
    this.tripDistance,
    this.active,
    this.latitude,
    this.longitude,
    this.model,
    this.tripTime,
  });

  factory Scooter.fromJson(Map json) {
    return Scooter(
        latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      battery: json['battery'] ?? null,
      qrCode: json['qrCode'] ?? nullptr,


      tripDistance: json['tripDistance'] ?? null,
      active: json['active'] ?? null,
      model: json['model'] ?? null,
      tripTime: json['tripTime'] ?? null,
    );
  }
}
