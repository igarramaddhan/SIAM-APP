import 'package:flutter/material.dart';

class KHSScreen extends StatefulWidget {
  static final String routeName = '/KHS';

  @override
  _KHSScreenState createState() => _KHSScreenState();
}

class _KHSScreenState extends State<KHSScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text("KHS"),
    );
  }
}
