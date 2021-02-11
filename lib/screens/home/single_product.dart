import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/feedbacks/create_view_feedback.dart';
import 'package:green_go/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SingleProductScreen extends StatefulWidget {
  final dynamic singleProductData;
  SingleProductScreen({Key key, this.singleProductData}) : super(key: key);

  @override
  _SingleProductScreenState createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen> {
  Future getSingleProduct;
  StreamController _streamController;

  @override
  void initState() {
    _streamController = StreamController.broadcast();

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    getSingleProduct = homeProvider.getSingleProduct(
        this.widget.singleProductData['id'], context);

    super.initState();
  }

  @override
  void dispose() {
    _streamController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20.0.sp,
            color: Colors.purple[400],
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getSingleProduct,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null)
                return Center(child: const LoaderWidget());
              return Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: CarouselSlider.builder(
                                  itemCount:
                                      snapshot.data['data']['images'].length,
                                  itemBuilder:
                                      (BuildContext context, int itemIndex) =>
                                          CachedNetworkImage(
                                    imageUrl: snapshot.data['data']['images']
                                        [itemIndex]['src'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, string) =>
                                        const Center(
                                      child: LoaderWidget(),
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
                                  options: CarouselOptions(
                                      height: 30.0.h,
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 5),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                      onPageChanged: (index, reason) {
                                        _streamController.add(index);
                                      }),
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 0,
                                right: 0,
                                child: StreamBuilder(
                                    stream: _streamController.stream,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapS) {
                                      return Container(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              for (var i = 0;
                                                  i <
                                                      snapshot
                                                          .data['data']
                                                              ['images']
                                                          .length;
                                                  i++)
                                                Container(
                                                  width: 8,
                                                  height: 8,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 2.0),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: snapS.data == i
                                                        ? AppStyle.colorGreen
                                                        : Colors.grey[300],
                                                  ),
                                                )
                                            ]),
                                      );
                                    }),
                                // Positioned(
                                //   top: 0,
                                //   right: 0,
                                //   child: IconButton(
                                //     icon: Icon(
                                //       Icons.share_outlined,
                                //       size: 25.0.sp,
                                //       color: AppStyle.colorPurple,
                                //     ),
                                //     onPressed: () {},
                                //   ),
                                // ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                  color: Colors.grey[300],
                                )
                              ]),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 6,
                                        child: Text(
                                          snapshot.data['data']['title']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 13.0.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.favorite_border_rounded,
                                            color: AppStyle.colorPurple,
                                            size: 25.0.sp,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'Категория: ${snapshot.data['data']['category']['title']},${snapshot.data['data']['category']['parent'] == null ? '' : snapshot.data['data']['category']['parent']['title']}',
                                      style: TextStyle(
                                        fontSize: 11.0.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'Ариткул: ${snapshot.data['data']['code'] ?? ''}',
                                      style: TextStyle(
                                        fontSize: 11.0.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      'Цена: ${snapshot.data['data']['cost']} тг.',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0.sp,
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 30,
                                    thickness: 3,
                                  ),
                                  Text(snapshot.data['data']['description']
                                      .toString()),
                                  Divider(
                                    thickness: 3,
                                    height: 30,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Text(
                                      'Посмотрели: ${snapshot.data['data']['viewsCount']}',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Text(
                                      'Позвонили: ${snapshot.data['data']['reviewsCount']}',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Text(
                                      'Отзывы: ${snapshot.data['data']['reviewsCount']}',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Text(
                                      'Рейтинг:',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.0.h),
                                    child: RatingBarIndicator(
                                      rating: snapshot.data['data']['rating'] ??
                                          3.5,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star_rounded,
                                        color: AppStyle.colorPurple,
                                      ),
                                      itemCount: 5,
                                      unratedColor: Colors.grey[300],
                                      itemSize: 25.0.sp,
                                      direction: Axis.horizontal,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
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
                                            builder: (context) =>
                                                CreateViewFeedbackScreen(
                                              isView: true,
                                            ),
                                          ),
                                        );
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: FlatButton(
                      color: AppStyle.colorGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'ДОБАВИТЬ В КОРЗИНУ'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white, fontSize: 11.0.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    child: OutlineButton(
                      highlightColor: Colors.purple[100],
                      highlightedBorderColor: Colors.purple,
                      borderSide: BorderSide(
                        color: AppStyle.colorPurple,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 25),
                        child: Text(
                          "Позвонить владельцу".toUpperCase(),
                          style: TextStyle(
                            color: AppStyle.colorPurple,
                            fontSize: 11.0.sp,
                          ),
                        ),
                      ),
                      onPressed: () {
                        launchURL(
                            'tel:${snapshot.data['data']['author']['phone']}');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Товары из этого магазина\n',
                        style: TextStyle(
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0.h,
                    child: FutureBuilder(
                        future: homeProvider.getProductsStore(
                            context, snapshot.data['data']['storeId']),
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if (snap.data == null)
                            return Center(child: const LoaderWidget());
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snap.data['data'].length,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 12),
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SingleProductScreen(
                                              singleProductData:
                                                  snap.data['data'][index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Ink(
                                        width: 43.0.w,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: snap.data['data'][index]
                                                      ['avatar'] ??
                                                  'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Center(
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, string) =>
                                                  const Center(
                                                child: LoaderWidget(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
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
                                                  snap.data['data'][index]
                                                          ['title']
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.5.sp,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Цена: ${snap.data['data'][index]['cost']}',
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
                          );
                        }),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Похожие\n',
                        style: TextStyle(
                          fontSize: 13.0.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0.h,
                    child: FutureBuilder(
                        future: homeProvider.getProductsStore(
                            context, snapshot.data['data']['categoryId']),
                        builder: (BuildContext context, AsyncSnapshot snaps) {
                          if (snaps.data == null)
                            return Center(child: const LoaderWidget());

                          if (snaps.data['data'].length == 0)
                            return Center(
                              child: const Text('Нету похожих товаров'),
                            );
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snaps.data['data'].length,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 12),
                            itemBuilder: (BuildContext context, int i) {
                              return Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SingleProductScreen(
                                              singleProductData:
                                                  snaps.data['data'][i],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Ink(
                                        width: 43.0.w,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: snaps.data['data'][i]
                                                  ['avatar'],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Center(
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, string) =>
                                                  Center(
                                                child: LoaderWidget(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
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
                                                  snaps.data['data'][i]
                                                      ['title'],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.5.sp,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Цена: ${snaps.data['data'][i]['cost']}',
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
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: OutlineButton(
                      highlightColor: Colors.purple[100],
                      padding: const EdgeInsets.all(5),
                      highlightedBorderColor: Colors.purple,
                      borderSide: BorderSide(
                        color: AppStyle.colorPurple,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 7, horizontal: 25),
                        child: Text(
                          "Перейти в магазин".toUpperCase(),
                          style: TextStyle(
                            color: AppStyle.colorPurple,
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
                  SizedBox(
                    height: 5.0.h,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
