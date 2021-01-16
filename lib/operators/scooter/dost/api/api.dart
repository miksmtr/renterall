import 'package:renterall/models/interfaces/api_interface.dart';
import '../model/scooter.dart';
import 'package:renterall/utills/helpers/api_helper.dart';
import '../const.dart';

class DostApi implements ApiInterface {
  String userToken;
  ApiHelper apiHelper;
  DostApi(this.userToken) {
    apiHelper = new ApiHelper(baseUrl: apiUrl, token: "Bearer " + userToken);
  }

  //await apiHelper.postApi(key, body: data.toJson());
  Future<List<Scooter>> getScooters(double lat, double let) async {
    List<Scooter> list = new List<Scooter>();
    var json = await apiHelper.getApi('scooter/$lat/$let');
    for (var item in json['data']) {
      list.add(Scooter.fromJson(item));
    }
    return list;
  }
}
