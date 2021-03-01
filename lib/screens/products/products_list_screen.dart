import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/orders/single_order.dart';
import 'package:green_go/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductListScreen extends StatelessWidget {
  final dynamic snapshot;
  final bool isArchive;
  final bool isMyProduct;

  ProductListScreen(
      {Key key,
      this.snapshot,
      this.isMyProduct = false,
      this.isArchive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Consumer<HomeProvider>(
        builder: (BuildContext context, provider, child) {
      return FutureBuilder(
          future: this.isMyProduct
              ? provider.getMySells(context)
              : provider.getOrderHistory(isArchive, context),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return Center(
                child: const LoaderWidget(),
              );
            if (snapshot.data['data'].length == 0)
              return const Center(
                child: Text('Нет товаров'),
              );
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data['data'].length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingleOrderScreen(),
                          ),
                        );
                      },
                      child: Ink(
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
                                height: 28.0.h,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Заказ ${snapshot.data['data'][index]['id']}',
                                              style: TextStyle(
                                                fontSize: 14.0.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '25.12.2020  12:00',
                                              style: TextStyle(
                                                fontSize: 10.0.sp,
                                              ),
                                            ),
                                            Text(
                                              'Магазин:\n${snapshot.data['data'][index]['seller']['title']}',
                                              style: TextStyle(
                                                fontSize: 12.0.sp,
                                              ),
                                            ),
                                            Text(
                                              'Доставка: ${snapshot.data['data'][index]['time']}',
                                              style: TextStyle(
                                                fontSize: 12.0.sp,
                                              ),
                                            ),
                                            Text(
                                              'Сумма: ${snapshot.data['data'][index]['sum']} тг.',
                                              style: TextStyle(
                                                fontSize: 12.0.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: "Статус: \n",
                                                style: TextStyle(
                                                  color: AppStyle.colorGreen,
                                                  fontSize: 11.0.sp,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: getStatus(
                                                        snapshot.data['data']
                                                            [index]['status']),
                                                    style: TextStyle(
                                                      color:
                                                          AppStyle.colorGreen,
                                                      fontSize: 12.0.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 5,
                                      child: Center(
                                        child: snapshot
                                                    .data['data'][index]
                                                        ['products']
                                                    .length ==
                                                1
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                          .data['data'][index]
                                                      ['products'][0]['avatar'],
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Center(
                                                    child: Container(
                                                      height: 100,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder:
                                                      (context, string) =>
                                                          const Center(
                                                    child: LoaderWidget(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Container(
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons
                                                            .error_outline_rounded,
                                                        color: Colors.red,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : GridView.builder(
                                                itemCount: snapshot
                                                    .data['data'][index]
                                                        ['products']
                                                    .length,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  childAspectRatio:
                                                      w / (h / 1.85),
                                                ),
                                                itemBuilder: (context, j) {
                                                  if (snapshot
                                                          .data['data'][index]
                                                              ['products']
                                                          .length >
                                                      3)
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 2,
                                                          vertical: 2),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .more_horiz_rounded,
                                                          size: 35.0.sp,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    );
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          snapshot.data['data']
                                                                      [index]
                                                                  ['products']
                                                              [j]['avatar'],
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Center(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, string) =>
                                                              const Center(
                                                        child: LoaderWidget(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons
                                                                .error_outline_rounded,
                                                            color: Colors.red,
                                                            size: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          });
    });
  }
}
