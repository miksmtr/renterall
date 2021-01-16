import '../lat_long.dart';
import 'base_entity.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class History extends BaseEntity implements ModelInterface {
  double amount;
  List<LatLong> coordinates = List<LatLong>();
  double distance;
  int duration;
  int endDate;
  int feedback;
  double finishLatitude;
  double finishLongitude;
  String fullName;
  int id;
  int isActive;
  String paymentMethod;
  String routeImageUrl;
  int scooterId;
  int startDate;
  double startLatitude;
  double startLongitude;
  int userId;
}
