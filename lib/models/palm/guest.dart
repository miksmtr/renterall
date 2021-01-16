import 'base_entity.dart';
import 'package:renterall/models/interfaces/model_interfac.dart';

class Guest extends BaseEntity implements ModelInterface {
  String fullName;
  int id;
  bool isHost;
  bool isStarted;
  String phoneNumber;

  int getId() {
    return this.id;
  }

  void setId(int i) {
    this.id = i;
  }

  String getFullName() {
    return this.fullName;
  }

  void setFullName(String str) {
    this.fullName = str;
  }

  void setHost(bool z) {
    this.isHost = z;
  }

  void setStarted(bool z) {
    this.isStarted = z;
  }

  String getPhoneNumber() {
    return this.phoneNumber;
  }

  void setPhoneNumber(String str) {
    this.phoneNumber = str;
  }
}
