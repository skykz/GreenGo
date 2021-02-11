import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/feedbacks/create_view_feedback.dart';
import 'package:green_go/screens/home/single_product.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/viewFeedBacks':
                  return CreateViewFeedbackScreen(
                    isView: true,
                  );
                case '/singleProduct':
                  return SingleProductScreen();
                default:
                  return SearchListItems();
                  break;
              }
            });
      },
    );
  }
}

class SearchListItems extends StatelessWidget {
  SearchListItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    if (homeProvider.getIsLoading)
      return const Center(
        child: LoaderWidget(),
      );
    if (homeProvider.foundedList == null)
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: const Text(
            'Нету данных!',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: homeProvider.foundedList != null
                  ? homeProvider.foundedList['data'].length
                  : 0,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (BuildContext context, int index) {
                if (homeProvider.foundedList['data'].length == 0)
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: const Text('Нету данных!'),
                    ),
                  );
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Stack(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleProductScreen(),
                            ),
                          );
                        },
                        child: Ink(
                          width: double.infinity,
                          height: 20.0.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 10,
                                offset: Offset(0, 7),
                                spreadRadius: 1,
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: CachedNetworkImage(
                                  imageUrl: homeProvider.foundedList['data']
                                      [index]['avatar'],
                                  imageBuilder: (context, imageProvider) =>
                                      Center(
                                    child: Container(
                                      width: 21.0.w,
                                      height: 11.0.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
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
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        homeProvider.foundedList['data'][index]
                                                ['title']
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.0.sp,
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Магазин:\n',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 9.5.sp,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: homeProvider.foundedList[
                                                              'data'][index]
                                                          ['store'] ==
                                                      null
                                                  ? homeProvider.foundedList[
                                                          'data'][index]
                                                      ['author']['fullName']
                                                  : homeProvider
                                                          .foundedList['data']
                                                      [index]['store']['title'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.0.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Рейтинг:',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 9.5.sp,
                                              ),
                                            ),
                                            RatingBarIndicator(
                                              rating: homeProvider
                                                          .foundedList['data']
                                                      [index]['rating'] ??
                                                  3.5,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star_rounded,
                                                color: AppStyle.colorPurple,
                                              ),
                                              itemCount: 5,
                                              unratedColor: Colors.grey[300],
                                              itemSize: 17.0.sp,
                                              direction: Axis.horizontal,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Цена ${homeProvider.foundedList['data'][index]['cost']}',
                                        style: TextStyle(
                                          fontSize: 11.0.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_rounded,
                            color: AppStyle.colorPurple,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
