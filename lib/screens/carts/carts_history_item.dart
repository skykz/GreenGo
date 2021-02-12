import 'package:flutter/material.dart';
import 'package:green_go/screens/products/products_list_screen.dart';
import 'package:sizer/sizer.dart';

class CartsHistoryItemScreen extends StatelessWidget {
  const CartsHistoryItemScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.white,
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
              ProductListScreen(),
              ProductListScreen(
                isArchive: true,
              ),
              // Text('dfsdf'),
            ]),
          ),
        ],
      ),
    );
  }
}
