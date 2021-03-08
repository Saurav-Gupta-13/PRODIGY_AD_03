import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Stopwatch"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 250.0),
                child: Text("00:00:00",
                    style: TextStyle(fontSize: 55, color: Colors.black54)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
