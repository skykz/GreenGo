import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/components/widgets/showcase_list_products.dart';
import 'package:green_go/components/widgets/top_list_products.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/home/single_store_home.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/singleCatalogHome':
                  return SingleCategiryStoreHomeScreen();
                default:
                  return HomeWidget();
                  break;
              }
            });
      },
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Future getTopProducts;
  Future getWindowProducts;
  Future getCatalogProducts;
  Future getBanners;

  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    getTopProducts = homeProvider.getTopProducts(context);
    getWindowProducts = homeProvider.getWindowProducts(context);
    getCatalogProducts = homeProvider.getCatalogsProducts(context, true);
    getBanners = homeProvider.getBannerList(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: FutureBuilder(
                future: getBanners,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null)
                    return Center(
                      child: const LoaderWidget(),
                    );
                  return CarouselSlider(
                    items: [
                      for (var i = 0; i < snapshot.data['data'].length; i++)
                        CachedNetworkImage(
                          imageUrl:
                              snapshot.data['data'][i]['image'].toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Center(
                              child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          )),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error_outline_rounded,
                            size: 50,
                          ),
                        )
                    ],
                    options: CarouselOptions(
                      height: h * 0.16,
                      viewportFraction: 0.7,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                }),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'КАТАЛОГ ТОВАРОВ',
                  style: TextStyle(
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0.h,
                child: FutureBuilder(
                    future: getCatalogProducts,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null)
                        return Center(child: const LoaderWidget());
                      return GridView.builder(
                        itemCount: snapshot.data['data'].length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: w / (h / 2.5),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(1),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SingleCategiryStoreHomeScreen(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Ink(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        offset: Offset(0, 5),
                                        spreadRadius: 1,
                                        color: Colors.grey[300],
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: snapshot.data['data'][index]
                                          ['avatar'],
                                      imageBuilder: (context, imageProvider) =>
                                          Center(
                                        child: Container(
                                          width: 65,
                                          height: 65,
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
                                    Flexible(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        "${snapshot.data['data'][index]['title']}",
                                        style: TextStyle(),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 15),
                child: Text(
                  'ТОП ТОВАРОВ',
                  style: TextStyle(
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTopProducts(
                future: getTopProducts,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                child: Text(
                  'ВИТРИНА ТОВАРОВ',
                  style: TextStyle(
                    fontSize: 13.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ShowcaseListProducts(
                future: getWindowProducts,
              ),
              SizedBox(
                height: 5.0.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}
