import 'package:flutter/material.dart';
import 'package:green_go/components/widgets/products_item_widget.dart';
import 'package:sizer/sizer.dart';

class ProductsStatusScreen extends StatelessWidget {
  final bool isMyProduct;
  const ProductsStatusScreen({Key key, this.isMyProduct = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
              unselectedLabelColor: Colors.black87,
              labelColor: Colors.green,
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Активные",
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
                      "Архив",
                      style: TextStyle(
                        fontSize: 12.0.sp,
                      ),
                    ),
                  ),
                ),
              ]),
          Expanded(
            child: TabBarView(children: [
              ProductsStatusList(
                isMyProduct: true,
              ),
              ProductsStatusList(
                isMyProduct: true,
                isArchive: true,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
