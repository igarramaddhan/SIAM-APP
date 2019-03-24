import 'package:flutter/material.dart';

class JadwalScreen extends StatefulWidget {
  static final String routeName = '/Jadwal';

  @override
  _JadwalScreenState createState() => _JadwalScreenState();
}

class _JadwalScreenState extends State<JadwalScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text("Jadwal"),
    );
  }
}
