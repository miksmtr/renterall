// 404 - not found
class HttpNotFoundException implements Exception {
  final dynamic message;

  HttpNotFoundException({this.message = ''});
}
