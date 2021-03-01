import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/list_custom_item.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AppDrawerScreen extends StatelessWidget {
  const AppDrawerScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return SizedBox(
      width: w * 0.7,
      child: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null)
              return const Center(
                child: LoaderWidget(),
              );
            String _avatarImage = snapshot.data.getString('avatar') ?? "";
            String _username = snapshot.data.getString('username') ?? null;
            String _phone = snapshot.data.getString('phone') ?? null;
            return Drawer(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: _phone == null
                              ? Center(child: Text('Авторизуйтесь'))
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _avatarImage.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: _avatarImage,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Center(
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, string) =>
                                                const Center(
                                              child: LoaderWidget(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              child: const Center(
                                                child: Icon(
                                                  Icons.error_outline_rounded,
                                                  color: Colors.red,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Icon(Icons.account_circle_outlined,
                                            size: 8.0.h,
                                            color: AppStyle.colorGreen),
                                    Text(_username.toString()),
                                    Text(_phone.toString()),
                                  ],
                                )),
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
                          getNotification: _phone != null
                              ? homeProvider.getMySellersCount(context)
                              : null,
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
            );
          }),
    );
  }

  void _selectItem(int val, BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (val == 9 || val == 4 || val == 17 || val == 13 || val == 5) {
      homeProvider.getAccessToken().then((value) {
        if (value == null)
          displayCustomDialog(
              context, '_title', DialogType.AuthType, true, () {});
        else
          homeProvider.setSelectedIndex(val);
      });
    } else {
      homeProvider.setSelectedIndex(val);
    }

    FocusScope.of(context).unfocus();
  }
}
