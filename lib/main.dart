// Copyright 2018 itcloudy@qq.com.  All rights reserved.
// Use of this source code is governed by a MIT style
// license that can be found in the LICENSE file.
import 'package:flutter/material.dart';
import 'dart:math';

enum TitleState { covered, blown, open, flagged, revealed }

void main() => runApp(MineSweeper());

class MineSweeper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mine Sweeper",
      home: Board(),
    );
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final int rows = 9;
  final int cols = 9;
  final int numOfMines = 11;

  List<List<TitleState>> uiState;
  List<List<bool>> titles;

  void resetBoard() {
    uiState = new List<List<TitleState>>.generate(rows, (row) {
      return new List<TitleState>.filled(cols, TitleState.covered);
    });
    titles = new List<List<bool>>.generate(rows, (row) {
      return new List<bool>.filled(cols, false);
    });
    Random random = Random();
    int remainingMindes = numOfMines;
    while (remainingMindes > 0) {
      int pos = random.nextInt(rows * cols);
      int row = pos ~/ rows;
      int col = pos % cols;
      if (!titles[row][col]) {
        titles[row][col] = true;
        remainingMindes--;
      }
    }
  }

  @override
  void initState() {
    resetBoard();
    super.initState();
  }

  Widget buildBoard() {
    List<Row> boardRow = <Row>[];
    for (int i = 0; i < rows; i++) {
      List<Widget> rowChildren = <Widget>[];
      for (int j = 0; j < cols; j++) {
        TitleState state = uiState[i][j];
        if (state == TitleState.covered || state == TitleState.flagged) {
          rowChildren.add(GestureDetector(
            child: Listener(
              child: CoveredMineTile(
                flagged: state == TitleState.flagged,
                postY: j,
                posX: i,
              ),
            ),
          ));
        }else{
          rowChildren.add(OpenMineTile(
            state: state,
            count: 1,
          ));
        }
      }
      boardRow.add(Row(
        children: rowChildren,
        mainAxisAlignment: MainAxisAlignment.center,
        key: ValueKey<int>(i),
      ));
    }
    return Container(
      color: Colors.grey[700],
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: boardRow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mine Sweeper"),
      ),
      body: Container(
        color: Colors.grey[50],
        child: Center(
          child: buildBoard(),
        ),
      ),
    );
  }
}

Widget buildTile(Widget child) {
  return Container(
    padding: EdgeInsets.all(1.0),
    height: 30.0,
    width: 30.0,
    color: Colors.grey[400],
    margin: EdgeInsets.all(2.0),
    child: child,
  );
}

Widget buildInnerTile(Widget child) {
  return Container(
    padding: EdgeInsets.all(1.0),
    margin: EdgeInsets.all(2.0),
    height: 20.0,
    width: 20.0,
    child: child,
  );
}

class CoveredMineTile extends StatelessWidget {
  final bool flagged;
  final int posX;
  final int postY;

  CoveredMineTile({this.flagged, this.posX, this.postY});

  @override
  Widget build(BuildContext context) {
    Widget text;
    if (flagged) {
      text = buildInnerTile(RichText(
        text: TextSpan(
          text: "\u2691",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
      ));
    }
    Widget innerTile = Container(
      padding: EdgeInsets.all(1.0),
      margin: EdgeInsets.all(2.0),
      height: 20.0,
      width: 20.0,
      color: Colors.grey[350],
      child: text,
    );
    return buildTile(innerTile);
  }
}

class OpenMineTile extends StatelessWidget {
  final TitleState state;
  final int count;

  OpenMineTile({this.state, this.count});

  @override
  Widget build(BuildContext context) {
    Widget text;
    if (state ==TitleState.open){
      if(count!=0){
        text = RichText(
          text: TextSpan(
            text: '$count',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            )
          ),
          textAlign: TextAlign.center,
        );
      }
    }else{
      text = RichText(
        text: TextSpan(
          text: '\u2739',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        textAlign: TextAlign.center,
      );
    }
    return buildTile(buildInnerTile(text));
  }
}
