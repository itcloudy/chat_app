// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:chat_app/model/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


const key = "5060c99387ded506a99751a41bf60e2e";


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie Searcher",
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> movies = List();
  bool hasLoaded = true;

  final PublishSubject subject = PublishSubject<String>();


  @override
  void dispose() {
    subject.close();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    subject.stream.debounce(Duration(milliseconds: 1000)).listen(searchMovies);

  }
  void searchMovies(query){
    resetMovies();
    if (query.isEmpty){
      setState(() {
        hasLoaded = true;
      });
    }
    setState(() {
      hasLoaded = false;
    });
    http.get('https://api.themoviedb.org/3/search/movie?api_key=$key&query=$query')
    .then((res){
      return res.body;
    })
    .then(json.decode)
    .then((map)=>map["results"])
    .then((movies){
      movies.forEach(addMovie);
    })
    .catchError(onError)
    .then((e){
      setState(() {
        hasLoaded = true;
      });
    });
  }
  void onError (dynamic d){
    setState(() {
      hasLoaded = true;
    });
  }
  void addMovie(item){
    setState(() {
      movies.add(Movie.fromJson(item));
    });
    print('${movies.map((m)=>m.title)}');
  }
  void resetMovies(){
    setState(() {
      movies.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Searcher'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
             TextField(
               onChanged: (String string)=>(subject.add(string)),
             ),
            hasLoaded ? Container(): CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: movies.length,
                itemBuilder: (BuildContext context,int index){
                  return new MovieView(movies[index]);
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class MovieView extends StatefulWidget {
  MovieView(this.movie);
  final Movie movie;


  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  Movie movieState;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200.0,
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            movieState.posterPath!=null
            ? Hero(
              child: Image.network("https://image.tmdb.org/t/p/w92${movieState.posterPath}"),
              tag: movieState.id,
            )
                :Container(),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        movieState.title,
                        maxLines: 10,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: movieState.favored
                      ?Icon(Icons.star): Icon(Icons.star_border),
                      color: Colors.white,
                      onPressed: (){},
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.arrow_downward),
                      color: Colors.white,
                      onPressed: (){},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    movieState = widget.movie;
  }
}
