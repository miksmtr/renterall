import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:renterall/general_const.dart';
import 'package:renterall/models/interfaces/vehicle.dart';
import 'package:renterall/operators/scooter/hop/api/api.dart';
import 'package:renterall/operators/scooter/marti/api/api.dart';
import 'package:renterall/operators/scooter/mobi/api/api.dart';
import 'package:renterall/operators/scooter/palm/api/api.dart';
import 'package:latlong/latlong.dart';
import 'package:renterall/operators/taksi/bitaksi/api/api.dart';
import 'package:renterall/operators/taksi/itaksi/api/api.dart';

import 'operators/car/moov/api/api.dart';
import 'operators/scooter/dost/api/api.dart';
import 'operators/scooter/kedi/api/api.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  List<Vehicle> vehicleList = new List<Vehicle>();
  List<Marker> markerList = new List<Marker>();
  double lat = 0.0;
  double long = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return lat != 0
        ? new FlutterMap(
            options: new MapOptions(
              center: new LatLng(lat, long),
              zoom: 16,
            ),
            layers: [
              new TileLayerOptions(
                  urlTemplate:
                      'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c']),
              new MarkerLayerOptions(
                markers: markerList,
              ),
            ],
          )
        : Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
    ;
  }

  init() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    lat = _locationData.latitude;
    long = _locationData.longitude;

    getApi();

    setState(() {
      lat = _locationData.latitude;
      long = _locationData.longitude;
    });
  }

  getApi() async {
    DostApi dostApi = new DostApi(DOSTTOKEN);
    KediApi kediApi = new KediApi(KEDITOKEN);
    MartiApi martiApi = new MartiApi(MARTITOKEN);
    PalmApi palmApi = new PalmApi(PALMTOKEN);
    MobiApi mobiApi = new MobiApi(MOBITOKEN);
    HopApi hopApi = new HopApi(HOPTOKEN);
    MoovApi moovApi = new MoovApi(MOOVTOKEN);
    BiTaksiApi biTaksiApi = new BiTaksiApi(BITAKSITOKEN);
    ITaksiApi iTaksiApi = new ITaksiApi(ITAKSITOKEN);

    markerList.clear();
    markerList.add(
      new Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(lat, long),
        builder: (ctx) => new Container(
          child: Icon(
            Icons.location_pin,
            color: Colors.red,
          ),
        ),
      ),
    );

    try {
      getList(await iTaksiApi.getTaksi(lat, long), "taksi", "itaksi");
    } catch (e) {}

    try {
      getList(
        await martiApi.getScooters(
          latitude: (lat).toString(),
          longitude: (long).toString(),
          minPointLatitude: (long + 1.0).toString(),
          minPointLongitude: (long - 1.0).toString(),
          maxPointLatitude: (long + 1.0).toString(),
          maxPointLongitude: (long + 1.0).toString(),
        ),
        "scooter",
        "marti",
      );
    } catch (e) {}

    try {
      getList(await dostApi.getScooters(lat, long), "scooter", "dost");
    } catch (e) {}

    try {
      getList(await kediApi.getScooters(), "scooter", "kedi");
    } catch (e) {}

    try {
      getList(await palmApi.getScooters(), "scooter", "palm");
    } catch (e) {}

    try {
      getList(await mobiApi.getScooters(), "scooter", "mobi");
    } catch (e) {}

    try {
      getList(await hopApi.getScooters(lat.toString(), long.toString()),
          "scooter", "hop");
    } catch (e) {}

    try {
      getList(await moovApi.getCars(lat, long), "car", "moov");
    } catch (e) {}

    try {
      getList(await biTaksiApi.getTaksi(lat, long), "taksi", "bitaksi");
    } catch (e) {}
  }

  getList(list, type, company) async {
    setState(() {
      print("$type : " + company);
      for (dynamic item in list) {
        Vehicle vehicleItem = Vehicle(
          latitude: item.latitude ?? item.latitude ?? null,
          longitude: item.longitude ?? item.latitude ?? null,
          type: type ?? null,
          company: company ?? null,
        );
        vehicleList.add(vehicleItem);
        markerList.add(
          new Marker(
            width: 20.0,
            height: 20.0,
            point: LatLng(double.parse(vehicleItem.latitude.toString()),
                double.parse(vehicleItem.longitude.toString())),
            builder: (ctx) => new Container(
              child: Container(
                child: Image.asset(
                  "assets/operators/icons/" +
                      vehicleItem.type +
                      "/" +
                      vehicleItem.company +
                      ".png",
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
