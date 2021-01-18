import 'dart:convert';

import 'package:renterall/models/interfaces/api_interface.dart';
import '../model/taksi.dart';
import 'package:renterall/utills/helpers/api_helper2.dart';
import '../const.dart';

class ITaksiApi implements ApiInterface {
  String userToken;
  ApiHelper2 apiHelper;
  ITaksiApi(this.userToken) {
    apiHelper = new ApiHelper2(
        baseUrl: apiUrl, headers: {'Content-Type': 'text/plain'});
  }
  List<Taksi> list = new List<Taksi>();
  double lat, let;
  //await apiHelper.postApi(key, body: data.toJson());
  Future<List<Taksi>> getTaksi(double lat, double let) async {
    // "yellow-taxi",
    //"turquoise-taxi"
    // black-taxi

    this.lat = lat;
    this.let = let;

    var token = await apiHelper.postApi('v1/auth/sms/refresh',
        body: '''{\n  "token": "$userToken"\n}''');

    token = token['access'];

    apiHelper = new ApiHelper2(baseUrl: apiUrl, headers: {
      'Authorization': 'Bearer ' + token,
      'Content-Type': 'text/plain',
    });

    await getData("yellow");
    await getData("turquoise");
    await getData("black");

    return list;
  }

  getData(taxiType) async {
    var json = await apiHelper.postApi('v2/coord/search',
        body:
            '''{\n  "limit": 100,\n  "kinds": [\n    "$taxiType-taxi"\n  ],\n  "radius": 5000,\n  "coord": {\n    "Lng": $let,\n    "Lat": $lat\n  }\n}''');

    if (json != null) {
      if (json['coords'].length > 0) {
        for (var item in json['coords']) {
          Taksi taksi = new Taksi(
            latitude: item['lat'],
            longitude: item['lng'],
          );

          list.add(taksi);
        }
      }
    }
  }
}
