import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:renterall/utills/exceptions/http_not_found_exception.dart';
import 'package:renterall/utills/exceptions/http_unauthorized_exception.dart';
import 'package:renterall/utills/exceptions/http_unprocessable_entity_exception.dart';

class ApiHelper {
  /*

  headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + userToken,
    };
  */
  String baseUrl;
  bool debug = true;
  HttpClient _httpClient;
  IOClient _ioClient;
  String userToken;

  Map<String, String> headers;

  ApiHelper({this.baseUrl, this.userToken, this.headers}) {
    HttpClient _httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    _ioClient = new IOClient(_httpClient);
  }

  Future<http.Response> getApi(url) async {
    if (userToken == null) {
      userToken = '';
    }
    return _handleResponse(await _ioClient.get(baseUrl + url, headers: headers));
  }

  Future<http.Response> postApi(url, {body, Encoding encoding}) async {
    if (userToken == null) {
      userToken = '';
    }

    return _handleResponse(await _ioClient.post(baseUrl + url,
        headers: headers, body: body, encoding: encoding));
  }

  Future<http.Response> _handleResponse(http.Response response) async {
    if (debug) {
      print('HTTP STATUS CODE ' + response.statusCode.toString());
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
        break;
      case 422:
        throw HttpUnprocessableEntityException(
            message: jsonDecode(response.body));
        break;
      case 404:
        throw HttpNotFoundException(message: jsonDecode(response.body));
        break;
      case 401:
        dynamic resultData = jsonDecode(response.body);
        throw HttpUnauthorizedException(message: resultData);
        break;
      default:
        print('İsteğiniz başarısız oldu. (kod: ' +
            response.statusCode.toString() +
            ')');
        break;
    }
  }
}
