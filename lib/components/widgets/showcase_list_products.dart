import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/screens/home/single_product.dart';

import 'loader_widget.dart';

class ShowcaseListProducts extends StatelessWidget {
  final Future future;
  const ShowcaseListProducts({Key key, this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) return Center(child: const LoaderWidget());
          return GridView.builder(
            itemCount: snapshot.data['data'].length,
            shrinkWrap: true,
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
                              imageUrl: snapshot.data['data'][index]['avatar'],
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
  }
}
