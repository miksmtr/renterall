import 'package:renterall/models/interfaces/model_interfac.dart';

import '../lat_long.dart';
import 'base_entity.dart';

class Area extends BaseEntity implements ModelInterface {
  List<List<double>> polygon = new List<List<double>>();
  String prize;

  List<LatLong> getCoordinates() {
    List<LatLong> list = new List<LatLong>();
    for (List<double> a in this.polygon) {
      list.add(new LatLong(a[0], a[1]));
    }
    return list;
  }
}
