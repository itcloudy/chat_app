import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TempApp(),
    );
  }
}
class TempApp extends StatefulWidget {
  @override
  _TempAppState createState() => _TempAppState();
}

class _TempAppState extends State<TempApp> {
  double input;
  double output;
  bool fOrC;

  @override
  Widget build(BuildContext context) {
    TextField inputFiled = TextField(
      keyboardType: TextInputType.number,
      onChanged: (str){
        try{
          input = double.parse(str);
        }catch(e){
          input = 0.0;
        }
      },
      decoration: InputDecoration(
        labelText:
          "Input a Value ${fOrC == false ? "Fahrenheit":"Celsius"}",
      ),
    );

    AppBar appBar = AppBar(
      title: Text("Temperature Calculator"),

    );

    Container tempSwitch = Container(
      child: Column(
        children: <Widget>[
          Text("Choose Fahrenheit or Celsius"),
          Switch(
              value: fOrC,
              onChanged: (e){
                setState(() {
                  fOrC = !fOrC;
                });
              }
          ),
        ],
      ),
    );
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            inputFiled,
            tempSwitch
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Temperature Calculator"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    input = 0.0;
    output = 0.0;
    fOrC = true;
  }

}
