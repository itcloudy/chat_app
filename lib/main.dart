// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Example',
      theme: ThemeData.dark(),
      home: ScopedModel<AppModel>(
        model: AppModel(),
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final AppModel appModelOne = AppModel();
  final AppModel appModelTwo = AppModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Counter"),
      ),
      body: Center(
        child: Row (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ScopedModel<AppModel>(
              model: appModelOne,
              child: Counter(
                counterName: "App Model One",
              ),
            ),
            ScopedModel<AppModel>(
              model: appModelTwo,
              child: Counter(
                counterName: "App Model Two",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final String counterName;

  Counter({Key key,this.counterName});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (context,child,model)=>Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("$counterName:"),
          Text(
            model.count.toString(),
            style: Theme.of(context).textTheme.display1,
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: model.increment,
              ),
              IconButton(
                icon: Icon(Icons.minimize),
                onPressed: model.decrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class Home1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Counter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Counter:"),
            ScopedModelDescendant<AppModel>(
              builder: (context, child, model) => Text(
                    model.count.toString(),
                    style: Theme.of(context).textTheme.display1,
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: model.increment,
                ),
                IconButton(
                  icon: Icon(Icons.minimize),
                  onPressed: model.decrement,
                ),
              ],
            ),
      ),
    );
  }
}
