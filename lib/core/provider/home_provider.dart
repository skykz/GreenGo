import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_go/core/api/repositories/api_repo.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_provider.dart';

class HomeProvider extends BaseProvider {
  int _selectedIndex = 0;
  int get getSelectedIndex => _selectedIndex;
  GreenGoApi _greenGoApi = GreenGoApi();
  PageController _pageController = PageController();

  PageController get getPageController => _pageController;

  dynamic foundedList;
  Timer _timer;
  int _selectedCategoryIndex = 0;
  int get getSelectedCategoryIndex => this._selectedCategoryIndex;

  int _selectedCategoryId;
  int get getSelectedCategoryId => this._selectedCategoryId;

  void setSelectedCategoryIndex(int val) {
    this._selectedCategoryIndex = val;
    notifyListeners();
  }

  void setSelectedCategoryId(int val) {
    this._selectedCategoryId = val;
    notifyListeners();
  }

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
        setAccessToken(value['data']['token']);
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

  Future getTopProducts(BuildContext context,
      [int storeId, int categoryId]) async {
    return await _greenGoApi.getTopProducts(
      storeId,
      categoryId,
      context,
    );
  }

  Future getWindowProducts(BuildContext context,
      [String sort, int storeId, int categoryId]) async {
    inspect(sort);
    inspect(storeId);
    inspect(categoryId);

    return await _greenGoApi.getWindowProducts(
        sort, storeId, categoryId, context);
  }

  Future getCatalogsProducts(BuildContext context,
      [bool isRoot, int parentId]) async {
    return await _greenGoApi.getCatologList(isRoot, parentId, context);
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

  Future getMyCart(BuildContext context) async {
    return await _greenGoApi.getMyCart(context);
  }

  void doSearch(String _query, BuildContext context) async {
    if (_timer != null) {
      _timer.cancel();
    }
    log('$_query');
    _timer = Timer(Duration(milliseconds: 300), () {
      if (_query.isNotEmpty) {
        setLoadingState(true);
        _greenGoApi.search(_query, context).then((value) {
          if (value != null) foundedList = value;
          notifyListeners();
        }).whenComplete(() => setLoadingState(false));
      } else {
        foundedList = null;
        notifyListeners();
      }
    });
  }

  Future deleteCartItem(int itemId, BuildContext context) async {
    setLoadingState(true);
    _greenGoApi.deleteCartItem(itemId, context).then((value) {
      if (value['message'] != null)
        showCustomSnackBar(context, value['message'].toString(), Colors.green,
            Icons.check_rounded);
    }).whenComplete(() => setLoadingState(false));
  }

  Future changeCartItemCount(
      int itemId, int count, BuildContext context) async {
    if (itemId != null && count != null) {
      if (_timer != null) {
        _timer.cancel();
      }
      _timer = Timer(Duration(milliseconds: 1500), () async {
        setLoadingState(true);
        _greenGoApi.changeCartItemCount(itemId, count, context).then((value) {
          inspect(value);
          if (value['message'] != null)
            showCustomSnackBar(context, value['message'].toString(),
                Colors.green, Icons.check_rounded);
        }).whenComplete(() => setLoadingState(false));
      });
    }
  }

  createOrderFromCart(
      String _phone,
      String _time,
      int _sellerId,
      String _sellerType,
      String _address,
      String _deliveryMethod,
      String _paymentMethod,
      BuildContext context) async {
    if (_phone.isNotEmpty &&
        _paymentMethod.isNotEmpty &&
        _sellerId != null &&
        _sellerType.isNotEmpty) {
      setLoadingState(true);
      Map<String, dynamic> _bodyFormat = {
        "sellerId": _sellerId,
        "sellerType": _sellerType,
        "deliveryMethod": _deliveryMethod,
        "address": _address,
        "time": _time,
        "paymentMethod": _paymentMethod,
        "phone": _phone,
      };
      inspect(_bodyFormat);
      _greenGoApi.createOrderFromCart(_bodyFormat, context).then((value) {
        if (value != null) {
          showCustomSnackBar(
              context, value['message'], Colors.green, Icons.check_rounded);
          displayCustomDialog(
            context,
            '',
            DialogType.OrderType,
            false,
            () {},
          );
        }
      }).whenComplete(
        () => setLoadingState(false),
      );
    }
  }

  addProductToCart(int _productId, BuildContext context) {
    if (_productId != null) {
      setLoadingState(true);
      _greenGoApi.addItemToCart(_productId, context).then((value) {
        if (value['message'] != null)
          showCustomSnackBar(
              context, value['message'], Colors.green, Icons.check_rounded);
      }).whenComplete(() => setLoadingState(false));
    }
  }

  Future getAddressList(BuildContext context) async {
    return await _greenGoApi.getAddressUser(context);
  }

  Future getOrderHistory(bool _isArchive, BuildContext context) async {
    return await _greenGoApi.getOrderHistory(_isArchive, context);
  }

  setNewAddress(
      int _addId, String _value, bool _isMain, BuildContext context) async {
    setLoadingState(true);

    _greenGoApi
        .setNewAddressStatus(_addId, _value, _isMain, context)
        .whenComplete(() => setLoadingState(false));
  }

  Future uploadImageItem(File _file, BuildContext context) async {
    setLoadingState(true);
    return await _greenGoApi
        .uploadImage(_file, context)
        .whenComplete(() => setLoadingState(false));
  }

  Future getMyProductsUserActive(BuildContext context) async {
    return await _greenGoApi.getMyProductsActive(context);
  }

  Future getMyProductsUserNotActive(BuildContext context) async {
    return await _greenGoApi.getMyProductsNotActive(context);
  }

  createProduct(int cost, String _title, String _desc, bool canPickup,
      bool canDeliver, List<int> _imageId, context) {
    setLoadingState(true);
    _greenGoApi
        .createProducts(
            cost, _title, _desc, canPickup, canDeliver, _imageId, context)
        .then((value) {
      if (value != null) {
        showCustomSnackBar(
            context, value['message'], Colors.green, Icons.check_rounded);
      }
    }).whenComplete(() {
      setLoadingState(false);

      Future.delayed(Duration(seconds: 1), () {
        setSelectedIndex(9);
      });
    });
  }

  Future getMySellersCount(BuildContext context) async {
    return await _greenGoApi.getMySellersCount(context);
  }

  Future getMySells(BuildContext context) async {
    return await _greenGoApi.getMySells(context);
  }

  Future cancelMyOrderItem(int id, BuildContext context) async {
    setLoadingState(true);
    return await _greenGoApi.cancelOrderItem(id, context).then((value) {
      if (value != null)
        showCustomSnackBar(
            context, value['message'], Colors.green, Icons.check_rounded);
    }).whenComplete(() => setLoadingState(false));
  }
}
