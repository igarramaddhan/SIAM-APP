import 'package:flutter/material.dart';
import 'package:siam/components/text_input.dart';
import 'package:siam/components/button.dart';
import 'package:siam/utils/metrics.dart';
import 'package:siam/utils/api.dart';

class LoginScreen extends StatefulWidget {
  static final String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String nim = '';
  String password = '';
  bool isLoading = false;

  void login() async {
    try {
      setState(() => isLoading = true);
      final response = await api.post(
        '/login',
        data: {"username": nim, "password": password},
      );

      print(response);
      api.setAuthToken(response['token']);
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e) {
      setState(() => isLoading = false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFormValid = nim.isNotEmpty && password.isNotEmpty;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("LOGIN"),
            TextInput(
              label: 'NIM',
              hint: 'Enter NIM',
              keyboardType: TextInputType.number,
              onChange: (text) {
                this.setState(() {
                  nim = text;
                });
              },
            ),
            TextInput(
              label: 'Password',
              hint: 'Enter password',
              obscureText: true,
              onChange: (text) {
                this.setState(() {
                  password = text;
                });
              },
            ),
            Button(
              text: isLoading ? "Loading..." : "LOGIN",
              onPress: (!isFormValid || isLoading) ? null : login,
              color: colors.secondary,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
