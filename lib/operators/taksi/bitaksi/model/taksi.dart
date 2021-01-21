import 'dart:io';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Taksi implements ModelInterface {
  dynamic latitude;
  dynamic longitude;
  dynamic geo_geo_distance;

  Taksi({
    this.latitude,
    this.geo_geo_distance,
    this.longitude,
  });

  factory Taksi.fromJson(Map json) {
    return Taksi(
      latitude: json['lat'] ?? null,
      longitude: json['lon'] ?? null,
      geo_geo_distance: json['geo_geo_distance'] ?? null,
    );
  }
}
