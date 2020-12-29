import 'package:flutter/material.dart';

class BaseProvider extends ChangeNotifier {
  bool _isPlatformIOS;
  bool get isIOS => this._isPlatformIOS;

  bool _isLoading = false;
  bool get getIsLoading => this._isLoading;

  setPlatformType(bool _val) {
    this._isPlatformIOS = _val;
    notifyListeners();
  }

  setLoadingState(bool _val) {
    this._isLoading = _val;
    notifyListeners();
  }
}
