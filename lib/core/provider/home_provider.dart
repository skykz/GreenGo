import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get getSelectedIndex => _selectedIndex;

  void setSelectedIndex(int val) {
    this._selectedIndex = val;
    notifyListeners();
  }
}
