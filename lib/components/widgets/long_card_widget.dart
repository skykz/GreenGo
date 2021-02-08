import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:sizer/sizer.dart';

class CardLongWidget extends StatelessWidget {
  final String title;
  final Function onTap;

  const CardLongWidget({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(0, 5),
              blurRadius: 7,
            )
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                this.title,
                style: TextStyle(
                  fontSize: 12.0.sp,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppStyle.colorPurple,
                size: 15.0.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
