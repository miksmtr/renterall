import 'package:renterall/models/interfaces/model_interfac.dart';

import '../lat_long.dart';
import 'base_entity.dart';
import 'region.dart';

class ChargeStation extends BaseEntity implements ModelInterface {
  double latitude;
  double longitude;
  Region region;

  double getLatitude() {
    return this.latitude;
  }

  double getLongitude() {
    return this.longitude;
  }

  LatLong getLatLng() {
    return LatLong(this.latitude, this.longitude);
  }

  Region getRegion() {
    return this.region;
  }
}
