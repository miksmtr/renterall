import 'dart:async';
import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:renterall/database/firestore.dart';
import 'package:renterall/general_const.dart';
import 'package:renterall/models/interfaces/operator.dart';
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
  List<Operator> operatorList = new List<Operator>();
  MapScreen({this.operatorList});

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
  DostApi dostApi;
  KediApi kediApi;
  MartiApi martiApi;
  PalmApi palmApi;
  MobiApi mobiApi;
  HopApi hopApi;
  MoovApi moovApi;
  BiTaksiApi biTaksiApi;
  ITaksiApi iTaksiApi;

  List<Operator> operatorList = new List<Operator>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    mapController = MapController();
  }

  bool isLoading = true;
  LatLng centerLocation;
  MapOptions mapOptions;
  MapController mapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _locationData != null
            ? new FlutterMap(
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
              )
            : getLoadingWidget(),
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
          ),
        ),
        Positioned(
          bottom: 85,
          right: 25,
          child: GestureDetector(
            onTap: () async {
              await getApi();
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          ),
        ),
        !isLoading
            ? Positioned(
                top: 25,
                right: 0,
                left: 0,
                height: 50,
                child: Image.asset("assets/logo/logo.png"),
              )
            : getLoadingWidget()
      ],
    );
  }

  init() async {
    await getLocation();
    FireStoreHelper fireStoreHelper = FireStoreHelper('operatorler');
    operatorList = await fireStoreHelper.getAllData();
    await getApi();
  }

  getApi() async {
    setState(() {
      isLoading = true;
    });

    markerList.clear();
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
    for (Operator item in operatorList) {
      if (item.name == 'dost') {
        dostApi = new DostApi(item.operatorSub.token);
        try {
          getList(await dostApi.getScooters(lat, long), item.operatorSub);
        } catch (e) {}
      }

      if (item.name == 'marti') {
        martiApi = new MartiApi(item.operatorSub.token);
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
              item.operatorSub);
        } catch (e) {}
      }

      if (item.name == 'palm') {
        palmApi = new PalmApi(item.operatorSub.token);
        try {
          getList(await palmApi.getScooters(), item.operatorSub);
        } catch (e) {}
      }

      if (item.name == 'mobi') {
        mobiApi = new MobiApi(item.operatorSub.token);
        try {
          getList(await mobiApi.getScooters(), item.operatorSub);
        } catch (e) {}
      }

      if (item.name == 'mobi') {
        kediApi = new KediApi(item.operatorSub.token);
        try {
          getList(await kediApi.getScooters(), item.operatorSub);
        } catch (e) {}
      }

      if (item.name == 'hop') {
        hopApi = new HopApi(item.operatorSub.token);
        try {
          getList(await hopApi.getScooters(lat.toString(), long.toString()),
              item.operatorSub);
        } catch (e) {}
      }

      if (item.name == 'moov') {
        moovApi = new MoovApi(item.operatorSub.token);
        try {
          getList(await moovApi.getCars(lat, long), item.operatorSub);
        } catch (e) {}
      }

      if (item.name == 'moov') {
        biTaksiApi = new BiTaksiApi(item.operatorSub.token);
        try {
          getList(await biTaksiApi.getTaksi(lat, long), item.operatorSub);
        } catch (e) {}
      }

      if (item.name == 'moov') {
        iTaksiApi = new ITaksiApi(item.operatorSub.token);
        try {
          getList(await iTaksiApi.getTaksi(lat, long), item.operatorSub);
        } catch (e) {}
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  getList(list, OperatorSub operatorSub) {
    print(operatorSub.type.toString());
    setState(() {
      for (dynamic item in list) {
        Vehicle vehicleItem = Vehicle(
          latitude: item.latitude ?? item.latitude ?? null,
          longitude: item.longitude ?? item.latitude ?? null,
          type: operatorSub.type ?? null,
          company: operatorSub.name ?? null,
        );
        vehicleList.add(vehicleItem);

        markerList.add(
          new Marker(
              width: 65,
              height: 30,
              point: LatLng(double.parse(vehicleItem.latitude.toString()),
                  double.parse(vehicleItem.longitude.toString())),
              builder: (ctx) => new GestureDetector(
                    onTap: () async {
                      await openPopup(operatorSub);

                      // Enter thr pa
                    },
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 3),
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
                                    operatorSub.type +
                                    "/" +
                                    operatorSub.name +
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
                                "assets/icons/" + operatorSub.type + ".png",
                              ),
                            ),
                          ],
                        )),
                  )),
        );
      }
    });
  }

  getLocation() async {
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
    var data = await location.getLocation();
    setState(() {
      _locationData = data;
    });

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
    });
  }

  Widget getLoadingWidget() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  openPopup(OperatorSub operatorSub) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0)),
              color: Colors.white),
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    "assets/icons/" + operatorSub.type + ".png",
                    color: greenColor.withOpacity(0.7),
                  ),
                ),
                title: Container(
                  width: 35,
                  height: 35,
                  child: Image.asset(
                    "assets/operators/icons/" +
                        operatorSub.type +
                        "/" +
                        operatorSub.name +
                        ".png",
                  ),
                ),
                trailing: Container(
                  width: 50,
                  height: 50,
                  child: new IconButton(
                    icon: Icon(Icons.launch_sharp),
                    iconSize: 30,
                    color: greenColor,
                    onPressed: () async {
                      if (Platform.isIOS) {
                        await LaunchApp.openApp(
                          iosUrlScheme: 'pulsesecure://',
                          appStoreLink:
                              'itms-apps://itunes.apple.com/tr/app/pulse-secure/' +
                                  operatorSub.domain.ios,
                          // openStore: false
                        );
                      } else {
                        await LaunchApp.openApp(
                            androidPackageName: operatorSub.domain.android);
                      }
                    },
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.battery_alert,
                          color: greenColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text("86 %")
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: greenColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text("1.99 TL + 0.69 TL")
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.space_bar,
                          color: greenColor,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text("0.5 KM")
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
