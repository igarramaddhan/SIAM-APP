import 'package:flutter/material.dart';
import 'package:siam/utils/metrics.dart';

typedef OnChangeArgument(String text);

class TextInput extends StatefulWidget {
  final String label, hint, errorText;
  final bool obscureText;
  final TextEditingController controller;
  final OnChangeArgument onChange;
  final TextInputType keyboardType;

  TextInput({
    @required this.label,
    this.hint,
    this.obscureText: false,
    this.errorText,
    this.controller,
    this.onChange,
    this.keyboardType: TextInputType.text,
  });

  @override
  TextInputState createState() {
    return new TextInputState(obscureText ? false : true);
  }
}

class TextInputState extends State<TextInput> {
  bool showPwd = true;

  TextInputState(bool _showPwd) {
    showPwd = _showPwd;
  }

  @override
  Widget build(BuildContext context) {
    bool isError = widget.errorText == null || widget.errorText.isEmpty;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        // alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          TextField(
            onChanged: widget.onChange,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hint,
              labelText: widget.label,
              errorText: widget.errorText,
              labelStyle: TextStyle(
                color: isError ? colors.primary : Colors.red,
                fontSize: 18,
              ),
              errorStyle: TextStyle(
                color: Colors.red,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: colors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            obscureText: !showPwd,
          ),
          Positioned(
            right: 0,
            top: 6.5,
            child: widget.obscureText
                ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: isError
                          ? showPwd ? colors.secondary : Colors.grey
                          : Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        showPwd = !showPwd;
                      });
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
