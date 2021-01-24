import 'dart:io';

import 'package:renterall/models/interfaces/model_interfac.dart';

class Operator {
  String name;
  bool isActive;
  OperatorSub operatorSub;

  Operator({
    this.isActive = false,
    this.operatorSub,
    this.name,
  });
}

class OperatorSub {
  OperatorDomain domain;
  String token; // scooter,car,taxi
  String name;
  String type;

  OperatorSub({
    this.token,
    this.type,
    this.name,
    this.domain,
  });

  factory OperatorSub.fromJson(Map json) {
    return OperatorSub(
      domain: json['domain'] != null
          ? OperatorDomain.fromJson(json['domain'])
          : null,
      name: json['name'] ?? null,
      token: json['token'] ?? null,
      type: json['type'] ?? null,
    );
  }
}

class OperatorDomain {
  String android; // scooter,car,taxi
  String ios;

  OperatorDomain({this.android, this.ios});

  factory OperatorDomain.fromJson(Map json) {
    return OperatorDomain(
      android: json['android'] ?? null,
      ios: json['ios'] ?? null,
    );
  }
}
