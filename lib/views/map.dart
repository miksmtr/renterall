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
import 'package:simple_tooltip/simple_tooltip.dart';

import '../operators/car/moov/api/api.dart';
import '../operators/scooter/dost/api/api.dart';
import '../operators/scooter/kedi/api/api.dart';

class MapScreen extends StatefulWidget {
  //MapScreen({this.drawerKey});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapScreen> {
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
    mapController = MapController();
  }

  LatLng centerLocation;
  MapOptions mapOptions;
  MapController mapController;
  @override
  Widget build(BuildContext context) {
    return lat != 0
        ? Stack(
            children: [
              new FlutterMap(
                mapController: mapController,
                options: mapOptions,
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c']),
                  new MarkerLayerOptions(
                    markers: markerList,
                  ),
                ],
              ),
              Positioned(
                  bottom: 25,
                  right: 25,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        mapController.move(centerLocation, 17);
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.gps_fixed_outlined,
                        size: 35,
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(color: Colors.white),
                child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 35,
                    ),
                    onPressed: () async {
                      print(6);
                      await showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(100, 100, 100, 100),
                        items: [
                          PopupMenuItem(
                            child: Text("add"),
                          ),
                          PopupMenuItem(
                            child: Text("remove"),
                          ),
                        ],
                        elevation: 8.0,
                      );
                    }),
              ),
              Positioned(
                top: 25,
                right: 0,
                left: 0,
                height: 50,
                child: Image.asset("assets/logo/logo.png"),
              )
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
    markerList.clear();

    getApi();

    setState(() {
      centerLocation =
          new LatLng(_locationData.latitude, _locationData.longitude);
      mapOptions = new MapOptions(
          center: LatLng(_locationData.latitude, _locationData.longitude),
          zoom: 17,
          maxZoom: 18,
          minZoom: 16);
      lat = _locationData.latitude;
      long = _locationData.longitude;
      markerList.add(
        new Marker(
          width: 70,
          height: 70,
          point: centerLocation,
          builder: (ctx) => new Container(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
            ),
          ),
        ),
      );
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

    try {
      getList(await iTaksiApi.getTaksi(lat, long), "taxi", "itaksi");
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
      getList(await biTaksiApi.getTaksi(lat, long), "taxi", "bitaksi");
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
            width: 65,
            height: 30,
            point: LatLng(double.parse(vehicleItem.latitude.toString()),
                double.parse(vehicleItem.longitude.toString())),
            builder: (ctx) => new Container(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black.withOpacity(0.5), width: 1),
                  color: Colors.white.withOpacity(0.8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 27,
                      height: 27,
                      child: Image.asset(
                        "assets/operators/icons/" +
                            vehicleItem.type +
                            "/" +
                            vehicleItem.company +
                            ".png",
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 1),
                        width: 1,
                        height: 27,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        )),
                    Container(
                      width: 27,
                      height: 27,
                      child: Image.asset(
                        "assets/icons/" + type + ".png",
                      ),
                    ),
                  ],
                )),
          ),
        );
      }
    });
  }
}
