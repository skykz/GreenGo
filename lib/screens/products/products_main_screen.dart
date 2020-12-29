import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/screens/products/products_new_screen.dart';
import 'package:green_go/screens/products/products_status_screen.dart';
import 'package:sizer/sizer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("${_tabController.index}.");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
            controller: _tabController,
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
                    child: Text("ВАШИ ТОВАРЫ"),
                  ),
                ),
              ),
              Stack(
                children: [
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
                        child: Text("НОВАЯ ПРОДАЖА"),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: AppStyle.colorPurple,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          )),
                      child: Center(
                        child: Text(
                          '+4',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.0.sp,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductsStatusScreen(),
          ProductNewScreen(),
        ],
      ),
    );
  }
}
