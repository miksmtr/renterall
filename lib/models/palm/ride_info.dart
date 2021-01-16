import 'area.dart';
import 'base_entity.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class RideInfo extends BaseEntity implements ModelInterface {
  double amount;
  double battery;
  String contactPhone;
  String displayCode;
  double distance;
  double duration;
  Area giftArea;
  String guestFullName;
  String guestId;
  bool isActive;
  bool isScooterInsideRideArea;
  String lockBleCode;
  double pauseFee;
  double pausePrice;
  double reservationFee;
  int ridingId;
  double scooterLatitude;
  double scooterLongitude;
  int scooterStatus; // UNDEFINED(0),RIDING(2),RIDING_AND_PAUSED(6),RESERVED(7);
  int startDate;
  int rideId;
}
