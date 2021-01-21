import 'dart:io';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Vehicle implements ModelInterface {
  String company;
  String type; // scooter,car,taxi

  dynamic battery;
  dynamic distance;
  dynamic latitude;
  dynamic longitude;

  dynamic duration;
  dynamic startPrice;
  dynamic minPrice;
  dynamic status;

  Vehicle(
      {this.battery,
      this.distance,
      this.duration,
      this.latitude,
      this.longitude,
      this.minPrice,
      this.startPrice,
      this.status,
      this.company,
      this.type});

  factory Vehicle.fromJson(Map json) {
    return Vehicle(
      battery: json['battery'] ?? null,
      distance: json['distance'] ?? null,
      duration: json['duration'] ?? null,
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      minPrice: json['minPrice'] ?? null,
      startPrice: json['startPrice'] ?? null,
      status: json['status'] ?? null,
      company: json['company'] ?? null,
      type: json['type'] ?? null,
    );
  }
}
