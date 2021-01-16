import 'dart:io';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Scooter implements ModelInterface {
  dynamic battery;
  dynamic id;
  dynamic latitude;
  dynamic longitude;
  dynamic minute_price;
  dynamic opening_price;
  dynamic remaining_distance;

  Scooter(
      {this.battery,
      this.id,
      this.latitude,
      this.longitude,
      this.minute_price,
      this.opening_price,
      this.remaining_distance});

  factory Scooter.fromJson(Map json) {
    return Scooter(
      battery: json['battery'] ?? null,
      remaining_distance: json['remaining_distance'] ?? null,
      minute_price: json['minute_price'] ?? null,
      opening_price: json['opening_price'] ?? null,
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      id: json['id'] ?? null,
    );
  }
}
