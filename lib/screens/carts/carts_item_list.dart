import 'package:flutter/material.dart';
import 'package:green_go/screens/products/products_new_screen.dart';
import 'package:sizer/sizer.dart';

class CartsItemScreen extends StatelessWidget {
  const CartsItemScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: TabBar(
                unselectedLabelColor: Colors.black87,
                labelColor: Colors.green,
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "В обработке",
                        style: TextStyle(
                          fontSize: 12.0.sp,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "В архиве",
                        style: TextStyle(
                          fontSize: 12.0.sp,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: TabBarView(children: [
              ProductNewScreen(),
              ProductNewScreen(),
            ]),
          ),
        ],
      ),
    );
  }
}
