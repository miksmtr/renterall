import 'dart:convert';

import 'package:renterall/models/interfaces/api_interface.dart';
import '../model/taksi.dart';
import 'package:renterall/utills/helpers/api_helper2.dart';
import '../const.dart';

class BiTaksiApi implements ApiInterface {
  String userToken;
  ApiHelper2 apiHelper;
  BiTaksiApi(this.userToken) {
    apiHelper = new ApiHelper2(baseUrl: apiUrl, headers: {
      'Content-Type': 'application/json',
    });
  }

  //await apiHelper.postApi(key, body: data.toJson());
  Future<List<Taksi>> getTaksi(double lat, double let) async {
    List<Taksi> list = new List<Taksi>();
    var json = await apiHelper.postApi('showDriversAround',
        body:
            '''{\n  "tokenCode": "$userToken",\n  "lat": $lat,\n  "lon": $let,\n  "serviceType": 0,\n  "radius":1\n}''');
    if (json != null) {
      if (json['driverList'].length > 0) {
        var decodeJson = json['driverList'];
        for (var item in decodeJson) {
          Taksi car = new Taksi(
            latitude: item['lat'],
            longitude: item['lon'],
          );
          list.add(car);
        }
      }
    }

    return list;
  }
}
