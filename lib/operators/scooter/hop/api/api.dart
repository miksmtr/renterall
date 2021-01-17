import 'dart:convert';

import 'package:renterall/models/interfaces/api_interface.dart';
import 'package:renterall/utills/helpers/api_helper2.dart';
import '../model/scooter.dart';
import '../const.dart';

class HopApi implements ApiInterface {
  String userToken;
  ApiHelper2 apiHelper;
  HopApi(this.userToken) {
    apiHelper = new ApiHelper2(baseUrl: apiUrl, headers: {
      'Content-Type': 'application/json',
      'x-access-rider': 'com.hoplagit.rider',
      'host': 'api.hoplagit.com',
      'Authorization': 'Bearer $userToken'
    });
  }

  Future<List<Scooter>> getScooters(
    String latitude,
    String longitude,
  ) async {
    List<Scooter> list = new List<Scooter>();
    var json = await apiHelper
        .getApi('scooters:nearby?lat=$latitude&lng=$longitude&r=100000');
    if (json != null) {
      for (var item in jsonDecode(json)) {
        Scooter scotter = new Scooter(
          code: item['code'],
          model: item['model'],
          battery: item['battery'],
          remaining_mileage: item['remaining_mileage'],
          latitude: item['coord']['lat'],
          longitude: item['coord']['lng'],
          preauth: item['fare']['preauth'],
          per_minute: item['fare']['per_minute'],
        );
        list.add(scotter);
      }
    }

    return list;
  }
}
