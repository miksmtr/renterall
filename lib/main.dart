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
              zoom: 15,
            ),
            layers: [
              new TileLayerOptions(
                  opacity: 0.9,
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

  List<Vehicle> vehicleList = new List<Vehicle>();
  List<Marker> markerList = new List<Marker>();
  double lat = 0.0;
  double long = 0.0;
  init() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

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
    var list;
    DostApi dostApi = new DostApi(DOSTTOKEN);
    KediApi kediApi = new KediApi(KEDITOKEN);
    MartiApi martiApi = new MartiApi(MARTITOKEN);
    PalmApi palmApi = new PalmApi(PALMTOKEN);
    MobiApi mobiApi = new MobiApi(MOBITOKEN);
    HopApi hopApi = new HopApi(HOPTOKEN);
    MoovApi moovApi = new MoovApi(MOOVTOKEN);

    list = null;
    lat = _locationData.latitude;
    long = _locationData.longitude;
    list = await martiApi.getScooters(
      latitude: (lat).toString(),
      longitude: (long).toString(),
      minPointLatitude: (long + 1.0).toString(),
      minPointLongitude: (long - 1.0).toString(),
      maxPointLatitude: (long + 1.0).toString(),
      maxPointLongitude: (long + 1.0).toString(),
    );
    addVehicle(list, "marti");

    print("marti");

    list = null;
    list = await kediApi.getScooters();
    addVehicle(list, "kedi");

    print("kedi");

/*     list = null;
    list = await dostApi.getScooters(lat, long);
    addVehicle(list, "dost");
    print("dost"); */

    list = null;
    list = await palmApi.getScooters();
    addVehicle(list, "palm");

    print("palm");

    list = null;
    list = await mobiApi.getScooters();
    addVehicle(list, "mobi");

    print("mobi");

    list = null;
    list = await hopApi.getScooters(lat.toString(), long.toString());
    addVehicle(list, "hop");

    print("hop");

    list = null;
    list = await moovApi.getCars(lat, long);
    addVehicle(list, "moov", type: "car");

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
    for (dynamic vehicleItem in vehicleList) {
      markerList.add(
        new Marker(
          width: 30.0,
          height: 30.0,
          point: LatLng(double.parse(vehicleItem.latitude.toString()),
              double.parse(vehicleItem.longitude.toString())),
          builder: (ctx) => new Container(
            child: Image.asset("assets/operators/icons/" +
                vehicleItem.type +
                "/" +
                vehicleItem.company +
                ".png"),
          ),
        ),
      );
    }

    setState(() {
      lat = _locationData.latitude;
      long = _locationData.longitude;
    });
  }

  addVehicle(list, company, {type = "scooter"}) {
    for (dynamic item in list) {
      Vehicle vehicleItem = Vehicle(
        latitude: item.latitude ?? item.latitude ?? null,
        longitude: item.longitude ?? item.latitude ?? null,
        /*  battery: item.battery ?? item.batteryPercentage ?? null,
        distance: item.distance ??
            item.remaining_distance ??
            item.remaining_mileage ??
            item.tripDistance ??
            null, */
        type: type ?? null,
        company: company ?? null,
      );
      vehicleList.add(vehicleItem);
    }
  }
}
