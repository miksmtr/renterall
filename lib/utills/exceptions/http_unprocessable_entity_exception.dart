// 422 - validation error
class HttpUnprocessableEntityException implements Exception {
  final dynamic message;

  HttpUnprocessableEntityException({this.message = ''});
}
