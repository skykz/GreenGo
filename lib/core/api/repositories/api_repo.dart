import 'dart:core';

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

  //Cart
  static const GET_CART = 'cart/items?filter[sellerId]=1';
  static const MY_CART = 'my/cart';
  static const CART = 'cart';
  static const DELETE_FROM_CART = 'cart/products/1';

  //Categories
  static const GET_CATEGORIES_CATALOG = 'categories';

  //Orders
  static const GET_ORDER = 'orders/1';
  static const GET_LIST_ORDER = 'orders';

  //Products
  static const GET_PRODUCT = 'products';
  static const GET_LIST_FILTERED_PRODUCTS =
      'product/?filter[categoryId]=2&sort[]=cost,desc';
  static const GET_PRODUCT_REVIEWS = 'products/1/reviews';

  //Sellers
  static const GET_SELLER = 'sellers/1';
  static const GET_LIST_SELLERS = 'products/1';
  static const GET_REVEIW_SELLERS = 'sellers/1/reviews';

  // Stores
  static const GET_STORES_LIST = 'stores';

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

  Future<dynamic> getWindowProducts(String sort, int storeId, int categoryId,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: GET_PRODUCT,
      method: 'GET',
      context: context,
      requestParams: {
        if (storeId != null) 'filter[storeId]': storeId,
        if (categoryId != null) 'filter[categoryId]': categoryId,
        if (sort != null) 'sort[]': sort,
      },
    );
    return response;
  }

  Future<dynamic> getTopProducts(
      [int storeId, int categoryId, BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
        path: GET_PRODUCT,
        method: 'GET',
        context: context,
        requestParams: {
          'sort[]': 'salesCount,desc',
          if (storeId != null) 'filter[storeId]': storeId,
          if (categoryId != null) 'filter[categoryId]': categoryId,
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
}
