import 'dart:core';

import 'package:flutter/material.dart';
import 'package:green_go/core/api/network/network_call.dart';

class BilimAPI {
  static BilimAPI _instance = BilimAPI.internal();
  BilimAPI.internal();
  factory BilimAPI() => _instance;

  NetworkCall _networkCall = NetworkCall();

  // auth API
  static const AUTH_LOGIN = 'auth/login';
  static const AUTH_REGISTER = 'auth/registere';
  static const INFO = 'auth/info';

  //Banners
  static const GET_BANNERS = 'banners';

  //Cart
  static const GET_CART = 'cart/items?filter[sellerId]=1';
  static const TO_CART = 'cart/products/1';
  static const ORDER = 'cart/order';
  static const DELETE_FROM_CART = 'cart/products/1';

  //Categories
  static const GET_CATEGORIES = 'cart/products/1';

  //Orders
  static const GET_ORDER = 'orders/1';
  static const GET_LIST_ORDER = 'orders';

  //Products
  static const GET_ONE_PRODUCT = 'products/1';
  static const GET_LIST_FILTERED_PRODUCTS =
      'product/?filter[categoryId]=2&sort[]=cost,desc';
  static const GET_TOP_PRODUCTS = 'products/top?filter[categoryId]=1';
  static const GET_PRODUCT_REVIEWS = 'products/1/reviews';

  //Sellers
  static const GET_SELLER = 'sellers/1';
  static const GET_LIST_SELLERS = 'products/1';
  static const GET_REVEIW_SELLERS = 'sellers/1/reviews';

  Future<dynamic> verifySmsCodeFromEmail(String email, String code,
      [BuildContext context]) async {
    dynamic response = await _networkCall.doRequestAuth(
      path: GET_BANNERS,
      method: 'POST',
      context: context,
      body: {
        'email': email,
        'code': code,
      },
    );
    return response;
  }
}
