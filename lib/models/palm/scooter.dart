import 'dart:io';

import 'area.dart';
import 'base_entity.dart';
import 'region.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class Scooter extends BaseEntity implements ModelInterface {
  double battery;
  String displayCode;
  double distance;
  double duration;
  int id;
  double latitude;
  String lockBleCode;
  double longitude;
  double price;
  String qrcode;
  Region region;
  String scooterCode;
  int status;
  int feedback;
  File photo;
  String campaignId;
  String guestId;
  int affectedRows;
  int changedRows;
  int fieldCount;
  int insertId;
  bool protocol41;
  int serverStatus;
  int warningCount;
  double amount;
  String contactPhone;
  double durationAsMinutes;
  Area giftArea;
  int ridingId;
}
