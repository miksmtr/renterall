import 'dart:convert';

import 'package:renterall/models/interfaces/api_interface.dart';
import '../model/car.dart';
import 'package:renterall/utills/helpers/api_helper2.dart';
import '../const.dart';

class MoovApi implements ApiInterface {
  String userToken;
  ApiHelper2 apiHelper;
  MoovApi(this.userToken) {
    apiHelper = new ApiHelper2(baseUrl: apiUrl, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + userToken,
    });
  }

  //await apiHelper.postApi(key, body: data.toJson());
  Future<List<Car>> getCars(double lat, double let) async {
    List<Car> list = new List<Car>();
    var json = await apiHelper.postApi('search/',
        body:
            '''{\n  "is_active": true,\n  "pin_location": {\n    "lat": 41.0452472,\n    "lon": 29.0059014\n  },\n  "status": [\n    "active"\n  ],\n  "vehicle_types": [\n    "CAR"\n  ]\n}''');
    if (json != null) {
      if (json['hits'].length > 0) {
        for (var item in json['hits']) {
          Car car = new Car(
              latitude: item['geom']['lat'],
              longitude: item['geom']['lon'],
              fuel_level_ratio: item['fuel_level_ratio'],
              geo_distance: item['fuel_level_ratio']);
          list.add(car);
        }
      }
    }

    return list;
  }
}
