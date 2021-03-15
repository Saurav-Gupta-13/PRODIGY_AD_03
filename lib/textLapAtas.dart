import 'package:flutter/material.dart';

class TextLapAtas extends StatelessWidget {
  const TextLapAtas({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Text("Historic lap",
          style: TextStyle(fontSize: 40, color: Colors.black54)),
    );
  }
}
