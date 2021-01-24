import 'dart:ffi';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Scooter implements ModelInterface {
  dynamic qrCode;
  dynamic latitude;
  dynamic longitude;
  dynamic model;
  dynamic battery;

  dynamic startPrice;
  dynamic minPrice;

  dynamic distance;
  dynamic active;

  Scooter({
    this.battery,
    this.qrCode,
    this.distance,
    this.active,
    this.minPrice,
    this.startPrice,
    this.latitude,
    this.longitude,
    this.model,
  });

  factory Scooter.fromJson(Map json) {
    return Scooter(
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      battery: json['battery'] ?? null,
      qrCode: json['qrCode'] ?? nullptr,
      distance: json['tripDistance'] ?? null,
      active: json['active'] ?? null,
      model: json['model'] ?? null,
      minPrice: 0,
      startPrice: 0,
    );
  }
}
