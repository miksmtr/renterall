import 'dart:convert';

import 'package:renterall/models/interfaces/api_interface.dart';
import 'package:renterall/utills/helpers/api_helper2.dart';
import '../model/scooter.dart';
import '../const.dart';

class MobiApi implements ApiInterface {
  String userToken;
  ApiHelper2 apiHelper;
  MobiApi(this.userToken) {
    apiHelper = new ApiHelper2(baseUrl: apiUrl, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    });
  }

  Future<List<Scooter>> getScooters() async {
    List<Scooter> list = new List<Scooter>();
    var json = await apiHelper.getApi('get-active-devices');
    if (json != null) {
      for (var item in jsonDecode(json)['data']) {
        list.add(Scooter.fromJson(item));
      }
    }
    return list;
  }
}
