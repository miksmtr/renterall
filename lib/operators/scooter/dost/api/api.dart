import 'dart:convert';

import 'package:renterall/models/interfaces/api_interface.dart';
import '../model/scooter.dart';
import 'package:renterall/utills/helpers/api_helper2.dart';
import '../const.dart';

class DostApi implements ApiInterface {
  String userToken;
  ApiHelper2 apiHelper;
  DostApi(this.userToken) {
    apiHelper = new ApiHelper2(baseUrl: apiUrl, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + userToken,
    });
  }

  Future<List<Scooter>> getScooters(double lat, double let) async {
    List<Scooter> list = new List<Scooter>();
    var json = await apiHelper.getApi('scooter/$lat/$let');
    if (json != null) {
      for (var item in json['data']) {
        list.add(Scooter.fromJson(item));
      }
    }
    return list;
  }
}
