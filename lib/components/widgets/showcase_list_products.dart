import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/home/single_product.dart';
import 'package:provider/provider.dart';

import 'loader_widget.dart';

class ShowcaseListProducts extends StatefulWidget {
  final Future future;
  final ScrollController scrollController;
  ShowcaseListProducts({
    Key key,
    this.future,
    this.scrollController,
  }) : super(key: key);

  @override
  _ShowcaseListProductsState createState() => _ShowcaseListProductsState();
}

class _ShowcaseListProductsState extends State<ShowcaseListProducts> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.future == null)
      return FutureBuilder(
          future: widget.future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return Center(child: const LoaderWidget());
            return GridView.builder(
              itemCount: snapshot.data['data'].length,
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2),
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SingleProductScreen(
                                singleProductData: snapshot.data['data'][index],
                              ),
                            ),
                          );
                        },
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CachedNetworkImage(
                                imageUrl: snapshot.data['data'][index]
                                    ['avatar'],
                                imageBuilder: (context, imageProvider) =>
                                    Center(
                                  child: Container(
                                    width: 88,
                                    height: 88,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                placeholder: (context, string) => const Center(
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
                              Flexible(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    snapshot.data['data'][index]['title']
                                        .toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      top: 3,
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
            );
          });

    return Consumer<HomeProvider>(builder: (context, provider, child) {
      if (provider.getWindowProductsList.isEmpty)
        return Center(child: const LoaderWidget());
      return GridView.builder(
        itemCount: provider.getWindowProductsList.length,
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(3),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleProductScreen(
                          singleProductData:
                              provider.getWindowProductsList[index],
                        ),
                      ),
                    );
                  },
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CachedNetworkImage(
                          imageUrl: provider.getWindowProductsList[index]
                              ['avatar'],
                          imageBuilder: (context, imageProvider) => Center(
                            child: Container(
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, string) => const Center(
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
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              provider.getWindowProductsList[index]['title']
                                  .toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 3,
                top: 3,
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
      );
    });
  }

  @override
  void dispose() {
    // _refreshController?.dispose();
    super.dispose();
  }
}
