import 'package:renterall/models/interfaces/model_interfac.dart';

class Scooter implements ModelInterface {
  dynamic imei;
  dynamic latitude;
  dynamic longitude;
  dynamic distance;
  Scooter({this.distance, this.latitude, this.longitude, this.imei});

  factory Scooter.fromJson(Map json) {
    return Scooter(
      distance: json['distance'] ?? null,
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      imei: json['imei'] ?? null,
    );
  }
}
