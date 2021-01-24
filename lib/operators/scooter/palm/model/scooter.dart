import 'package:renterall/models/interfaces/model_interfac.dart';

class Scooter implements ModelInterface {
  dynamic battery;
  dynamic displayCode;
  dynamic distance;
  dynamic duration;
  dynamic id;
  dynamic latitude;
  dynamic lockBleCode;
  dynamic longitude;
  dynamic startPrice;
  dynamic minPrice;
  dynamic qrcode;
  dynamic region;
  dynamic scooterCode;
  dynamic status;
  dynamic feedback;
  dynamic photo;
  dynamic campaignId;
  dynamic guestId;
  dynamic affectedRows;
  dynamic changedRows;
  dynamic fieldCount;
  dynamic insertId;
  dynamic protocol41;
  dynamic serverStatus;
  dynamic warningCount;
  dynamic amount;
  dynamic contactPhone;
  dynamic durationAsMinutes;
  dynamic giftArea;
  dynamic ridingId;
  Scooter(
      {this.affectedRows,
      this.amount,
      this.minPrice,
      this.startPrice,
      this.battery,
      this.campaignId,
      this.changedRows,
      this.contactPhone,
      this.displayCode,
      this.distance,
      this.duration,
      this.durationAsMinutes,
      this.feedback,
      this.fieldCount,
      this.giftArea,
      this.guestId,
      this.id,
      this.insertId,
      this.latitude,
      this.lockBleCode,
      this.longitude,
      this.photo,
      this.protocol41,
      this.qrcode,
      this.region,
      this.ridingId,
      this.scooterCode,
      this.serverStatus,
      this.status,
      this.warningCount});

  factory Scooter.fromJson(Map json) {
    return Scooter(
      battery: json['battery'] ?? null,
      displayCode: json['displayCode'] ?? null,
      distance: json['distance'] ?? null,
      duration: json['duration'] ?? null,
      id: json['id'] ?? null,
      latitude: json['latitude'] ?? null,
      lockBleCode: json['lockBleCode'] ?? null,
      longitude: json['longitude'] ?? null,
      minPrice: json['price'] ?? null,
      startPrice: json['price'] ?? null,
      qrcode: json['qrcode'] ?? null,
      region: json['region'] ?? null,
      scooterCode: json['scooterCode'] ?? null,
      status: json['status'] ?? null,
      feedback: json['feedback'] ?? null,
      photo: json['photo'] ?? null,
      campaignId: json['campaignId'] ?? null,
      guestId: json['guestId'] ?? null,
      affectedRows: json['affectedRows'] ?? null,
      changedRows: json['changedRows'] ?? null,
      fieldCount: json['fieldCount'] ?? null,
      insertId: json['insertId'] ?? null,
      protocol41: json['protocol41'] ?? null,
      serverStatus: json['serverStatus'] ?? null,
      warningCount: json['warningCount'] ?? null,
      amount: json['amount'] ?? null,
      contactPhone: json['contactPhone'] ?? null,
      durationAsMinutes: json['durationAsMinutes'] ?? null,
      giftArea: json['giftArea'] ?? null,
      ridingId: json['ridingId'] ?? null,
    );
  }
}
