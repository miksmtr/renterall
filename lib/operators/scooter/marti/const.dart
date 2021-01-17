const String name = "marti";
const String type = "scooter";
const String apiUrl = "https://customer.martiscooter.com/v7/dispatch/";
const String icon = "assets/operators/$type/icons/$name.png";

/*

var headers = {
  'Content-Type': 'application/json',
  'x-access-token': '710218c2-81c9-430f-bee5-5bba94ce0a8d'
};
var request = http.Request('POST', Uri.parse('https://customer.martiscooter.com/v7/dispatch/map/listAvailables'));
request.body = '''{"latitude": "41.0451651","longitude": "29.0044374","minPointLatitude": "70.14037850944361","minPointLongitude": "-67.50003654509783","maxPointLatitude": "70.14037850944361","maxPointLongitude": "67.50002346932888","zoomLevel": "14.0"}''';
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}

*/
