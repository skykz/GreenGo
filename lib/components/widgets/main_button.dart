import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const MainButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: AppStyle.colorGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(this.text),
      ),
      onPressed: onPressed,
    );
  }
}
