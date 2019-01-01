// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:chat_app/screens/home.dart';
import 'package:chat_app/screens/favorites.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie Searcher",
      theme: ThemeData.dark(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Movie Seacher App"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.home),
                  text: "Home Page",
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                  text: "Favorites",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              HomePage(),
              Favorites(),
            ],
          ),
        ),),
    );
  }
}
