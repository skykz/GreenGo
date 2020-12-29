import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/custom_loader.dart';
import 'package:sizer/sizer.dart';

class SingleProductScreen extends StatelessWidget {
  SingleProductScreen({Key key}) : super(key: key);
  final _scrollController = ScrollController();
  final _scrollController1 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              'МОНОБУКЕТ',
              style: TextStyle(
                fontSize: 13.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35),
            child: SizedBox(
              width: double.infinity,
              height: 20.0.h,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 14.0.sp,
                          color: AppStyle.colorPurple,
                        ),
                        onPressed: () {},
                      ),
                      CachedNetworkImage(
                        imageUrl:
                            'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                        imageBuilder: (context, imageProvider) => Center(
                          child: Container(
                            width: 32.0.w,
                            height: 17.0.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
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
                      IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14.0.sp,
                          color: AppStyle.colorPurple,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: AppStyle.colorPurple,
                        size: 25.0.sp,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.share_outlined,
                        size: 25.0.sp,
                        color: AppStyle.colorPurple,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 7,
                      offset: Offset(0, 7),
                      color: Colors.grey[300],
                    )
                  ]),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Категория: Букеты, монобукеты',
                          style: TextStyle(
                            fontSize: 11.0.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Ариткул: 000001',
                          style: TextStyle(
                            fontSize: 11.0.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Цена: 16 000 тг.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0.sp,
                          ),
                        ),
                      ),
                      Divider(
                        height: 30,
                        thickness: 3,
                      ),
                      Text(
                          'Пышные гортензии, королевские розы. Собираем букеты только из свежих цветов.'),
                      Divider(
                        thickness: 3,
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Отзывы: 12',
                          style: TextStyle(
                            fontSize: 11.0.sp,
                          ),
                        ),
                      ),
                      Text(
                        'Рейтинг:',
                        style: TextStyle(
                          fontSize: 11.0.sp,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.0.h),
                        child: RatingBarIndicator(
                          rating: 3.5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star_rounded,
                            color: AppStyle.colorPurple,
                          ),
                          itemCount: 5,
                          unratedColor: Colors.grey[300],
                          itemSize: 24.0.sp,
                          direction: Axis.horizontal,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: OutlineButton(
                          highlightColor: Colors.grey,
                          padding: const EdgeInsets.all(5),
                          borderSide: BorderSide(
                            color: AppStyle.colorGreen,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "Посмотреть отзывы",
                              style: TextStyle(
                                color: AppStyle.colorGreen,
                                fontSize: 11.0.sp,
                              ),
                            ),
                          ),
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: FlatButton(
              color: AppStyle.colorGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Text(
                  'ДОБАВИТЬ В КОРЗИНУ',
                  style: TextStyle(color: Colors.white, fontSize: 12.0.sp),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Похожие',
                style: TextStyle(
                  fontSize: 13.0.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 29.0.h,
            child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {},
                            child: Ink(
                              width: 43.0.w,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(0, 5),
                                      spreadRadius: 1,
                                      color: Colors.grey[300],
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                                    imageBuilder: (context, imageProvider) =>
                                        Center(
                                      child: Container(
                                        width: 21.0.w,
                                        height: 11.0.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      child: const Center(
                                        child: Icon(
                                          Icons.error_outline_rounded,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Center(
                                      child: Text(
                                        'Королевский свадебный',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.5.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Цена: 30 000',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.5.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite_outline_rounded,
                              color: AppStyle.colorPurple,
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppStyle.colorGreen,
                    ),
                    onPressed: () {
                      _scrollController.animateTo(
                          _scrollController.offset - 200,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppStyle.colorGreen,
                    ),
                    onPressed: () {
                      _scrollController.animateTo(
                          _scrollController.offset + 200,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Товары из этого магазина',
                style: TextStyle(
                  fontSize: 13.0.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 29.0.h,
            child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController1,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {},
                            child: Ink(
                              width: 43.0.w,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      offset: Offset(0, 5),
                                      spreadRadius: 1,
                                      color: Colors.grey[300],
                                    )
                                  ]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                                    imageBuilder: (context, imageProvider) =>
                                        Center(
                                      child: Container(
                                        width: 21.0.w,
                                        height: 11.0.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      child: const Center(
                                        child: Icon(
                                          Icons.error_outline_rounded,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Center(
                                      child: Text(
                                        'Королевский свадебный',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.5.sp,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Цена: 30 000',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.5.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite_outline_rounded,
                              color: AppStyle.colorPurple,
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: AppStyle.colorGreen,
                    ),
                    onPressed: () {
                      _scrollController1.animateTo(
                          _scrollController1.offset - 200,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppStyle.colorGreen,
                    ),
                    onPressed: () {
                      _scrollController1.animateTo(
                          _scrollController1.offset + 200,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: OutlineButton(
              highlightColor: Colors.grey,
              padding: const EdgeInsets.all(5),
              borderSide: BorderSide(
                color: AppStyle.colorGreen,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 17),
                child: Text(
                  "Добавить новый адрес",
                  style: TextStyle(
                    color: AppStyle.colorGreen,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
        ],
      ),
    );
  }
}
