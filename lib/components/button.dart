import 'package:flutter/material.dart';
import 'package:siam/utils/metrics.dart';
import 'package:siam/utils/is_dark.dart';

class Button extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final Color color;
  final Color textColor;

  Button({@required this.onPress, this.text: "", this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    Color _btnColor = color != null ? color : colors.primary;
    Color _txtColor = textColor != null
        ? textColor
        : (isDark(_btnColor) ? Colors.black : Colors.white);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: RaisedButton(
        color: _btnColor,
        onPressed: onPress,
        textColor: _txtColor,
        disabledColor: Colors.black12,
        disabledTextColor: Colors.black26,
        child: Container(
          height: 48,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
