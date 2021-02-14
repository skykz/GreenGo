import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_go/core/data/dialog_type.dart';
import 'package:green_go/utils/utils.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL = 'https://api.greengo.dev.renova.st/api/v1/';

class NetworkCall {
  // next three lines makes this class a Singleton
  static NetworkCall _instance = NetworkCall.internal();

  NetworkCall.internal();
  factory NetworkCall() => _instance;

  final JsonDecoder _decoder = JsonDecoder();
  dynamic _decodedRes;

  Future<dynamic> doRequestAuth(
      {@required String path,
      @required String method,
      @required BuildContext context,
      Map<String, dynamic> requestParams,
      Map<String, dynamic> body,
      FormData formData}) async {
    BaseOptions options = BaseOptions(
      headers: {'Accept': 'application/json'},
      baseUrl: BASE_URL, //base server url
      method: method,
      contentType: 'application/json',
    );

    Dio dio = Dio(options);
    Response response;

    try {
      response =
          await dio.request(path, queryParameters: requestParams, data: body);

      log(" - Response - ", name: " api route -- $path");
      print(' ==== RESPONSE: $response');

      _decodedRes = _decoder.convert(response.toString());
      return _decodedRes;
    } on DioError catch (error) {
      inspect(error);
      handleError(error, context);
    }
  }

  Future<dynamic> doRequestMain(
      {@required String path,
      @required String method,
      @required BuildContext context,
      Map<String, dynamic> requestParams,
      dynamic body,
      bool isToken}) async {
    BaseOptions options;
    SharedPreferences _shared = await SharedPreferences.getInstance();

    options = BaseOptions(
      baseUrl: BASE_URL,
      method: method,
      headers: {
        'Authorization': 'Bearer ' + _shared.getString('accessToken'),
        'Accept': 'application/json'
      },
      contentType: 'application/json',
    );

    Dio dio = Dio(options);
    Response response;
    try {
      response =
          await dio.request(path, queryParameters: requestParams, data: body);

      log(" - Response - ", name: " api route -- $path");
      return response.data;
    } on DioError catch (error) {
      // print(' --- req main errors +++++++++ $error');
      handleError(error, context);
    }
  }
}

/// handling avaiable cases from server
Future<void> handleError(DioError error, BuildContext context) async {
  String errorDescription;

  if (error.response.statusCode == 401) {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    displayCustomDialog(context, '_title', DialogType.AuthType, true, () {});
  } else if (error is DioError) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDescription = 'Запрос был отменен';
        print(errorDescription);

        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = 'Попробуйте позже или перезагрузите';
        print(errorDescription);

        break;
      case DioErrorType.DEFAULT:
        errorDescription = 'Интернет-желі табылмады';
        print(errorDescription);

        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = 'Время ожидание ответа сервера истекло';
        print(errorDescription);

        break;
      case DioErrorType.RESPONSE:
        errorDescription = error.response.data['data'].toString().isEmpty
            ? "Ошибка: " + error.response.data['message']
            : "Ошибка: " + error.response.data['data'].toString();
        print(errorDescription);

        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = 'Время соединения истекло';
        print(errorDescription);
        break;
    }
  }

  Scaffold.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: Duration(seconds: 20),
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.fixed,
        action: SnackBarAction(
          label: 'ОК',
          textColor: Colors.white,
          onPressed: () {},
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.info_outline_rounded, color: Colors.white),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  errorDescription,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
}
