import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool mulai = false;
  void klik_mulai() {
    this.mulai = true;
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => klik_mulai(),
                    child: const Text('Play', style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 5,
                  ),
                  SizedBox(width: 30.0),
                  RaisedButton(
                    onPressed: () => klik_mulai(),
                    child: const Text('Lap', style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 5,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Text("Historic lap",
                    style: TextStyle(fontSize: 40, color: Colors.black54)),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text("01   +00:00:91    00:05:53",
                          style:
                              TextStyle(fontSize: 25, color: Colors.black54)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text("02   +00:05:65    00:05:34",
                          style:
                              TextStyle(fontSize: 25, color: Colors.black54)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
