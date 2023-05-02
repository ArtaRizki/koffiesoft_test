import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _emailValue = "";
  String _passwordValue = "";
  bool _emailEmpty = false;
  bool _visiblePassword = true;
  String _emailError = "";
  String _passwordError = "";
  bool _passwordEmpty = false;

  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  String get emailValue => _emailValue;
  set emailValue(value) {
    _emailValue = value;
  }

  String get passwordValue => _passwordValue;

  set passwordValue(value) {
    _passwordValue = value;
  }

  bool get emailEmpty => _emailEmpty;
  set emailEmpty(value) {
    _emailEmpty = value;
  }

  bool get visiblePassword => _visiblePassword;

  setVisiblePassword() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  String get emailError => _emailError;
  set emailError(value) {
    _emailError = value;
  }

  String get passwordError => _passwordError;
  set passwordError(value) {
    _passwordError = value;
  }

  bool get passwordEmpty => _passwordEmpty;
  set passwordEmpty(value) {
    _passwordEmpty = value;
  }
}
