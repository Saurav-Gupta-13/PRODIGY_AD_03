import 'package:flutter/material.dart';

class TextAtas extends StatelessWidget {
  const TextAtas({
    Key? key,
    required this.hours,
    required this.minutes,
    required this.seconds,
  }) : super(key: key);

  final String hours;
  final String minutes;
  final String seconds;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 250.0),
      child: Text("$hours:$minutes:$seconds",
          style: TextStyle(fontSize: 55, color: Colors.black54)),
    );
  }
}
