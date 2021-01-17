import 'package:flutter/material.dart';
import 'package:renterall/general_const.dart';

import 'operators/scooter/mobi/api/api.dart';

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

  init() async {
    var list;
    MobiApi mobiApi = new MobiApi(MOBITOKEN);
    list = await mobiApi.getScooters();
    for (var item in list) {
      print("mobiApi scooter code:  " + item.battery.toString());
    }

/*     HopApi hopApi = new HopApi(HOPTOKEN);
    list = await hopApi.getScooters("39.9207225", "32.851652");
    for (var item in list) {
      print("hopApi scooter code:  " + item.code.toString());
    } */

    /*   DostApi dostApi = new DostApi(DOSTTOKEN);
    list = await dostApi.getScooters(41.04411399, 29.00307961);
 */
/*     BiriApi dostApi = new BiriApi(BIRITOKEN);
    var list = await dostApi.getScooters(); */
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
