import 'base_entity.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class Config extends BaseEntity implements ModelInterface {
  int androidVer;
  int batteryLimitForClient;
  String contactPhone;
  double creditCard3DValidationFee;
  double distanceLimitForScootersVisibility;
  int guestsLimitForMultiRide;
  int iOSVer;
  int id;
  double invitationPrize;
  double minuteCost;
  double registrationGift;

  Config({
    this.androidVer,
    this.batteryLimitForClient,
    this.contactPhone,
    this.creditCard3DValidationFee,
    this.distanceLimitForScootersVisibility,
    this.guestsLimitForMultiRide,
    this.iOSVer,
    this.id,
    this.invitationPrize,
    this.minuteCost,
    this.registrationGift,
  });
  factory Config.fromJson(Map json) {
    return Config(
      androidVer: json['androidVer'],
      batteryLimitForClient: json['batteryLimitForClient'],
      contactPhone: json['contactPhone'],
      creditCard3DValidationFee: json['creditCard3DValidationFee'],
      distanceLimitForScootersVisibility:
          json['distanceLimitForScootersVisibility'],
      guestsLimitForMultiRide: json['guestsLimitForMultiRide'],
      iOSVer: json['iOSVer'],
      id: json['id'],
      invitationPrize: json['invitationPrize'],
      registrationGift: json['registrationGift'],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': this.androidVer,
        'batteryLimitForClient': this.batteryLimitForClient,
        'contactPhone': this.contactPhone,
        'creditCard3DValidationFee': this.creditCard3DValidationFee,
        'distanceLimitForScootersVisibility':
            this.distanceLimitForScootersVisibility,
        'guestsLimitForMultiRide': this.guestsLimitForMultiRide,
        'iOSVer': this.iOSVer,
        'id': this.id,
        'invitationPrize': this.invitationPrize,
        'registrationGift': this.registrationGift,
      };


 


 
}
