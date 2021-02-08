import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/list_custom_item.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AppDrawerScreen extends StatelessWidget {
  const AppDrawerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return SizedBox(
      width: w * 0.7,
      child: Drawer(
        elevation: 5,
        child: Column(
          children: [
            SizedBox(
              height: 7.0.h,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppStyle.colorGreen,
                    size: 27.0.sp,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _selectItem(5, context);
                Navigator.pop(context);
              },
              child: Ink(
                width: double.infinity,
                height: 19.0.h,
                decoration: BoxDecoration(color: Colors.grey[300]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.account_circle_outlined,
                          size: 7.0.h, color: AppStyle.colorGreen),
                      Text('Username Data'),
                      Text("+7 778 777 77 77"),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListCustomItem(
                    path: 'assets/images/svg/shop.svg',
                    title: 'Магазины',
                    onTapped: () {
                      _selectItem(16, context);
                      Navigator.pop(context);
                    },
                  ),
                  ListCustomItem(
                    path: 'assets/images/svg/catalog.svg',
                    title: 'Каталог',
                    onTapped: () {
                      _selectItem(1, context);
                      Navigator.pop(context);
                    },
                  ),
                  ListCustomItem(
                    path: 'assets/images/svg/flower.svg',
                    title: 'Ваши товары',
                    onTapped: () {
                      _selectItem(9, context);
                      Navigator.pop(context);
                    },
                    notificationCount: 4,
                  ),
                  ListCustomItem(
                    path: 'assets/images/svg/basket.svg',
                    title: 'Корзина',
                    onTapped: () {
                      _selectItem(4, context);
                      Navigator.pop(context);
                    },
                  ),
                  ListCustomItem(
                    path: 'assets/images/svg/order.svg',
                    title: 'Заказы',
                    onTapped: () {
                      _selectItem(17, context);
                      Navigator.pop(context);
                    },
                  ),
                  ListCustomItem(
                    path: 'assets/images/svg/settings.svg',
                    title: 'Настройки',
                    onTapped: () {
                      _selectItem(13, context);
                      Navigator.pop(context);
                    },
                  ),
                  ListCustomItem(
                    path: 'assets/images/svg/partner.svg',
                    title: 'Партнерам',
                    onTapped: () {
                      _selectItem(15, context);
                      Navigator.pop(context);
                    },
                  ),
                  ListCustomItem(
                    path: 'assets/images/svg/support.svg',
                    title: 'Помощь',
                    onTapped: () {
                      _selectItem(14, context);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: RichText(
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
            ),
          ],
        ),
      ),
    );
  }

  void _selectItem(int val, BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.setSelectedIndex(val);
  }
}
