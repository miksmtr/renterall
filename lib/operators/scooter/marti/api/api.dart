import 'package:renterall/models/interfaces/api_interface.dart';
import 'package:renterall/utills/helpers/api_helper2.dart';
import '../model/scooter.dart';
import '../const.dart';

class MartiApi implements ApiInterface {
  String userToken;
  ApiHelper2 apiHelper;
  MartiApi(this.userToken) {
    apiHelper = new ApiHelper2(baseUrl: apiUrl, headers: {
      'Content-Type': 'application/json',
      'x-access-token': userToken
    });
  }

  Future<List<Scooter>> getScooters(
      {String latitude,
      String longitude,
      String minPointLatitude,
      String minPointLongitude,
      String maxPointLatitude,
      String maxPointLongitude,
      double zoomLevel = 14.0}) async {
    List<Scooter> list = new List<Scooter>();
    var json = await apiHelper.postApi('map/listAvailables',
        body:
            '{"latitude": "$latitude,"longitude": "$longitude","minPointLatitude": "$minPointLatitude","minPointLongitude": "$minPointLongitude","maxPointLatitude": "$maxPointLatitude","maxPointLongitude": "$maxPointLongitude","zoomLevel": "$zoomLevel}');
    for (var item in json['data']) {
      list.add(Scooter.fromJson(item));
    }
    return list;
  }
}
