import 'package:flutter/material.dart';

class AbsensiScreen extends StatefulWidget {
  static final String routeName = '/Absensi';

  @override
  _AbsensiScreenState createState() => _AbsensiScreenState();
}

class _AbsensiScreenState extends State<AbsensiScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text("Absensi"),
    );
  }
}
