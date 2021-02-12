import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/components/widgets/showcase_list_products.dart';
import 'package:green_go/components/widgets/single_product.dart';
import 'package:green_go/components/widgets/top_list_products.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/home/single_product.dart';
import 'package:green_go/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SingleCategoryStoreHomeScreen extends StatefulWidget {
  final bool isStore;
  const SingleCategoryStoreHomeScreen({Key key, this.isStore = false})
      : super(key: key);

  @override
  _SingleHomeScreenState createState() => _SingleHomeScreenState();
}

class _SingleHomeScreenState extends State<SingleCategoryStoreHomeScreen> {
  String currentSelectedValue;
  bool _isSquareType = true;
  Future getTopProducts;
  Future getShowcaseProducts;

  @override
  Widget build(BuildContext context) {
    dynamic dataStore = ModalRoute.of(context).settings.arguments;
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    inspect("ID -> ${dataStore['id']}");
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
        child: Column(
          children: [
            this.widget.isStore
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 30, top: 10),
                    child: SingleStoreWidget(data: dataStore),
                  )
                : const SizedBox(),
            this.widget.isStore
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 15),
                    child: Text(
                      'ТОВАРЫ МАГАЗИНА',
                      style: TextStyle(
                        fontSize: 13.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !this.widget.isStore
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Center(
                          child: Text(
                            'Топ товаров',
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(bottom: 0, top: 20, left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Топ товаров'.toUpperCase(),
                            style: TextStyle(
                              fontSize: 11.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                //TODO: update by pod categories
                ListTopProducts(
                  future: homeProvider.getTopProducts(
                      context,
                      this.widget.isStore ? dataStore['id'] : null,
                      dataStore['id']),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: FormField<String>(builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text(
                        "Сортировка",
                        style: TextStyle(
                          fontSize: 13.0.sp,
                        ),
                      ),
                      value: currentSelectedValue,
                      isExpanded: true,
                      focusColor: AppStyle.colorPurple,
                      icon: SvgPicture.asset('assets/images/svg/menu.svg'),
                      isDense: true,
                      onChanged: (newValue) {
                        setState(() {
                          currentSelectedValue = newValue;
                        });
                        inspect(newValue);
                      },
                      items: sortTypes.entries
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e.value,
                              child: Text(
                                e.key,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              }),
            ),
            // SizedBox(
            //   height: 10.0.h,
            //   child: Consumer<HomeProvider>(builder: (context, provider, _) {
            //     return FutureBuilder(
            //         future: provider.getCatalogsProducts(
            //             context, false, dataStore['id']),
            //         builder: (BuildContext context, AsyncSnapshot snapshot) {
            //           if (snapshot.data == null)
            //             return const Center(
            //               child: LoaderWidget(),
            //             );

            //           return SingleChildScrollView(
            //             scrollDirection: Axis.horizontal,
            //             child: Row(
            //               children: [
            //                 Padding(
            //                   padding: const EdgeInsets.all(8),
            //                   child: Center(
            //                     child: FlatButton(
            //                       color: Colors.white,
            //                       shape: RoundedRectangleBorder(
            //                         side: BorderSide(
            //                           color: Colors.purple,
            //                           width: 1,
            //                         ),
            //                         borderRadius: BorderRadius.circular(20),
            //                       ),
            //                       onPressed: () {},
            //                       child: Text(
            //                         '${dataStore['title']}',
            //                         style: TextStyle(
            //                           fontSize: 10.0.sp,
            //                           color: Colors.black,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 for (var index = 0;
            //                     index < snapshot.data['data'].length;
            //                     index++)
            //                   Padding(
            //                     padding: const EdgeInsets.all(8),
            //                     child: Center(
            //                       child: FlatButton(
            //                         color: provider.getSelectedCategoryIndex ==
            //                                 index
            //                             ? Colors.white
            //                             : AppStyle.colorGreen,
            //                         shape: RoundedRectangleBorder(
            //                           side: provider.getSelectedCategoryIndex ==
            //                                   index
            //                               ? BorderSide(
            //                                   color: Colors.purple,
            //                                   width: 1,
            //                                 )
            //                               : BorderSide(
            //                                   color: AppStyle.colorGreen,
            //                                   width: 1,
            //                                 ),
            //                           borderRadius: BorderRadius.circular(20),
            //                         ),
            //                         onPressed: () {
            //                           log("${snapshot.data['data'][index]['id']}");
            //                           provider.setSelectedCategoryIndex(index);
            //                           provider.setSelectedCategoryId(index);
            //                         },
            //                         child: Text(
            //                           '${snapshot.data['data'][index]['title']}',
            //                           style: TextStyle(
            //                             fontSize: 10.0.sp,
            //                             color:
            //                                 provider.getSelectedCategoryIndex ==
            //                                         index
            //                                     ? Colors.black
            //                                     : Colors.white,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   )
            //               ],
            //             ),
            //           );
            //         });
            //   }),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/svg/grid.svg',
                      color:
                          _isSquareType ? AppStyle.colorPurple : Colors.black,
                      width: 20.0.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSquareType = true;
                      });
                    }),
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/images/svg/list.svg',
                    color: !_isSquareType ? AppStyle.colorPurple : Colors.black,
                    width: 20.0.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _isSquareType = false;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20, left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ВИТРИНА ТОВАРОВ'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Consumer<HomeProvider>(builder: (context, provider, _) {
              return this._isSquareType
                  ? ShowcaseListProducts(
                      future: homeProvider.getWindowProducts(
                          context,
                          currentSelectedValue,
                          this.widget.isStore ? dataStore['id'] : null,
                          provider.getSelectedCategoryId == null
                              ? dataStore['id']
                              : provider.getSelectedCategoryId),
                    )
                  : FutureBuilder(
                      future: homeProvider.getWindowProducts(
                          context,
                          currentSelectedValue,
                          this.widget.isStore ? dataStore['id'] : null,
                          provider.getSelectedCategoryId == null
                              ? dataStore['id']
                              : provider.getSelectedCategoryId),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null)
                          return Center(child: const LoaderWidget());
                        return ListView.builder(
                          itemCount: snapshot.data['data'].length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Stack(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SingleProductScreen(),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data['data']
                                                  [index]['avatar'],
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
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${snapshot.data['data'][index]['title']}',
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
                                                        fontSize: 10.0.sp,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              dataStore['title']
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  12.0.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 3),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Рейтинг:',
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 10.0.sp,
                                                          ),
                                                        ),
                                                        RatingBarIndicator(
                                                          rating: 3.5,
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Icon(
                                                            Icons.star_rounded,
                                                            color: AppStyle
                                                                .colorPurple,
                                                          ),
                                                          itemCount: 5,
                                                          unratedColor:
                                                              Colors.grey[300],
                                                          itemSize: 13.0.sp,
                                                          direction:
                                                              Axis.horizontal,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      'Цена ${snapshot.data['data'][index]['cost']}',
                                                      style: TextStyle(
                                                        fontSize: 11.0.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
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
                        );
                      });
            }),
            SizedBox(
              height: 5.0.h,
            )
          ],
        ),
      ),
    );
  }
}
