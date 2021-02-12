import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isTrue = true;
  String _radioValue1;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (BuildContext context, provider, child) {
      return Container(
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
                  Padding(
                    padding: const EdgeInsets.all(15),
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
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Общие:",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("PUSH-уведомления"),
                              CupertinoSwitch(
                                  value: this._isTrue,
                                  onChanged: (val) {
                                    setState(() {
                                      this._isTrue = val;
                                    });
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "Ваши адреса:",
                              style: TextStyle(
                                fontSize: 13.0.sp,
                              ),
                            ),
                          ),
                          FutureBuilder(
                              future: provider.getAddressList(context),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data == null)
                                  return Center(child: const LoaderWidget());
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data['data'].length,
                                    itemBuilder: (BuildContext context, int i) {
                                      // _radioValue1 =
                                      //     snapshot.data['data'][i]['isMain'];

                                      return Row(
                                        children: [
                                          Row(
                                            children: [
                                              Radio(
                                                activeColor:
                                                    AppStyle.colorGreen,
                                                value: snapshot.data['data'][i]
                                                    ['value'],
                                                groupValue: _radioValue1,
                                                onChanged: (val) =>
                                                    _handleRadioValueChange(
                                                        val,
                                                        provider,
                                                        snapshot.data['data'][i]
                                                            ['value'],
                                                        snapshot.data['data'][i]
                                                            ['id'],
                                                        snapshot.data['data'][i]
                                                            ['isMain']),
                                              ),
                                              Text(
                                                '${snapshot.data['data'][i]['value']}',
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
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.delete_outline_rounded,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
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
    });
  }

  _handleRadioValueChange(dynamic _object, HomeProvider _homeProvider,
      String _value, int _addId, bool _isMain) {
    log(_object);
    setState(() {
      _radioValue1 = _object;
    });
    _homeProvider.setNewAddress(_addId, _value, _isMain, context);
  }
}
