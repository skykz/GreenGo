import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/screens/feedbacks/create_feedback.dart';
import 'package:sizer/sizer.dart';

import 'custom_loader.dart';

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: 66.0.h,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CachedNetworkImage(
              placeholderFadeInDuration: Duration(milliseconds: 200),
              imageUrl:
                  'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
              imageBuilder: (context, imageProvider) => Center(
                child: Container(
                  width: width * 0.6,
                  height: 20.0.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              placeholder: (context, string) => Center(
                child: CustomProgressWidget(
                  color: Colors.grey,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                child: const Center(
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ),
            ),
            Text(
              'В нашем магазине с 08.12.2020',
              style: TextStyle(
                fontSize: 10.0.sp,
              ),
            ),
            RatingBarIndicator(
              rating: 3.5,
              itemBuilder: (context, index) => Icon(
                Icons.star_rounded,
                color: AppStyle.colorPurple,
              ),
              itemCount: 5,
              unratedColor: Colors.grey[300],
              itemSize: 30.0.sp,
              direction: Axis.horizontal,
            ),
            Center(
              child: Text(
                'Рейтинг рассчитан на основе оценок покупателей и качества работы продавца',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 10.0.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 1,
                      offset: Offset(0, 5),
                      color: Colors.grey[300],
                    )
                  ]),
              child: Center(child: Text('+ 7 777 777 77 77')),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 1,
                      offset: Offset(0, 5),
                      color: Colors.grey[300],
                    )
                  ]),
              child: Center(child: Text('ул. Толе-би 55а')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FlatButton(
                color: AppStyle.colorPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateFeedbackScreen(),
                    ),
                  );
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Оставить отзыв о магазине',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
