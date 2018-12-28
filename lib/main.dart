// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gallery Demo",
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: DisplayPage(),
    );
  }
}

class DisplayPage extends StatelessWidget {
  final List<String> images = [
    'images/1.jpg',
    'images/2.jpg',
    'images/3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox.fromSize(
          size: Size.fromHeight(550.0),
          child: PageView.builder(
            controller: PageController(viewportFraction: 1.0),
            itemCount: images.length,
            itemBuilder: (BuildContext context,int index){
              return new Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(8.0),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                       Image.asset(
                         images[index],
                         fit: BoxFit.cover,
                       ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.bottomRight,
                            end: FractionalOffset.topLeft,
                            colors: [
                              Color(0x1c6d6c).withOpacity(0.2),
                              Color(0xf10101).withOpacity(0.2),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
