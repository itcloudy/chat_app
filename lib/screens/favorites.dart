// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:chat_app/model/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:chat_app/database/database.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {

  List<Movie> filteredMovies = List();
  List<Movie> movieCache = List();

  final PublishSubject subject = PublishSubject<String>();

  @override
  void initState() {
    super.initState();
    filteredMovies = [];
    movieCache = [];
    subject.stream.listen(searchDataList);
    setupList();

  }
  void setupList()async{
    MovieDatabase db = MovieDatabase();
    filteredMovies = await db.getMovies();
    setState(() {
      movieCache =filteredMovies;
    });

  }

  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  void searchDataList(query){
    if(query.isEmpty){
      setState(() {
        filteredMovies = movieCache;
      });
    }
    setState(() {});
    filteredMovies = filteredMovies
        .where((m)=> m.title
        .toLowerCase()
        .trim()
        .contains(RegExp(r''+query.toLowerCase().trim() +''))).toList();
    setState(() {});

  }

  void onPressed(int index){
    setState(() {
      filteredMovies.remove(filteredMovies[index]);
    });
    MovieDatabase db = MovieDatabase();
    try {
      db.deleteMovie(filteredMovies[index].id);
    }catch (e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (String string)=> (subject.add(string)),
            keyboardType: TextInputType.url,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: filteredMovies.length,
              itemBuilder: (BuildContext context,int index){
                return new ExpansionTile(
                  initiallyExpanded: filteredMovies[index].isExpanded ?? false,
                  onExpansionChanged: (b)=> filteredMovies[index].isExpanded = b,
                  children: <Widget>[
                    
                  ],
                  leading:  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: (){
                      onPressed(index);
                    },
                  ),
                  title: Container(
                    height: 200.0,
                    child: Row(
                      children: <Widget>[
                        filteredMovies[index].posterPath!=null
                        ? Hero(
                          child: Image.network("https://image.tmdb.org/t/p/w92${filteredMovies[index].posterPath}"),
                          tag: filteredMovies[index].id,
                        )
                            :Container(),
                        Expanded(
                          child: Text(
                            filteredMovies[index].title,
                            textAlign: TextAlign.center
                            ,maxLines: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

