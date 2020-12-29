import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoPartnersScreen extends StatelessWidget {
  const InfoPartnersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Text(
            'ПАРТНЕРАМ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Этот текст заполняется администратором. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis ...',
              style: TextStyle(
                fontSize: 12.0.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
