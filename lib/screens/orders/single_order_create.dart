import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:green_go/utils/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SingleOrderCreateScreen extends StatefulWidget {
  final dynamic storeProducts;
  const SingleOrderCreateScreen({Key key, this.storeProducts})
      : super(key: key);

  @override
  _SingleOrderCreateScreenState createState() =>
      _SingleOrderCreateScreenState();
}

class _SingleOrderCreateScreenState extends State<SingleOrderCreateScreen> {
  String currentSelectedShipping;
  String currentSelectedValuePayment;
  Future _getAddress;
  String _addressLocal;

  final _timeMaskController =
      MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  final _phoneValueController = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    _getAddress = homeProvider.getAddressList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    inspect(this.widget.storeProducts);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 35),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              size: 20.0.sp,
              color: Colors.purple[400],
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Заказ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '${(this.widget.storeProducts['seller']['createdAt']).toString().substring(0, 10)}',
                        style: TextStyle(
                          fontSize: 11.0.sp,
                          color: Colors.black87,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    this.widget.storeProducts['sellerType'] ==
                                            'store'
                                        ? "Магазин: "
                                        : "Цветы с рук: ",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 11.0.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                children: [
                                  Text(
                                    this.widget.storeProducts['sellerType'] ==
                                            'store'
                                        ? "${this.widget.storeProducts['seller']['title']} "
                                        : "${this.widget.storeProducts['seller']['fullName']}",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Телефон продавца: ",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 11.0.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Row(
                                children: [
                                  Text(
                                    "${this.widget.storeProducts['seller']['phone']}",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: this.widget.storeProducts['items'].length,
                    itemBuilder: (BuildContext context, int j) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  blurRadius: 7,
                                  offset: Offset(0, 7),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${this.widget.storeProducts['items'][j]['product']['title']}\n'
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${this.widget.storeProducts['items'][j]['product']['description']}',
                                        maxLines: 10,
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Количество: ",
                                            style: TextStyle(
                                              fontSize: 10.0.sp,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "${this.widget.storeProducts['items'][j]['count']} шт",
                                                style: TextStyle(
                                                  fontSize: 12.0.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Сумма:\n",
                                            style: TextStyle(
                                              fontSize: 10.0.sp,
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    "${this.widget.storeProducts['items'][j]['product']['cost']} тг.",
                                                style: TextStyle(
                                                  fontSize: 12.0.sp,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: CachedNetworkImage(
                                    placeholderFadeInDuration:
                                        Duration(milliseconds: 200),
                                    imageUrl: this.widget.storeProducts['items']
                                        [j]['product']['avatar'],
                                    imageBuilder: (context, imageProvider) =>
                                        Center(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, string) => Center(
                                      child: LoaderWidget(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      child: const Center(
                                        child: Icon(
                                          Icons.error_outline_rounded,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text(
                                  "Способ получения",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                value: currentSelectedShipping,
                                isExpanded: true,
                                focusColor: AppStyle.colorPurple,
                                icon: SvgPicture.asset(
                                    'assets/images/svg/menu.svg'),
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedShipping = newValue;
                                  });
                                  print(currentSelectedShipping);
                                },
                                items: typeOfShipping.entries
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        value: e.value,
                                        child: Text(
                                          e.key,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        }),
                      ),
                      currentSelectedShipping != null
                          ? currentSelectedShipping != 'pickup'
                              ? FutureBuilder(
                                  future: _getAddress,
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.data == null)
                                      return Center(
                                          child: const LoaderWidget());

                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                blurRadius: 7,
                                                offset: Offset(0, 4),
                                              )
                                            ]),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, bottom: 10),
                                              child: Text(
                                                'Ваши адреса',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            for (int i = 0;
                                                i <
                                                    snapshot
                                                        .data['data'].length;
                                                i++)
                                              Row(
                                                children: [
                                                  Radio(
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      value:
                                                          snapshot.data['data']
                                                              [i]['value'],
                                                      groupValue: _addressLocal,
                                                      activeColor:
                                                          AppStyle.colorGreen,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          _addressLocal =
                                                              snapshot.data[
                                                                      'data'][i]
                                                                  ['value'];
                                                        });
                                                      }),
                                                  Text(
                                                      '${snapshot.data['data'][i]['value']}'),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Откуда забрать',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        "${this.widget.storeProducts['seller']['address']}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                          : const SizedBox(),
                      currentSelectedShipping != null
                          ? currentSelectedShipping != 'pickup'
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: TextField(
                                    cursorColor: Colors.purple,
                                    cursorRadius: Radius.circular(10.0),
                                    textAlign: TextAlign.start,
                                    cursorWidth: 2,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [_timeMaskController],
                                    decoration: InputDecoration(
                                      labelText: 'Время доставки',
                                      labelStyle: TextStyle(
                                        fontSize: 15.0.sp,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 0),
                                      hintStyle: TextStyle(
                                        fontSize: 12.0.sp,
                                        color: Colors.grey[400],
                                      ),
                                      hintText: '_ _ : _ _',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        gapPadding: 4,
                                        borderSide: BorderSide(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: Colors.purple),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 13.0.sp,
                                    ),
                                  ),
                                )
                              : const SizedBox()
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text(
                                  "Способ оплаты",
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                value: currentSelectedValuePayment,
                                isExpanded: false,
                                focusColor: AppStyle.colorPurple,
                                icon: SvgPicture.asset(
                                    'assets/images/svg/menu.svg'),
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedValuePayment = newValue;
                                  });
                                },
                                items: paymentType.entries
                                    .map(
                                      (e) => DropdownMenuItem<String>(
                                        value: e.value,
                                        child: Text(
                                          e.key,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: TextField(
                          cursorColor: Colors.purple,
                          cursorRadius: Radius.circular(10.0),
                          textAlign: TextAlign.start,
                          cursorWidth: 2,
                          keyboardType: TextInputType.number,
                          inputFormatters: [_phoneValueController],
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            hintStyle: TextStyle(
                              fontSize: 12.0.sp,
                              color: Colors.grey[400],
                            ),
                            hintText: '+7 (777) 777 77 77',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              gapPadding: 4,
                              borderSide: BorderSide(
                                color: Colors.black38,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.purple),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 13.0.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300],
                              blurRadius: 7,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              '${this.widget.storeProducts['sum']} тг.',
                              style: TextStyle(
                                fontSize: 15.0.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Общая сумма',
                          style: TextStyle(
                            fontSize: 11.0.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0.h),
                        child: FlatButton(
                          color: AppStyle.colorGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            final homeProvider = Provider.of<HomeProvider>(
                                context,
                                listen: false);
                            homeProvider.createOrderFromCart(
                              _phoneValueController.getUnmaskedText(),
                              currentSelectedShipping == 'pickup'
                                  ? ''
                                  : _timeMaskController.getMaskedText(),
                              this.widget.storeProducts['seller']['id'],
                              this.widget.storeProducts['sellerType'],
                              currentSelectedShipping == 'pickup'
                                  ? this
                                      .widget
                                      .storeProducts['seller']['address']
                                      .toString()
                                  : _addressLocal,
                              currentSelectedShipping,
                              currentSelectedValuePayment,
                              context,
                            );
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                'Заказать',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
