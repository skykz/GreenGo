import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/screens/home/single_product.dart';

import 'loader_widget.dart';
import 'package:sizer/sizer.dart';

class ListTopProducts extends StatelessWidget {
  final Future future;
  const ListTopProducts({Key key, this.future}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 29.0.h,
      child: FutureBuilder(
          future: this.future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return Center(child: const LoaderWidget());

            inspect(snapshot.data);
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data['data'].length,
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
                                singleProductData: snapshot.data['data'][index],
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
                                imageUrl: snapshot.data['data'][index]
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
                                      snapshot.data['data'][index]['title']
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
                                'Цена: ${snapshot.data['data'][index]['cost'].toString()}',
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
            );
          }),
    );
  }
}
