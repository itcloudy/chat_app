// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: Transform(
              transform: Matrix4.identity(),
              child: Container(
                height: 280.0,
                width: 280.0,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: <Color>[
                      Color(0xffef5350),
                      Color(0x00ef5350),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(1000.0),
                  border: Border.all(
                    color: Colors.black54,
                  ),
                ),

                alignment: Alignment.center,
                child: Text(
                  "Stylig Stuff",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w900,
                    fontFamily: "Georgia",
                  ),
//                textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
