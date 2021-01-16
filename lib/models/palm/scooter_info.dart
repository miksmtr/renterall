import '../lat_long.dart';
import 'base_entity.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class ScooterInfo extends BaseEntity implements ModelInterface {
  LatLong location;
  int maxKm;
  int maxTime;
  int scooterBatteryPercentage;
  String scooterId;
}
