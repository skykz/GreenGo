import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/utils/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sizer/sizer.dart';

class SingleOrderCreateScreen extends StatefulWidget {
  const SingleOrderCreateScreen({Key key}) : super(key: key);

  @override
  _SingleOrderCreateScreenState createState() =>
      _SingleOrderCreateScreenState();
}

class _SingleOrderCreateScreenState extends State<SingleOrderCreateScreen> {
  String currentSelectedValue;
  String currentSelectedValuePayment;

  List<String> _paymentType = [
    'Наличными',
    'Картой',
  ];
  final _timeMaskController =
      MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')});

  final _phoneValueController = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Заказ №0001',
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
                      '20.02.2020',
                      style: TextStyle(
                        fontSize: 11.0.sp,
                        color: Colors.black87,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Магазин: ",
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
                                  "Rosalie ",
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
                    Row(
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
                                "+7 777 777 77 77",
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
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Монобукет\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Пышные гортензии, королевские розы'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Количество: ",
                                    style: TextStyle(
                                      fontSize: 10.0.sp,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "2 шт",
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Сумма:\n",
                                    style: TextStyle(
                                      fontSize: 10.0.sp,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "26 000 тг.",
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
                            imageUrl:
                                'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                            imageBuilder: (context, imageProvider) => Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
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
                            errorWidget: (context, url, error) => Container(
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Монобукет\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Пышные гортензии, королевские розы'),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Количество: ",
                                    style: TextStyle(
                                      fontSize: 10.0.sp,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "2 шт",
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Сумма:\n",
                                    style: TextStyle(
                                      fontSize: 10.0.sp,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "26 000 тг.",
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
                            imageUrl:
                                'https://www.thoughtco.com/thmb/19F0cna2JSUcDnkuv7oUiSYALBQ=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/lotus-flower-828457262-5c6334b646e0fb0001dcd75a.jpg',
                            imageBuilder: (context, imageProvider) => Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
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
                            errorWidget: (context, url, error) => Container(
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
              ),
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text("Способ получения"),
                              value: currentSelectedValue,
                              isExpanded: true,
                              focusColor: AppStyle.colorPurple,
                              icon: SvgPicture.asset(
                                  'assets/images/svg/menu.svg'),
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  currentSelectedValue = newValue;
                                });
                                print(currentSelectedValue);
                              },
                              items: sortTypes.entries
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
                        inputFormatters: [_timeMaskController],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text("Способ оплаты"),
                              value: currentSelectedValuePayment,
                              isExpanded: true,
                              focusColor: AppStyle.colorPurple,
                              icon: SvgPicture.asset(
                                  'assets/images/svg/menu.svg'),
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  currentSelectedValuePayment = newValue;
                                });
                              },
                              items: _paymentType.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
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
                              horizontal: 10, vertical: 20),
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
                            '26 000 тг.',
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
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: FlatButton(
                        color: AppStyle.colorGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          displayCustomDialog(
                              context, '', DialogType.OrderType, true, () {});
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
    );
  }
}
