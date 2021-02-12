import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/products/products_list_screen.dart';
import 'package:green_go/screens/products/products_status_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Future getMyProductsSellerCount;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    getMyProductsSellerCount = homeProvider.getMySellersCount(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FutureBuilder(
          future: getMyProductsSellerCount,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return const Center(
                child: LoaderWidget(),
              );
            return Scaffold(
              resizeToAvoidBottomPadding: false,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TabBar(
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
                                border: Border.all(
                                    color: Color(0xff9E1AEF), width: 1),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: const Text("ВАШИ ТОВАРЫ"),
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
                                    child: const Text("НОВАЯ ПРОДАЖА"),
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
                                      snapshot.data['data']['count'].toString(),
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
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        ProductsStatusScreen(
                          isMyProduct: true,
                        ),
                        ProductListScreen(
                          isMyProduct: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
