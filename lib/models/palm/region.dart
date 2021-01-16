import 'base_entity.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class Region extends BaseEntity implements ModelInterface {
  String contactPhone;
  double openingFee;
  double reservationPrice;

  double getOpeningFee() {
    return this.openingFee;
  }

  String getContactPhone() {
    return this.contactPhone;
  }

  double getReservationPrice() {
    return this.reservationPrice;
  }
}
