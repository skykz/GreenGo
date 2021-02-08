import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Platform.isIOS
          ? CupertinoActivityIndicator(
              radius: 15,
            )
          : CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.white,
            ),
    );
  }
}
