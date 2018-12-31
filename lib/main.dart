// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

const URL = "https://www.youtube.com";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Webview Example",
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future launchURL(String url) async{
    if (await canLaunch(url)){
      await launch(url,forceSafariVC: true,forceWebView: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Webview"),
      ),
      body:Center(
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
      ) ,
    );
  }
}
