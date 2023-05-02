import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _emailNoWaValue = "";
  String _passwordValue = "";
  bool _emailNoWaEmpty = false;
  bool _visiblePassword = true;
  String _emailNoWaError = "";
  String _passwordError = "";
  bool _passwordEmpty = false;

  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  String get emailNoWaValue => _emailNoWaValue;
  set setEmailNoWaValue(String value) => _emailNoWaValue = value;

  String get passwordValue => _passwordValue;

  set setPasswordValue(String value) => _passwordValue = value;

  bool get emailNoWaEmpty => _emailNoWaEmpty;
  set setEmailNoWaEmpty(bool value) => _emailNoWaEmpty = value;

  bool get visiblePassword => _visiblePassword;

  setVisiblePassword() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  String get emailNoWaError => _emailNoWaError;
  set setEmailNoWaError(String value) => _emailNoWaError = value;

  String get passwordError => _passwordError;
  set setPasswordError(String value) => _passwordError = value;

  bool get passwordEmpty => _passwordEmpty;
  set setPasswordEmpty(bool value) => _passwordEmpty = value;
}
