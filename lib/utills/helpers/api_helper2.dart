import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renterall/utills/exceptions/http_not_found_exception.dart';
import 'package:renterall/utills/exceptions/http_unauthorized_exception.dart';
import 'package:renterall/utills/exceptions/http_unprocessable_entity_exception.dart';

class ApiHelper2 {
  String baseUrl;
  bool debug = true;
  String token;
  var request;
  var headers = {
    'Content-Type': 'application/json',
  };
  ApiHelper2({
    this.baseUrl,
    this.headers,
  }) {}

  Future<dynamic> getApi(url) async {
    var request = http.Request('GET', Uri.parse(baseUrl + url));
    request.bodyFields = {};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      return null;
    }
  }

  Future<dynamic> postApi(url, {body}) async {
    var request = http.Request('POST', Uri.parse(baseUrl + url));
    if (body != null) request.body = body;

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    String responseStream = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return jsonDecode(responseStream);
    } else {
      return null;
    }
  }
}
