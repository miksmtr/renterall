import 'package:flutter/material.dart';
import 'package:renterall/general_const.dart';
import 'package:renterall/operators/scooter/dost/api/api.dart';
import 'package:renterall/operators/scooter/marti/api/api.dart';

import 'operators/scooter/palm/api/api.dart';

const PALMTOKEN =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxMjg2NDZ9LCJpYXQiOjE2MTA3NDUwOTcsImV4cCI6MTYxMDgzMTQ5N30.DcF_DRedhsjZmx733VqMiHJZ1t37KR86a9SEFqOBxt0";

const MARTITOKEN = "43cabec6-8c2f-4246-881d-b269c0df90b2";

void main() {
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

  init() async {
    var list;
/*     PalmApi palmApi = new PalmApi(PALMTOKEN);
    list = await palmApi.getScooters();
    for (var item in list) {
      print("palm scooter code:  " + item.qrcode.toString());
    } 
  
  */

/*     MartiApi martiApi = new MartiApi(MARTITOKEN);
    list = await martiApi.getScooters();
    for (var item in list) {
      print(" marti scooter code:  " + item.qrcode.toString());
    } */

    DostApi dostApi = new DostApi(DOSTTOKEN);
    list = await dostApi.getScooters(41.04411399, 29.00307961);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
