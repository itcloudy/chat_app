// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'input.dart';
import 'package:chat_app/form.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: MaterialApp(
        title: "test",
        color: Colors.blue,
        home: AllPage(),
      ),
    );
  }
}

class AllPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FlatButton(
          child: Text("输入框"),
          textColor: Colors.blue,
          onPressed: (){
            Navigator.push(context,
              new MaterialPageRoute(
                builder: (context){
                  return new Input();
                }
              ),
            );
          },
        ),
        FlatButton(
          child: Text("表单"),
          textColor: Colors.blue,
          onPressed: (){
            Navigator.push(context,
              new MaterialPageRoute(
                  builder: (context){
                    return new FormTest();
                  }
              ),
            );
          },
        ),
      ],
    );
  }
}
