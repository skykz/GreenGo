import 'dart:core';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_go/core/api/network/network_call.dart';

class GreenGoApi {
  static GreenGoApi _instance = GreenGoApi.internal();
  GreenGoApi.internal();
  factory GreenGoApi() => _instance;

  NetworkCall _networkCall = NetworkCall();

  // auth API
  static const AUTH_LOGIN = 'auth/login';
  static const AUTH_REGISTER = 'auth/register';
  static const AUTH_REGISTER_CONFIRM = 'auth/login/by-code';
  static const AUTH_CHANGE_PASSWORD = 'auth/password';
  static const AUTH_FORGET_PASSWORD = 'auth/send/code';

  static const INFO = 'auth/info';

  //Banners
  static const GET_BANNERS = 'banners';

  //search by query
  static const DO_SEARCH = 'search';

  // address
  static const GET_ADDRESS_LIST = 'my/addresses';
  static const ADDRESS = 'addresses';

  //Cart
  static const GET_CART = 'cart/items?filter[sellerId]=1';
  static const MY_CART = 'my/cart';
  static const CART = 'cart';

  //Categories
  static const GET_CATEGORIES_CATALOG = 'categories';

  //Orders
  static const CREATE_ORDER = 'orders/from-cart';
  static const GET_LIST_ORDER = 'orders';
  static const GET_ORDER_HISTORY = 'my/orders?with[seller]&with[products]';

  //Products
  static const GET_PRODUCT = 'products';
  static const GET_MY_PRODUCT = 'my/products';

  static const GET_LIST_FILTERED_PRODUCTS =
      'product/?filter[categoryId]=2&sort[]=cost,desc';
  static const GET_PRODUCT_REVIEWS = 'products/1/reviews';

  //Sellers
  static const GET_MY_SELLER_COUNT = 'my/sells-count';
  static const GET_MY_SELLS = 'my/sells';
  static const GET_LIST_SELLERS = 'products/1';
  static const GET_REVEIW_SELLERS = 'sellers/1/reviews';

  // Stores
  static const GET_STORES_LIST = 'stores';
  static const UPLOAD_FILES = 'files';

  Future<dynamic> authLogin(String _phone, String _pinCode,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: AUTH_LOGIN,
      method: 'POST',
      context: context,
      body: {
        'login': _phone,
        'password': _pinCode,
      },
    );
    return response;
  }

  Future<dynamic> changePinCode(String password, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: AUTH_CHANGE_PASSWORD,
      method: 'PATCH',
      context: context,
      body: {
        'password': password,
      },
    );
    return response;
  }

  Future<dynamic> recoverPinCode(String _phone, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: AUTH_FORGET_PASSWORD,
      method: 'POST',
      context: context,
      body: {
        'login': _phone,
      },
    );
    return response;
  }

  Future<dynamic> sendPhoneToRegister(String _phone,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: AUTH_REGISTER,
      method: 'POST',
      context: context,
      body: {
        'phone': _phone,
      },
    );
    return response;
  }

  Future<dynamic> finishRegisterByCode(String _smsCode, String _phone,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: AUTH_REGISTER_CONFIRM,
      method: 'POST',
      context: context,
      body: {
        'login': _phone,
        'code': _smsCode,
      },
    );
    return response;
  }

  Future<dynamic> getWindowProducts(
      String sort, int storeId, int categoryId, int page,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: GET_PRODUCT,
      method: 'GET',
      context: context,
      requestParams: {
        if (storeId != null) 'filter[storeId]': storeId,
        if (categoryId != null) 'filter[categoryId]': categoryId,
        if (sort != null) 'sort[]': sort,
        if (page != null) 'page': page,
      },
    );
    return response;
  }

  Future<dynamic> getTopProducts(int page,
      [int storeId, int categoryId, BuildContext context]) async {
    log("message storId => $storeId");
    log("message => $categoryId");
    log("page index => $page");

    dynamic response = await _networkCall.doRequestAuth(
        path: GET_PRODUCT,
        method: 'GET',
        context: context,
        requestParams: {
          'sort[]': 'salesCount,desc',
          if (storeId != null) 'filter[storeId]': storeId,
          if (categoryId != null) 'filter[categoryId]': categoryId,
          if (page != null) 'page': page,
        });
    return response;
  }

  Future<dynamic> getStoresList([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: GET_STORES_LIST,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getCatologList(
      [bool isRoot, int parentId, BuildContext context]) async {
    String path;
    if (isRoot)
      path = '?filter[parentId]=null';
    else
      path = '?filter[parentId]=$parentId';

    dynamic response = await _networkCall.doRequestAuth(
      path: GET_CATEGORIES_CATALOG + path,
      method: 'GET',
      context: context,
      requestParams: {},
    );
    return response;
  }

  Future<dynamic> getSingleProduct(int _id, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: GET_PRODUCT +
          '/$_id?with[category][with][parent]&with[images]&with[store]&with[author]',
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getProductsStore(int _id, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: GET_PRODUCT + '?filter[storeId]=$_id',
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getSameProduct(int _id, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: GET_PRODUCT + '?filter[categoryId]=$_id',
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getMainBanners([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: GET_BANNERS,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getMyCart([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: MY_CART,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> search(String _query, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
        path: DO_SEARCH,
        method: 'GET',
        context: context,
        requestParams: {
          'query': _query,
        });
    return response;
  }

  Future<dynamic> deleteCartItem(int _itemId, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: CART + "/$_itemId",
      method: 'DELETE',
      context: context,
    );
    return response;
  }

  Future<dynamic> changeCartItemCount(int _itemId, int count,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: CART + "/$_itemId",
        method: 'PATCH',
        context: context,
        body: {
          'count': count,
        });
    return response;
  }

  Future<dynamic> createOrderFromCart(Map<String, dynamic> _body,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: CREATE_ORDER,
      method: 'POST',
      context: context,
      body: _body,
    );
    return response;
  }

  Future<dynamic> addItemToCart(int _productId, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: CART,
      method: 'POST',
      context: context,
      body: {
        "productId": _productId,
        "count": 1,
      },
    );
    return response;
  }

  Future<dynamic> getAddressUser([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_ADDRESS_LIST,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> getOrderHistory(bool _isArchive,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_ORDER_HISTORY +
          '${_isArchive ? '&filter[status]=not:formed' : '&filter[status]=formed'}',
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> setNewAddressStatus(int _addId, String _value, bool _isMain,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: ADDRESS + '/$_addId',
        method: 'PATCH',
        context: context,
        body: {
          "value": _value,
          'isMain': _isMain,
        });
    return response;
  }

  Future<dynamic> createUserAddress(String _value,
      [BuildContext context]) async {
    dynamic response = await _networkCall
        .doRequestMain(path: ADDRESS, method: 'POST', context: context, body: {
      "value": _value,
    });
    return response;
  }

  Future<dynamic> uploadImage(File _file, [BuildContext context]) async {
    String fileName = _file.path.split('/').last;
    dynamic formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(_file.path, filename: fileName),
    });
    dynamic response = await _networkCall.doRequestMain(
      path: UPLOAD_FILES,
      method: 'POST',
      context: context,
      body: formData,
    );
    return response;
  }

  Future<dynamic> getMyProductsActive([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: GET_MY_PRODUCT,
        method: 'GET',
        context: context,
        requestParams: {
          ' filter[status]': 'active',
        });
    return response;
  }

  Future<dynamic> getMyProductsNotActive([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: GET_MY_PRODUCT,
        method: 'GET',
        context: context,
        requestParams: {
          ' filter[status]': 'not:active',
        });
    return response;
  }

  Future<dynamic> createProducts(int cost, String _title, String _desc,
      bool canPickup, bool canDeliver, List<int> _imageId,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: GET_PRODUCT,
        method: 'POST',
        context: context,
        body: {
          "cost": cost,
          "title": _title,
          "description": _desc,
          "canPickup": canPickup,
          "canDeliver": canDeliver,
          "images": _imageId,
        });
    return response;
  }

  Future<dynamic> getMySellersCount([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_MY_SELLER_COUNT,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> cancelOrderItem(int id, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
        path: GET_PRODUCT + "/$id",
        method: 'PATCH',
        context: context,
        body: {
          "status": "canceled",
        });
    return response;
  }

  Future<dynamic> getMySells([BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: GET_MY_SELLS,
      method: 'GET',
      context: context,
    );
    return response;
  }

  Future<dynamic> addNewAddress(String _address, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: ADDRESS,
      method: 'POST',
      context: context,
      body: {
        "value": _address,
      },
    );
    return response;
  }

  Future<dynamic> deleteAddress(int _id, [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestMain(
      path: ADDRESS + '/$_id',
      method: 'DELETE',
      context: context,
    );
    return response;
  }
}
