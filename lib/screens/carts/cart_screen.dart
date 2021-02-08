import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/carts/carts_item_list.dart';
import 'package:green_go/screens/orders/single_order.dart';
import 'package:green_go/screens/orders/single_order_create.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/singleOrder':
                  return SingleOrderScreen();
                default:
                  return CardMainScreen();
                  break;
              }
            });
      },
    );
  }
}

class CardMainScreen extends StatelessWidget {
  const CardMainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvder = Provider.of<HomeProvider>(context);
    return DefaultTabController(
      initialIndex: homeProvder.getSelectedIndex == 17 ? 1 : 0,
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: TabBar(
                unselectedLabelColor: Color(0xff9E1AEF),
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xff9E1AEF),
                ),
                tabs: [
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Color(0xff9E1AEF), width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: FittedBox(child: Text("КОРЗИНА")),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Color(0xff9E1AEF),
                          width: 1,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          child: FittedBox(child: Text('ИСТОРИЯ ЗАКАЗОВ')),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                _cartListWidget(context),
                CartsHistoryItemScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _cartListWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 35, bottom: 40),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0, 5),
                  blurRadius: 10,
                ),
              ]),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Магазин: ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0.sp,
                        )),
                    Text(
                      'Rosalie',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 11.0.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          color: Colors.grey[300],
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'монобукет'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      'Артикул: 000001',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.0.sp,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'sdfsdfsfsdfsdfsdfsfsdfsdfsdfsdf',
                                    maxLines: 5,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Количество',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.0.sp,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7,
                                                      horizontal: 11),
                                              child: Center(
                                                child: Text(
                                                  '2',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 13.0.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                                imageBuilder: (context, imageProvider) =>
                                    Center(
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
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
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 3,
                        height: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '26 000 тг.',
                              style: TextStyle(
                                  fontSize: 14.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.grey[200],
                              highlightColor: Colors.red,
                              splashColor: Colors.red[300],
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                child: Text(
                                  'удалить',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.0.sp,
                                      color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.grey[300],
                          offset: Offset(0, 5),
                        )
                      ]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        '40 000 тг.',
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Общая сумма',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.0.sp,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(
                  color: AppStyle.colorGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleOrderCreateScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'ОФОРМИТЬ ЗАКАЗ',
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
