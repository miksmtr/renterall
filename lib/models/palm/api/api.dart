import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:renterall/models/interfaces/api_interface.dart';
import 'package:renterall/utills/exceptions/http_not_found_exception.dart';
import 'package:renterall/utills/exceptions/http_unauthorized_exception.dart';
import 'package:renterall/utills/exceptions/http_unprocessable_entity_exception.dart';
import 'package:renterall/utills/helpers/api_helper.dart';

import '../config.dart';
import 'base_response.dart';

class PalmApi extends ApiHelper implements ApiInterface {
  String name = "Palm";
  String url;
  String token;
  Map<String, String> heaader;

  PalmApi({this.token}) {
    super.baseUrl = url;
    super.userToken = token;
    super.headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
      HttpHeaders.authorizationHeader: userToken,
    };
  }

  Future<Config> getConfig() async {
    final response = await super.getApi('config');
    Map<String, dynamic> json = jsonDecode(response.body);
    return Config.fromJson(log(json, 'config'));
  }

  log(var json, String key) {
    if (super.debug) {
      print("$name success:" + json['success']);
      print("$name message:" + json['message']);
    }
    return json[key];
  }
}
