import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/screens/drawer/app_drawer.dart';
import 'package:green_go/screens/orders/single_order.dart';
import 'package:green_go/screens/partners/info_partners_screen.dart';
import 'package:green_go/screens/products/products_main_screen.dart';
import 'package:green_go/screens/profile/profile_screen.dart';
import 'package:green_go/screens/search/search_screen.dart';
import 'package:green_go/screens/settings/settings_screen.dart';
import 'package:green_go/screens/support/support_screen.dart';
import 'package:green_go/services/push_services.dart';
import 'package:green_go/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'carts/cart_screen.dart';
import 'category/category_screen.dart';
import 'category/store_category_screen.dart';
import 'create/create_product.dart';
import 'favorite/favorite_lists_screen.dart';
import 'home/home_screen.dart';
import 'home/single_home.dart';
import 'home/single_product.dart';

class IndexScreen extends StatefulWidget {
  IndexScreen({Key key}) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List<Widget> _childrenScreen = [
    //main default screen
    HomeScreen(),
    //category screen
    CategoryScreen(),
    HomeScreen(),
    FavoriteListScreen(),
    CartScreen(),

    // for other screens
    ProfileScreen(),
    CreateProductScreen(),
    SearchScreen(),

    SingleOrderScreen(),
    ProductsScreen(),
    SingleProductScreen(),
    SingleCategiryStoreHomeScreen(),
    FavoriteListScreen(),

    SettingsScreen(), //13
    SupportScreen(),
    InfoPartnersScreen(),
    StoreCategory(),
    //when from drawer side
    CartScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((val) {
      final homeProvder = Provider.of<HomeProvider>(context, listen: false);
      homeProvder.getAccessToken().then((value) {
        if (value == null)
          displayCustomDialog(
              context, '_title', DialogType.AuthType, true, () {});
      });

      NotificationHandlerService().initializeFcmNotification();
    });
    super.initState();
  }

  @override
  void dispose() {
    NotificationHandlerService().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvder = Provider.of<HomeProvider>(context);
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    log("selected index of screen --> ${homeProvder.getSelectedIndex}");
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 18.0.h),
          child: AppBar(
            elevation: 10,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: AppStyle.colorGreen,
                ),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                }),
            centerTitle: true,
            title: RichText(
              text: TextSpan(
                text: "GREEN",
                style: TextStyle(
                  color: AppStyle.colorGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0.sp,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "GO",
                    style: TextStyle(
                      color: AppStyle.colorPurple,
                      fontSize: 17.0.sp,
                    ),
                  ),
                ],
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Center(
                child: Container(
                  color: Colors.grey,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 7,
                          color: Colors.grey[200],
                          spreadRadius: 0,
                          offset: Offset(0, 5),
                        )
                      ]),
                  child: TextField(
                    cursorColor: Colors.purple,
                    cursorRadius: Radius.circular(10.0),
                    cursorWidth: 2,
                    // controller: _te/xtSearcTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                      hintText: 'Попробуйте \'Розы\'',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        gapPadding: 4,
                        borderSide: BorderSide(
                          color: Colors.grey[200],
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search,
                              color: Colors.purple, size: 25),
                          onPressed: () {
                            final homeProvider = Provider.of<HomeProvider>(
                                context,
                                listen: false);
                            homeProvider.setSelectedIndex(7);
                          }),
                    ),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: _childrenScreen[homeProvder.getSelectedIndex],
        drawer: AppDrawerScreen(),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: showFab
            ? FloatingActionButton(
                elevation: 3,
                backgroundColor: AppStyle.colorPurple,
                onPressed: () {
                  homeProvder.setSelectedIndex(6);
                },
                child: Center(
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: homeProvder.getSelectedIndex <= 4
              ? homeProvder.getSelectedIndex
              : 0,
          selectedItemColor: AppStyle.colorPurple,
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            color: AppStyle.colorPurple,
          ),
          onTap: (final int ind) {
            homeProvder.setSelectedIndex(ind);
          },
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 6.0.h,
                width: 6.0.w,
                child: SvgPicture.asset(
                  'assets/images/svg/home.svg',
                  color: homeProvder.getSelectedIndex <= 4
                      ? homeProvder.getSelectedIndex == 0
                          ? AppStyle.colorPurple
                          : null
                      : AppStyle.colorPurple,
                ),
              ),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 6.0.h,
                width: 6.0.w,
                child: SvgPicture.asset(
                  'assets/images/svg/shop.svg',
                  color: homeProvder.getSelectedIndex == 1
                      ? AppStyle.colorPurple
                      : null,
                ),
              ),
              label: 'Категории',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.hourglass_empty,
                color: Colors.transparent,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 6.0.h,
                width: 6.0.w,
                child: SvgPicture.asset(
                  'assets/images/svg/favorite.svg',
                  color: homeProvder.getSelectedIndex == 3
                      ? AppStyle.colorPurple
                      : null,
                ),
              ),
              label: 'Избранное',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: 6.0.h,
                width: 6.0.w,
                child: SvgPicture.asset(
                  'assets/images/svg/card.svg',
                  color: homeProvder.getSelectedIndex == 4
                      ? AppStyle.colorPurple
                      : null,
                ),
              ),
              label: 'Корзина',
            ),
          ],
        ),
      ),
    );
  }
}
