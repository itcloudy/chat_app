import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:battery/battery.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Utils Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Battery battery = Battery();
  BatteryState batteryState;

  StreamSubscription<BatteryState> batSub;

  ConnectivityResult connectionStatus;
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> connSub;


  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  AndroidDeviceInfo androidDeviceInfo;
  IosDeviceInfo iosDeviceInfo;

  Future<Null>  initPlatform() async {
    ConnectivityResult result;
    AndroidDeviceInfo aInfo;
    IosDeviceInfo iInfo;


    try {
      if(Platform.isAndroid){
        aInfo = await deviceInfoPlugin.androidInfo;
      }else if (Platform.isIOS){
        iInfo = await deviceInfoPlugin.iosInfo;
      }
      result = await connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
      result = null;
    }
    if (!mounted) return;
    setState(() {
      connectionStatus = result;
      androidDeviceInfo = aInfo;
      iosDeviceInfo = iInfo;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatform();
    connSub = connectivity.onConnectivityChanged.listen((ConnectivityResult result){
      setState(() {
        connectionStatus = result;
      });
    });
    batSub = battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        batteryState = state;
      });
    });
  }

  @override
  void dispose() {
    batSub?.cancel();
    connSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Utils"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Battery: $batteryState'),
            Text('Connection Status: $connectionStatus'),
            Text('Device Model: ${iosDeviceInfo.model}'),
            Text('Device SystemVersion: ${iosDeviceInfo.systemVersion}'),
            Text('Device systemName: ${iosDeviceInfo.systemName}'),
            Text('Device utsname: ${iosDeviceInfo.utsname}'),
            Text('Device isPhysicalDevice: ${iosDeviceInfo.isPhysicalDevice}'),

          ],
        ),
      ),
    );
  }
}
