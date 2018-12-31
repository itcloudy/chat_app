// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
//import 'dart:async';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String url = "https://www.youtube.com";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Webview Example",
      theme: ThemeData.dark(),
//      home: Home(),
      routes: {
        "/":(_)=>Home(),
        "/webview":(_)=>WebviewScaffold(
          url:url,
          appBar: AppBar(
            title: Text("Webiew"),
          ),
          withJavascript: true,
          withLocalStorage: true,
          withZoom: true
        ),
      },
    );
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final webView = FlutterWebviewPlugin();
  TextEditingController controller = TextEditingController(text: url);


  @override
  void initState() {
    super.initState();
    webView.close();
    controller.addListener((){
      url = controller.text;
    });

  }


  @override
  void dispose() {
    webView.dispose();
    controller.dispose();
    super.dispose();
  }

  /* Future launchURL(String url) async{
    if (await canLaunch(url)){
      await launch(url,forceSafariVC: true,forceWebView: true);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webview"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: controller,
              ),
            ),
            RaisedButton(
              child: Text("Open Webview"),
              onPressed: (){
                Navigator.of(context).pushNamed("/webview");
              },
            ),
          ],
        ),
      ),
      /*body:Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(URL),
            ),
            RaisedButton(
              child: Text("Open Link"),
              onPressed: (){
                launchURL(URL);
              },
            ),
          ],
        ),
      ) ,*/
    );
  }
}
