import 'package:renterall/models/interfaces/model_interfac.dart';

class Scooter implements ModelInterface {
  dynamic code;
  dynamic latitude;
  dynamic longitude;
  dynamic model;
  dynamic battery;
  dynamic remaining_mileage;
  dynamic preauth;
  dynamic per_minute;

  Scooter({
    this.battery,
    this.code,
    this.preauth,
    this.per_minute,
    this.latitude,
    this.longitude,
    this.model,
    this.remaining_mileage,
  });

  factory Scooter.fromJson(Map json) {
    return Scooter(
      battery: json['battery'] ?? null,
      preauth: json['preauth'] ?? null,
      per_minute: json['per_minute'] ?? null,
      code: json['code'] ?? null,
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      model: json['model'] ?? null,
      remaining_mileage: json['remaining_mileage'] ?? null,
    );
  }
}
