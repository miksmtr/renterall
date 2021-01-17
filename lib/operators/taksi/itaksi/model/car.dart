import 'dart:io';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Car implements ModelInterface {
  dynamic fuel_level_ratio;
  dynamic geo_distance;
  dynamic latitude;
  dynamic longitude;

  Car(
      {this.fuel_level_ratio,
      this.latitude,
      this.longitude,
      this.geo_distance});

  factory Car.fromJson(Map json) {
    return Car(
      fuel_level_ratio: json['fuel_level_ratio'] ?? null,
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      geo_distance: json['geo_distance'] ?? null,
    );
  }
}
