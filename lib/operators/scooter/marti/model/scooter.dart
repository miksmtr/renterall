import 'package:renterall/models/interfaces/model_interfac.dart';

class Scooter implements ModelInterface {
  dynamic code;
  dynamic latitude;
  dynamic longitude;
  dynamic batteryPercentage;
  dynamic statusId;
  dynamic lastUpdateTime;
  dynamic startingPrice;
  dynamic unitPrice;
  dynamic startingPriceWithoutDiscount;
  dynamic distance;
  dynamic reservable;
  dynamic vehicleType;
  dynamic isIncentivized;
  dynamic incentivizeAmount;
  Scooter(
      {this.distance,
      this.batteryPercentage,
      this.code,
      this.incentivizeAmount,
      this.isIncentivized,
      this.lastUpdateTime,
      this.latitude,
      this.longitude,
      this.reservable,
      this.startingPrice,
      this.startingPriceWithoutDiscount,
      this.statusId,
      this.unitPrice,
      this.vehicleType});

  factory Scooter.fromJson(Map json) {
    return Scooter(
      distance: json['distance'] ?? null,
      batteryPercentage: json['batteryPercentage'] ?? null,
      code: json['code'] ?? null,
      incentivizeAmount: json['incentivizeAmount'] ?? null,
      isIncentivized: json['isIncentivized'] ?? null,
      lastUpdateTime: json['lastUpdateTime'] ?? null,
      latitude: json['latitude'] ?? null,
      longitude: json['longitude'] ?? null,
      reservable: json['reservable'] ?? null,
      startingPrice: json['startingPrice'] ?? null,
      startingPriceWithoutDiscount:
          json['startingPriceWithoutDiscount'] ?? null,
      statusId: json['statusId'] ?? null,
      unitPrice: json['unitPrice'] ?? null,
      vehicleType: json['vehicleType'] ?? null,
    );
  }
}
