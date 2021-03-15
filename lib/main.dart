import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stopwatch/textAtas.dart';
import 'package:stopwatch/textLapAtas.dart';

import 'listViewBawah.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String hours = "00";
  String minutes = "00";
  String seconds = "00";
  int detik = 0;
  int detik_terakir;
  List<String> lap_history = [];
  //karena butuh waktu sebelumnya saja
  List<String> before_history = [];
  int nomor = 0;
  Timer timer;

  bool mulai = false;
  String text_button = "Play";

  void cari_before() {
    String temp;
    int temp2;
    if (nomor == 0) {
      temp = "+ " + this.hours + ":" + this.minutes + ":" + this.seconds;
    } else {
      temp2 = detik - detik_terakir;
      temp = "+ " +
          ((temp2 / (60 * 60)) % 60).floor().toString().padLeft(2, '0') +
          ":" +
          ((temp2 / 60) % 60).floor().toString().padLeft(2, '0') +
          ":" +
          (temp2 % 60).floor().toString().padLeft(2, '0');
    }
    this.detik_terakir = detik;
    this.before_history.add(temp);
  }

  void lap() {
    String temp;
    setState(() {
      cari_before();
      temp = (this.nomor).toString().padLeft(2, '0') +
          "      " +
          before_history[nomor] +
          "      " +
          this.hours +
          ":" +
          this.minutes +
          ":" +
          this.seconds;

      this.lap_history.add(temp);
      this.nomor++;
    });
  }

  void convert_detik() {
    setState(() {
//fungsi di cek apakah bolean dalam keadaan tombol play diklik jika ya jalankan
      if (mulai == true) {
        this.detik++;
        this.hours =
            ((detik / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
        this.minutes = ((detik / 60) % 60).floor().toString().padLeft(2, '0');
        this.seconds = (detik % 60).floor().toString().padLeft(2, '0');
      }
    });
  }

//langsung jalankan fungsi rekrusif ssaat di start aplikasinya
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => convert_detik());
  }

  void klik_mulai() {
    setState(() {
      if (mulai == false) {
        this.mulai = true;
        this.text_button = "Stop";
      } else {
        this.mulai = false;
        this.text_button = "Play";
      }
    });
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Stopwatch"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextAtas(hours: hours, minutes: minutes, seconds: seconds),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => klik_mulai(),
                    child: Text('$text_button', style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 5,
                  ),
                  SizedBox(width: 30.0),
                  RaisedButton(
                    onPressed: () => lap(),
                    child: Text('Lap', style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 5,
                  ),
                ],
              ),
              TextLapAtas(),
              SizedBox(width: 10.0),
              ListViewBawah(lap_history: lap_history),
            ],
          ),
        ),
      ),
    );
  }
}
