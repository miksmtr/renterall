import 'dart:io';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Vehicle implements ModelInterface {
  String company; 
  String type; // scooter,car,taxi

  dynamic battery;
  dynamic distance;
  dynamic duration;
  dynamic latitude;
  dynamic longitude;
  dynamic price;
  dynamic status;
  Vehicle(
      {this.battery,
      this.distance,
      this.duration,
      this.latitude,
      this.longitude,
      this.price,
      this.status});

  factory Vehicle.fromJson(Map json) {
    return Vehicle(
      battery: json['battery'] ?? null,
      distance: json['distance'] ?? null,
      duration: json['duration'] ?? null,
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      price: json['price'] ?? null,
      status: json['status'] ?? null,
    );
  }
}
