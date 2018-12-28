// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator Layout" ,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String inputString = "20 + 30";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.blueGrey.withOpacity(0.85),
              child: Row(
                children: <Widget>[
                  Text(
                    inputString,
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 48.0,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5 ,
            child: Container(
              child: Column(
                children: <Widget>[
                  makeBtns("C%</"),
                  makeBtns("789x"),
                  makeBtns("456-"),
                  makeBtns("123+"),
                  makeBtns("_0.="),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget makeBtns(String row){
    List<String> token = row.split("");
    return Expanded(
      flex: 1,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: token.map((e)=>CalcButton(
            keyvalue:e== '_'? "+/-":e=='<'?"<=":e,
          ))
          .toList(),
        ),
    );
  }
  
}


class CalcButton extends StatelessWidget {
  final String keyvalue;

  CalcButton({this.keyvalue});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: FlatButton(
        shape: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 2.0,
          style: BorderStyle.solid,
        ),
        color: Colors.white,
        onPressed: (){

        },
        child: Text(
          keyvalue,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 36.0,
            color: Colors.black54,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
    );
  }
}
