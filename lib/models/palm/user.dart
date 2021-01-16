import 'base_entity.dart';
import 'guest.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class User extends BaseEntity implements ModelInterface {
  double balance;
  String email;
  String fullName;
  List<Guest> guests;
  bool hasCreditCard;
  int id;
  bool isFirstRide;
  bool isInvitationCodeEnable;
  bool isPhotoNeeded;
  int lastBalanceUpdated;
  String lockBleCode;
  String phone;
  String referenceCode;
  bool riding;
  String scooterCodeUsedInLastRide;
  int scooterStatus;
  String verificationCode;
  String referenceUserCode;
  int deviceType = 2;
  String token;
  String userCode;

/*     String getBalance()
    {
        if (Math.abs(this.balance) < 0.1) {
            this.balance = 0;
        }
        String format = String_.format("%.1f", Double.valueOf(this.balance));
        return (format.endsWith(",0") || format.endsWith(".0")) ? format.replace(",0", "").replace(".0", "") : format;
    }
 */

}
