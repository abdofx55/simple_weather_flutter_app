import 'package:flutter/material.dart';

class ChangeLocationViewModel extends ChangeNotifier {
  String _city = '';

  String get city => _city;

  void setCity(String value) {
    _city = value;
    notifyListeners();
  }

  void clearCity() {
    _city = '';
    notifyListeners();
  }
}
