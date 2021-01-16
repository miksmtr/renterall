import 'base_entity.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class RideSummary extends BaseEntity implements ModelInterface {
  double amount;
  double discountFee;
  double distance;
  double duration;
  int endDate;
  String invoiceUrl;
  int startDate;
  int rideId;
}
