// 404 - not found
class HttpUnauthorizedException implements Exception {
  final dynamic message;

  HttpUnauthorizedException({this.message = ''});
}
