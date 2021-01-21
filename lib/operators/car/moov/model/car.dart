import 'dart:io';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Car implements ModelInterface {
  dynamic battery;
  dynamic distance;
  dynamic latitude;
  dynamic longitude;
  dynamic minPrice;
  dynamic startPrice;

  Car(
      {this.battery,
      this.latitude,
      this.minPrice,
      this.startPrice,
      this.longitude,
      this.distance});

  factory Car.fromJson(Map json) {
    return Car(
      startPrice: json['startPrice'] ?? null,
      minPrice: json['minPrice'] ?? null,
      battery: json['battery'] ?? null,
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      distance: json['distance'] ?? null,
    );
  }
}
