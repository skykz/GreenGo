import 'dart:async';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/components/widgets/top_list_products.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/feedbacks/create_view_feedback.dart';
import 'package:green_go/screens/fullImage/full_image_screen.dart';
import 'package:green_go/screens/home/single_store_category.dart';
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
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 35),
        child: AppBar(
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
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getSingleProduct,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null)
                return Center(child: const LoaderWidget());
              inspect(snapshot.data);
              return Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            CarouselSlider.builder(
                              itemCount: snapshot.data['data']['images'].length,
                              itemBuilder:
                                  (BuildContext context, int itemIndex) =>
                                      GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullImageScreen(
                                      listImages: snapshot.data['data']
                                          ['images'],
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: CachedNetworkImage(
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
                                                        .data['data']['images']
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
                                                      ? AppStyle.colorPurple
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
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
                                    rating:
                                        snapshot.data['data']['rating'] ?? 3.5,
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 3,
                                  height: 30,
                                ),
                              ],
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
                      onPressed: () {
                        homeProvider.addProductToCart(
                            snapshot.data['data']['id'], context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            'ДОБАВИТЬ В КОРЗИНУ',
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
                    child: ListTopProducts(
                      future: homeProvider.getProductsStore(
                        context,
                        snapshot.data['data']['storeId'],
                      ),
                    ),
                  ),
                  snapshot.data['data']['store'] != null
                      ? Padding(
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  settings: RouteSettings(
                                      arguments: snapshot.data['data']
                                          ['store']),
                                  builder: (context) =>
                                      SingleCategoryStoreHomeScreen(
                                    isStore: true,
                                  ),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        )
                      : const SizedBox(),
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
                    child: ListTopProducts(
                      future: homeProvider.getProductsStore(
                        context,
                        snapshot.data['data']['categoryId'],
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
