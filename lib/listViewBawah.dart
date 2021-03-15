import 'package:flutter/material.dart';

class ListViewBawah extends StatelessWidget {
  const ListViewBawah({
    Key key,
    @required this.lap_history,
  }) : super(key: key);

  final List<String> lap_history;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
          children: lap_history.map((String value) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(top: 5.0),
          child: Text(value,
              style: TextStyle(fontSize: 25, color: Colors.black54)),
        );
      }).toList()),
    );
  }
}
