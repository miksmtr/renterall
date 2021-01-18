import 'dart:io';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Taksi implements ModelInterface {
  dynamic latitude;
  dynamic longitude;

  Taksi({
    this.latitude,
    this.longitude,
  });

  factory Taksi.fromJson(Map json) {
    return Taksi(
      latitude: json['lat'] ?? null,
      longitude: json['lng'] ?? null,
    );
  }
}
