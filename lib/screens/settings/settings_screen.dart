import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/utils/utils.dart';
import 'package:sizer/sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isTrue = true;
  int _radioValue1 = 0;

  @override
  Widget build(BuildContext context) {
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
                        Row(
                          children: [
                            Radio(
                              activeColor: AppStyle.colorGreen,
                              value: 0,
                              groupValue: _radioValue1,
                              onChanged: _handleRadioValueChange1,
                            ),
                            Flexible(
                              flex: 3,
                              child: Text(
                                "Шагабутдинова, д. 105, под. 2, кв. 12  ",
                                style: TextStyle(
                                  fontSize: 10.0.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor: AppStyle.colorGreen,
                              value: 1,
                              groupValue: _radioValue1,
                              onChanged: _handleRadioValueChange1,
                            ),
                            Text(
                              "Шагабутдинова, д. 105, под. 2, кв. 12  ",
                              style: TextStyle(
                                fontSize: 10.0.sp,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
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
                  displayCustomDialog(context, '', DialogType.AddressType, true,
                      () {
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
  }

  _handleRadioValueChange1(Object _object) {
    setState(() {
      _radioValue1 = _object;
    });
  }
}
