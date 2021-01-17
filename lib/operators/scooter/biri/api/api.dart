import 'package:renterall/models/interfaces/api_interface.dart';
import '../model/scooter.dart';
import 'package:renterall/utills/helpers/api_helper.dart';
import '../const.dart';

class BiriApi implements ApiInterface {
  String userToken;
  ApiHelper apiHelper;
  BiriApi(this.userToken) {
    apiHelper = new ApiHelper(baseUrl: apiUrl, token: "Bearer " + userToken);
  }

  //await apiHelper.postApi(key, body: data.toJson());
  Future<List<Scooter>> getScooters() async {
    List<Scooter> list = new List<Scooter>();
    var json = await apiHelper.postApi('scooter/getall',null);

    print("json" + json.toString());
    for (var item in json['data']) {
      list.add(Scooter.fromJson(item));
    }
    return list;
  }
}
