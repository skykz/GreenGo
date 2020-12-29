import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:sizer/sizer.dart';

class ListCustomItem extends StatelessWidget {
  final String title;
  final String path;
  final Function onTapped;
  final int notificationCount;
  const ListCustomItem(
      {Key key, this.path, this.notificationCount, this.title, this.onTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTapped,
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.0.sp,
          bottom: 8.0.sp,
          left: 3.0.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 7.0.w,
              child: Center(
                child: SvgPicture.asset(
                  this.path,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0.sp),
              child: Text(
                this.title,
                style: TextStyle(
                  fontSize: 13.0.sp,
                ),
                textAlign: TextAlign.left,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            this.notificationCount != null
                ? Padding(
                    padding: EdgeInsets.only(right: 3.0.w),
                    child: Text(
                      '4',
                      style: TextStyle(
                        fontSize: 13.0.sp,
                        color: AppStyle.colorPurple,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
