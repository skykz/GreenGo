import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/home/single_product.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'loader_widget.dart';
import 'package:sizer/sizer.dart';

class ListTopProducts extends StatefulWidget {
  final Future future;

  const ListTopProducts({Key key, this.future}) : super(key: key);

  @override
  _ListTopProductsState createState() => _ListTopProductsState();
}

class _ListTopProductsState extends State<ListTopProducts> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getTopProducts(context, _refreshController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29.0.h,
      child: Consumer<HomeProvider>(builder: (context, provider, child) {
        if (provider.getTopProductsList.isEmpty)
          return Center(child: const LoaderWidget());

        // log('${provider.getTopProductsList}');
        inspect(provider.getTopProductsList);
        return SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            scrollDirection: Axis.horizontal,
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                  );
                } else if (mode == LoadStatus.loading) {
                  body = const SizedBox(
                    height: 25,
                    width: 25,
                    child: LoaderWidget(),
                  );
                } else if (mode == LoadStatus.failed) {
                  body = const Text("Ошибка при загрузке");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.grey,
                  );
                } else {
                  body = Column(
                    children: <Widget>[
                      const Icon(
                        Icons.cancel_rounded,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ],
                  );
                }
                return SizedBox(
                  height: 55,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.getTopProductsList.length,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleProductScreen(
                                singleProductData:
                                    provider.getTopProductsList[index],
                              ),
                            ),
                          );
                        },
                        child: Ink(
                          width: 36.0.w,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 7,
                                  offset: Offset(0, 5),
                                  color: Colors.grey[300],
                                )
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                useOldImageOnUrlChange: true,
                                imageUrl: provider.getTopProductsList[index]
                                    ['avatar'],
                                imageBuilder: (context, imageProvider) =>
                                    Center(
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, string) => SizedBox(
                                  width: 70,
                                  height: 70,
                                  child: Center(
                                    child: const LoaderWidget(),
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
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                    child: Text(
                                      provider.getTopProductsList[index]
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
                              ),
                              Text(
                                'Цена: ${provider.getTopProductsList[index]['cost'].toString()}',
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
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite_outline_rounded,
                            color: AppStyle.colorPurple,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                );
              },
            ));
      }),
    );
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    homeProvider.getTopProducts(context, _refreshController);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }
}
