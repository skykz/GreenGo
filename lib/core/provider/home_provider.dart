import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_go/core/api/repositories/api_repo.dart';
import 'package:green_go/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_provider.dart';

class HomeProvider extends BaseProvider {
  int _selectedIndex = 0;
  int get getSelectedIndex => _selectedIndex;
  GreenGoApi _greenGoApi = GreenGoApi();
  PageController _pageController = PageController();

  PageController get getPageController => _pageController;

  void setSelectedIndex(int val) {
    this._selectedIndex = val;
    notifyListeners();
  }

  setPhone(BuildContext context, String _phone) {
    if (_phone.length >= 11) {
      _pageController.animateToPage(4,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      showCustomSnackBar(context, 'Неправильный формат номера!',
          Colors.redAccent, Icons.cancel_outlined);
    }
  }

  doAuthLogin(BuildContext context, String _phone, String _pinCode) {
    if (_phone.length >= 11 && _pinCode.length >= 5) {
      setLoadingState(true);
      _greenGoApi.authLogin(_phone, _pinCode, context).then((value) {
        showCustomSnackBar(context, 'Вы успешно авторизовались!', Colors.green,
            Icons.check_rounded);
        Future.delayed(
          const Duration(milliseconds: 1300),
          () => Navigator.pop(context),
        );
      }).whenComplete(() => setLoadingState(false));
    } else {
      showCustomSnackBar(context, 'Неправильный формат номера!',
          Colors.redAccent, Icons.cancel_outlined);
    }
  }

  doRegisterByPhone(BuildContext context, String _phone) {
    if (_phone != null) {
      if (_phone.length >= 11) {
        inspect(_phone);
        setLoadingState(true);
        _greenGoApi.sendPhoneToRegister(_phone, context).then((value) {
          inspect(value);
          if (value != null) {
            _pageController.animateToPage(2,
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
            showCustomSnackBar(context, 'SMS код отправлен на Ваш номер.',
                Colors.green, Icons.check_rounded);
          }
        }).whenComplete(() => setLoadingState(false));
      } else {
        showCustomSnackBar(context, 'Неправильный формат номера!',
            Colors.redAccent, Icons.cancel_outlined);
      }
    }
  }

  confirmRegisterBySmsCode(
      BuildContext context, String _smsCode, String _phone) {
    if (_smsCode != null && _phone != null) {
      inspect(_smsCode);
      inspect(_phone);
      setLoadingState(true);
      _greenGoApi.finishRegisterByCode(_smsCode, _phone, context).then((value) {
        if (value != null) {
          if (value['data']['token'] != null) {
            _pageController.animateToPage(3,
                duration: Duration(milliseconds: 300), curve: Curves.easeIn);
            setAccessToken(value['data']['token']);
          }
        }
      }).whenComplete(() => setLoadingState(false));
    } else {
      showCustomSnackBar(context, 'SMS код неправильный!', Colors.redAccent,
          Icons.cancel_outlined);
    }
  }

  changeAuthPassword(BuildContext context, String _pinCode) async {
    inspect(_pinCode);
    if (_pinCode.length >= 5) {
      setLoadingState(true);
      _greenGoApi.changePinCode(_pinCode).then((value) {
        if (value != null) {
          _pageController.animateToPage(3,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          showCustomSnackBar(context, 'Пин код успешно изменился!',
              Colors.green, Icons.check_rounded);
          Future.delayed(
            const Duration(milliseconds: 1300),
            () => Navigator.pop(context),
          );
        }
      }).whenComplete(() => setLoadingState(false));
    } else {
      showCustomSnackBar(context, 'Введите ПИН код правильно!',
          Colors.redAccent, Icons.cancel_rounded);
    }
  }

  recoverPassword(BuildContext context, String _phone) async {
    inspect(_phone);
    if (_phone.length >= 11) {
      setLoadingState(true);
      _greenGoApi.recoverPinCode(_phone, context).then((value) {
        if (value != null) {
          _pageController.animateToPage(2,
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
          showCustomSnackBar(context, 'SMS код отправлен на Ваш номер.',
              Colors.green, Icons.check_rounded);
        }
      }).whenComplete(() => setLoadingState(false));
    } else {
      showCustomSnackBar(context, 'Введите ПИН код правильно!',
          Colors.redAccent, Icons.cancel_rounded);
    }
  }

  Future<String> getAccessToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString('accessToken');
    return token;
  }

  setAccessToken(String _token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('accessToken', _token);
  }

  Future getTopProducts(BuildContext context, [int storeId]) async {
    return await _greenGoApi.getTopProducts(
      storeId,
      context,
    );
  }

  Future getWindowProducts(BuildContext context,
      [String sort, int storeId]) async {
    inspect(sort);
    inspect(storeId);

    return await _greenGoApi.getWindowProducts(sort, storeId, context);
  }

  Future getCatalogsProducts(BuildContext context, [bool isRoot]) async {
    return await _greenGoApi.getCatologList(isRoot, context);
  }

  /// get stores list
  Future getStoresList(BuildContext context) async {
    return await _greenGoApi.getStoresList(context);
  }

  Future getProductsStore(BuildContext context, int _id) async {
    return await _greenGoApi.getProductsStore(_id, context);
  }

  Future getSingleProduct(int id, BuildContext context) async {
    return await _greenGoApi.getSingleProduct(id, context);
  }

  Future getBannerList(BuildContext context) async {
    return await _greenGoApi.getMainBanners(context);
  }

  Future getSameProduct(BuildContext context, int _categoryId) async {
    return await _greenGoApi.getSameProduct(_categoryId, context);
  }
}
