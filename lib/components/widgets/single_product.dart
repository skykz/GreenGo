import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/screens/feedbacks/create_view_feedback.dart';
import 'package:green_go/utils/utils.dart';

import 'package:sizer/sizer.dart';

import 'loader_widget.dart';

class SingleStoreWidget extends StatelessWidget {
  final dynamic data;
  SingleStoreWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CachedNetworkImage(
              placeholderFadeInDuration: Duration(milliseconds: 200),
              imageUrl: this.data['avatar'],
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
                child: LoaderWidget(),
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'В нашем магазине с ${(this.data['createdAt'].toString().substring(0, 10))}',
                style: TextStyle(
                  fontSize: 10.0.sp,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: RatingBarIndicator(
                rating: this.data['rating'] ?? 4,
                itemBuilder: (context, index) => Icon(
                  Icons.star_rounded,
                  color: AppStyle.colorPurple,
                ),
                itemCount: 5,
                unratedColor: Colors.grey[300],
                itemSize: 32.0.sp,
                direction: Axis.horizontal,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              child: Center(
                child: Text(
                  'Рейтинг рассчитан на основе оценок покупателей и качества работы продавца',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 9.0.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      launchURL('tel:${this.data['phone']}');
                    },
                    child: Ink(
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
                      child: Center(
                        child: Text(
                          '${this.data['phone']}',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
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
                    child: Center(child: Text('${this.data['address']}')),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  FlatButton(
                    color: AppStyle.colorPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateViewFeedbackScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          'Оставить отзыв о магазине'.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.0.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: OutlineButton(
                      highlightColor: Colors.grey[300],
                      padding: const EdgeInsets.all(5),
                      highlightedBorderColor: Colors.green,
                      borderSide: BorderSide(
                        color: AppStyle.colorGreen,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          "Посмотреть отзывы".toUpperCase(),
                          style: TextStyle(
                            color: AppStyle.colorGreen,
                            fontSize: 11.0.sp,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateViewFeedbackScreen(
                              isView: true,
                            ),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
