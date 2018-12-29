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
                  boxShadow: <BoxShadow>[
//                    BoxShadow(
//                      color: Color(0xcc000000),
//                      offset: Offset(0.0, 2.0),
//                      blurRadius: 4.0,
//                    ),
//                    BoxShadow(
//                      color: Color(0x80000000),
//                      offset: Offset(0.0, 6.0),
//                      blurRadius: 20.0,
//                    ),
                  ],
//                  borderRadius: BorderRadius.circular(1000.0),
//                  border: Border.all(
//                    color: Colors.black54,
//                  ),
                  shape: BoxShape.rectangle,
                ),

                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Stylig '),
                      TextSpan(text: 'Stuff')
                    ]
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
