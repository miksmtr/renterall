import 'package:renterall/models/interfaces/api_interface.dart';
import 'package:renterall/utills/helpers/api_helper.dart';
import '../model/scooter.dart';
import '../const.dart';

class MartiApi implements ApiInterface {
  String userToken;
  ApiHelper apiHelper;
  MartiApi(this.userToken) {
    apiHelper =
        new ApiHelper(baseUrl: apiUrl, token: userToken);
  }

  Future<List<Scooter>> getScooters() async {
    List<Scooter> list = new List<Scooter>();
    var json = await apiHelper.getApi('map/listAvailables');
    print("json: " + json.toString());
    for (var item in json['data']) {
      list.add(Scooter.fromJson(item));
    }
    return list;
  }
}
