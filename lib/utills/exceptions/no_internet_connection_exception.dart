class NoInternetConnectionException implements Exception {
  final dynamic message;

  NoInternetConnectionException({this.message = ''});
}
