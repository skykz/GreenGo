import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';
import 'package:green_go/components/widgets/loader_widget.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/core/provider/home_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CustomActionDialog extends StatefulWidget {
  final String title;
  final Function onPressed;
  final BuildContext context;
  final String cancelOptionText;
  final DialogType dialogType;
  final Color color;
  final String confirmOptionText;

  CustomActionDialog({
    @required this.title,
    @required this.onPressed,
    @required this.dialogType,
    this.color,
    this.context,
    this.cancelOptionText,
    this.confirmOptionText,
  });

  @override
  _CustomActionDialogState createState() => _CustomActionDialogState();
}

class _CustomActionDialogState extends State<CustomActionDialog> {
  final _phoneValueController = MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  final _smsTextController = TextEditingController();
  final _pinPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.bounceIn,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: _setDialogType(this.widget.dialogType),
    );
  }

  _setDialogType(DialogType dialogType) {
    switch (dialogType) {
      case DialogType.AuthType:
        return Consumer<HomeProvider>(
          builder: (context, value, child) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 75.0.h,
              child: Scaffold(
                body: PageView(
                  controller: value.getPageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    //login
                    _setAuthView(value),
                    //register
                    _setRegisterView(value),
                    _setPinCodeView(value),
                    _setPinCodeViewForAuth(value),
                    //login
                    _setPinCodeViewWithForgot(value),
                  ],
                ),
              ),
            ),
          ),
        );
        break;
      case DialogType.OrderType:
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'ВАШ ЗАКАЗ ОФОРМЛЕН',
                  style: TextStyle(
                    fontSize: 13.0.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FlatButton(
                color: AppStyle.colorPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  final homeProvider =
                      Provider.of<HomeProvider>(context, listen: false);
                  Navigator.of(context, rootNavigator: true).pop();
                  homeProvider.setSelectedIndex(0);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'ПРОДОЛЖИТЬ ПОКУПКИ',
                      style: TextStyle(
                        fontSize: 10.0.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              OutlineButton(
                borderSide: BorderSide(
                  color: AppStyle.colorPurple,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                highlightColor: Colors.grey[300],
                highlightedBorderColor: Colors.purple,
                onPressed: this.widget.onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'ПРОСМОТРЕТЬ ИСТОРИЮ ЗАКАЗОВ',
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      color: AppStyle.colorPurple,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
        break;
      case DialogType.AddressType:
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Новый адрес:',
                  style: TextStyle(
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  cursorColor: Colors.purple,
                  cursorRadius: Radius.circular(10.0),
                  cursorWidth: 2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    hintStyle: TextStyle(
                      fontSize: 12.0.sp,
                      color: Colors.grey[400],
                    ),
                    hintText: 'Улица',
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
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        cursorColor: Colors.purple,
                        cursorRadius: Radius.circular(10.0),
                        cursorWidth: 2,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          hintStyle: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.grey[400],
                          ),
                          hintText: 'Дом',
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          cursorColor: Colors.purple,
                          cursorRadius: Radius.circular(10.0),
                          cursorWidth: 2,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            hintStyle: TextStyle(
                              fontSize: 12.0.sp,
                              color: Colors.grey[400],
                            ),
                            hintText: 'Подъезд',
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
                    ),
                    Flexible(
                      child: TextField(
                        cursorColor: Colors.purple,
                        cursorRadius: Radius.circular(10.0),
                        cursorWidth: 2,
                        inputFormatters: [_phoneValueController],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          hintStyle: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.grey[400],
                          ),
                          hintText: 'Квартира',
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
              SizedBox(
                height: 3.0.h,
              ),
              FlatButton(
                onPressed: () {},
                color: AppStyle.colorGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Text(
                      'Добавить',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      default:
    }
  }

  _setAuthView(HomeProvider _value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Text(
              'ВХОД',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: [
              TextField(
                cursorColor: Colors.purple,
                cursorRadius: Radius.circular(10.0),
                textAlign: TextAlign.center,
                cursorWidth: 2,
                keyboardType: TextInputType.number,
                inputFormatters: [_phoneValueController],
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Builder(
                  builder: (ctx) => FlatButton(
                    color: AppStyle.colorGreen,
                    onPressed: () {
                      _value.setPhone(
                          ctx, _phoneValueController.getUnmaskedText());
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'ВОЙТИ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Еще не зарегистрированы?',
                style: TextStyle(
                  color: Color(0xff9E1AEF),
                  fontSize: 10.0.sp,
                ),
              ),
            ],
          ),
          FlatButton(
            color: AppStyle.colorPurple,
            onPressed: () {
              _phoneValueController?.clear();
              _value.getPageController.animateToPage(1,
                  duration: Duration(milliseconds: 300), curve: Curves.easeIn);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Text(
                  'РЕГИСТРАЦИЯ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setRegisterView(HomeProvider _value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Column(
              children: [
                Text(
                  'РЕГИСТРАЦИЯ\nПОЛЬЗОВАТЕЛЯ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Пожалуйста заполните поля для регистрации пользователя',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10.0.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextField(
                    cursorColor: Colors.purple,
                    cursorRadius: Radius.circular(10.0),
                    textAlign: TextAlign.center,
                    cursorWidth: 2,
                    keyboardType: TextInputType.number,
                    inputFormatters: [_phoneValueController],
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Builder(
              builder: (ctx) => FlatButton(
                color: AppStyle.colorGreen,
                onPressed: !_value.getIsLoading
                    ? () {
                        _value.doRegisterByPhone(
                            ctx, _phoneValueController.getUnmaskedText());
                      }
                    : () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: _value.getIsLoading
                        ? const LoaderWidget()
                        : Text(
                            'ЗАРЕГИСТРИРОВАТЬСЯ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0.sp,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setPinCodeView(HomeProvider _value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ВВЕДИТЕ КОД ДОСТУПА',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Для подтверждения телефона Вам был отправлен код доступа',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0.sp,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              cursorColor: Colors.purple,
              cursorRadius: Radius.circular(10.0),
              textAlign: TextAlign.center,
              cursorWidth: 2,
              keyboardType: TextInputType.number,
              controller: _smsTextController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                hintStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: Colors.grey[400],
                ),
                hintText: 'SMS КОД',
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Builder(
              builder: (ctx) => FlatButton(
                color: AppStyle.colorGreen,
                onPressed: !_value.getIsLoading
                    ? () {
                        _value.confirmRegisterBySmsCode(
                            ctx,
                            _smsTextController.text,
                            _phoneValueController.getUnmaskedText());
                      }
                    : () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: _value.getIsLoading
                        ? const LoaderWidget()
                        : Text(
                            'ДАЛЕЕ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0.sp,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setPinCodeViewForAuth(HomeProvider _value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Придумайте пин-код\nдля авторизации',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              cursorColor: Colors.purple,
              cursorRadius: Radius.circular(10.0),
              textAlign: TextAlign.center,
              cursorWidth: 2,
              keyboardType: TextInputType.number,
              controller: _pinPasswordController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                hintStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: Colors.grey[400],
                ),
                hintText: 'ПИН - КОД',
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Builder(
              builder: (ctx) => FlatButton(
                color: AppStyle.colorGreen,
                onPressed: _value.getIsLoading
                    ? () {}
                    : () {
                        _value.changeAuthPassword(
                            ctx, _pinPasswordController.text);
                      },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: _value.getIsLoading
                        ? const LoaderWidget()
                        : Text(
                            'ДАЛЕЕ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0.sp,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setPinCodeViewWithForgot(HomeProvider _value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Введите код доступа',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.purple,
                  cursorRadius: Radius.circular(10.0),
                  textAlign: TextAlign.center,
                  cursorWidth: 2,
                  controller: _pinPasswordController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    hintStyle: TextStyle(
                      fontSize: 12.0.sp,
                      color: Colors.grey[400],
                    ),
                    hintText: 'ПИН - КОД',
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
                Builder(
                  builder: (ctx) => InkWell(
                    onTap: () {
                      _value.recoverPassword(
                          ctx, _phoneValueController.getUnmaskedText());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          color: Color.fromRGBO(158, 26, 239, 0.5),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Builder(
              builder: (ctx) => FlatButton(
                color: AppStyle.colorGreen,
                onPressed: _value.getIsLoading
                    ? () {}
                    : () {
                        _value.doAuthLogin(
                            ctx,
                            _phoneValueController.getUnmaskedText(),
                            _pinPasswordController.text);
                      },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: _value.getIsLoading
                        ? const LoaderWidget()
                        : Text(
                            'ДАЛЕЕ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0.sp,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
