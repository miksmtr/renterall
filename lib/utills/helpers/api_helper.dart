import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:renterall/utills/exceptions/http_not_found_exception.dart';
import 'package:renterall/utills/exceptions/http_unauthorized_exception.dart';
import 'package:renterall/utills/exceptions/http_unprocessable_entity_exception.dart';

class ApiHelper {
  String baseUrl;
  bool debug = true;
  Dio dio;
  bool isFormData = false;
  String token;
  bool trustSelfSignedCertificate = true;
  BaseOptions options;
  ApiHelper({this.baseUrl, this.token, this.isFormData = false}) {
    if (isFormData) {
      dio = new Dio(BaseOptions(
        contentType: Headers.formUrlEncodedContentType,
        validateStatus: (_) => true,
      ));
    } else {
      dio = new Dio();
    }
    dio.options.headers['Authorization'] = token;
  }

  Future<dynamic> getApi(url) async {
    Response response = await _handleResponse(await dio.get(baseUrl + url));
    return response.data;
  }

  Future<dynamic> postApi(url, body) async {
    Response response = await _handleResponse(await dio.post(
      url,
      data: body,
    ));
    return response.data;
  }

  Future<Response> _handleResponse(Response response) async {
    if (debug) {
      print('HTTP STATUS CODE ' + response.statusCode.toString());
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
        break;
      case 422:
        throw HttpUnprocessableEntityException(message: response.data);
        break;
      case 404:
        throw HttpNotFoundException(message: jsonDecode(response.data));
        break;
      case 401:
        dynamic resultData = response.data;
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
