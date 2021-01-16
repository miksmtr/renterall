import 'package:renterall/models/interfaces/api_interface.dart';
import '../model/scooter.dart';
import 'package:renterall/utills/helpers/api_helper.dart';
import '../const.dart';

class PalmApi implements ApiInterface {
  String userToken;
  ApiHelper apiHelper;
  PalmApi(this.userToken) {
    apiHelper =
        new ApiHelper(baseUrl: apiUrl, token: userToken, isFormData: true);
  }

  //await apiHelper.postApi(key, body: data.toJson());
  Future<List<Scooter>> getScooters() async {
    List<Scooter> list = new List<Scooter>();
    var json = await apiHelper.getApi('scooter');
    for (var item in json['scooters']) {
      list.add(Scooter.fromJson(item));
    }
    return list;
  }
}
