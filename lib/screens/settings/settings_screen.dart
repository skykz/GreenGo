import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/settings':
                  return SettingsPageScreen();
                default:
                  return SettingsPageScreen();
                  break;
              }
            });
      },
    );
  }
}

class SettingsPageScreen extends StatefulWidget {
  const SettingsPageScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsPageScreen> {
  String _radioValue1;
  dynamic getAddress;

  @override
  void didChangeDependencies() {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.getAddressList(context).then((value) {
      if (value != null) {
        setState(() {
          getAddress = value;
          for (var i = 0; i < value['data'].length; i++) {
            if (value['data'][i]['isMain'])
              _radioValue1 = getAddress['data'][i]['value'];
          }
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
          builder: (BuildContext context, provider, child) {
        if (getAddress == null)
          return Center(
            child: LoaderWidget(),
          );
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.h),
            child: Column(
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        "Настройки",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(15),
                    //   child: Container(
                    //     padding: const EdgeInsets.all(10),
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(8),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             blurRadius: 7,
                    //             color: Colors.grey[300],
                    //             offset: Offset(0, 7),
                    //           ),
                    //         ]),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           "Общие:",
                    //           style: TextStyle(
                    //             color: Colors.black,
                    //             fontSize: 14.0.sp,
                    //           ),
                    //         ),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             const Text("PUSH-уведомления"),
                    //             CupertinoSwitch(
                    //                 value: this._isTrue,
                    //                 onChanged: (val) {
                    //                   setState(() {
                    //                     this._isTrue = val;
                    //                   });
                    //                 })
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 7,
                                color: Colors.grey[300],
                                offset: Offset(0, 7),
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 15),
                              child: Text(
                                "Ваши адреса:",
                                style: TextStyle(
                                  fontSize: 13.0.sp,
                                ),
                              ),
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: getAddress['data'].length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int i) {
                                  return Row(
                                    children: [
                                      Row(
                                        children: [
                                          Radio(
                                            activeColor: AppStyle.colorGreen,
                                            value: getAddress['data'][i]
                                                ['value'],
                                            groupValue: _radioValue1,
                                            onChanged: (val) =>
                                                _handleRadioValueChange(
                                                    val,
                                                    provider,
                                                    getAddress['data'][i]
                                                        ['value'],
                                                    getAddress['data'][i]['id'],
                                                    getAddress['data'][i]
                                                        ['isMain']),
                                          ),
                                          Text(
                                            '${getAddress['data'][i]['value']}',
                                            style: TextStyle(
                                              fontSize: 10.0.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Builder(
                                            builder: (ctx) => IconButton(
                                                icon: const Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: Colors.redAccent,
                                                ),
                                                onPressed: () {
                                                  final provider =
                                                      Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false);
                                                  provider.deleteAddress(
                                                      getAddress['data'][i]
                                                          ['id'],
                                                      ctx);
                                                }),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  child: OutlineButton(
                    highlightColor: Colors.grey,
                    padding: const EdgeInsets.all(5),
                    borderSide: BorderSide(
                      color: AppStyle.colorGreen,
                    ),
                    child: Center(
                      child: Text(
                        "Добавить новый адрес",
                        style: TextStyle(
                          color: AppStyle.colorGreen,
                          fontSize: 12.0.sp,
                        ),
                      ),
                    ),
                    onPressed: () {
                      displayCustomDialog(
                          context, '', DialogType.AddressType, true, () {
                        Navigator.pop(context);
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  _handleRadioValueChange(dynamic _object, HomeProvider _homeProvider,
      String _value, int _addId, bool _isMain) {
    setState(() {
      _radioValue1 = null;
      _radioValue1 = _object;
    });
    _homeProvider.setNewAddress(
        _addId, _value, _radioValue1 == _object ? true : false, context);
  }
}
