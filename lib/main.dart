import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(
  home: StarWarsData(),
));

class StarWarsData extends StatefulWidget {
  @override
  _StarWarsDataState createState() => _StarWarsDataState();
}

class _StarWarsDataState extends State<StarWarsData> {
  final String url = "https://swapi.co/api/starships";
  List data;

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url),headers: {"Accept":"application/json"});
    setState(() {
      var resBody = json.decode(res.body);
      data= resBody['results'];
    });
    return "Success!";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Star Wars Starships"),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView.builder(
        itemCount: data==null ? 0 : data.length,
          itemBuilder: (BuildContext context,int index){
            return  new Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text("Name: "),
                            Text(data[index]["name"],
                            style: TextStyle(
                              fontSize: 18.0,color: Colors.black54
                            )),
                          ],
                        ),

                      ),
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Text("Model: "),
                            Text(data[index]["model"],
                                style: TextStyle(
                                    fontSize: 18.0,color: Colors.red
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    this.getSWData();
  }

}
