import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'loader_widget.dart';

class ProductsStatusList extends StatelessWidget {
  final bool isArchive;
  final bool isMyProduct;

  final dynamic listData;

  const ProductsStatusList(
      {Key key,
      this.isArchive = false,
      this.isMyProduct = false,
      this.listData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return FutureBuilder(
        future: isArchive
            ? homeProvider.getMyProductsUserNotActive(context)
            : homeProvider.getMyProductsUserActive(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null)
            return const Center(
              child: LoaderWidget(),
            );
          return ListView.builder(
            itemCount: snapshot.data['data'].length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[300],
                          blurRadius: 7,
                          offset: Offset(0, 6),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          height: 27.0.h,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 3,
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data['data'][index]
                                      ['avatar'],
                                  imageBuilder: (context, imageProvider) =>
                                      Center(
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
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
                              ),
                              Flexible(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Дата создания: 30.12.2020  17:00',
                                      style: TextStyle(
                                        fontSize: 8.0.sp,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        '${snapshot.data['data'][index]['title']}'
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 13.0.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        '${snapshot.data['data'][index]['description']}',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11.0.sp,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: RichText(
                                        text: TextSpan(
                                          text: "Способ отправки:\n",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 9.0.sp,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "${snapshot.data['data'][index]['canPickup'] == true ? 'Самовывоз' : ''}, ${snapshot.data['data'][index]['canDeliver'] == true ? 'Доставка' : ''}",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10.0.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Цена: ${snapshot.data['data'][index]['cost']}',
                                      style: TextStyle(
                                        fontSize: 12.0.sp,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Статус: ",
                                        style: TextStyle(
                                          color: AppStyle.colorGreen,
                                          fontSize: 10.0.sp,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: getStatus(snapshot
                                                .data['data'][index]['status']),
                                            style: TextStyle(
                                              color: AppStyle.colorGreen,
                                              fontSize: 11.0.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 20),
                        child: OutlineButton(
                          color: AppStyle.colorPurple,
                          onPressed: () {
                            homeProvider.cancelMyOrderItem(
                                snapshot.data['data'][index]['id'], context);
                          },
                          borderSide: BorderSide(
                            color: Colors.purple,
                          ),
                          highlightedBorderColor: Colors.purple,
                          splashColor: Colors.purple[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                'Отменить товар'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10.0.sp,
                                  color: AppStyle.colorPurple,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
