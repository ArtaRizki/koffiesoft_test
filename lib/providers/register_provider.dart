import 'package:flutter/material.dart';

import '../services/register_service.dart';

class RegisterProvider extends ChangeNotifier {
  RegisterService registerService = RegisterService();

  refresh() => notifyListeners();

  bool _visiblePassword = true;
  bool _visibleRetypePassword = true;
  bool _isLoading = false;
  String _firstnameValue = "";
  String _lastnameValue = "";
  String _emailValue = "";
  String _noHpValue = "";
  String _passwordValue = "";
  String _reTypePasswordValue = "";
  String _tglLahir = "";
  int _jenisKelamin = 1;
  bool _batalOtpTelepon = false;

  int _userId = 0;
  int get userId => _userId;

  set userId(int value) {
    _userId = value;
    notifyListeners();
  }

  get visiblePassword => _visiblePassword;

  set visiblePassword(value) {
    _visiblePassword = value;
    notifyListeners();
  }

  changePasswordEye() {
    _visiblePassword = !_visiblePassword;
    notifyListeners();
  }

  get visibleRetypePassword => _visibleRetypePassword;

  set visibleRetypePassword(value) {
    _visibleRetypePassword = value;
    notifyListeners();
  }

  get tglLahir => _tglLahir;

  set tglLahir(value) {
    _tglLahir = value;
    notifyListeners();
  }

  get jenisKelamin => _jenisKelamin;

  set jenisKelamin(value) {
    _jenisKelamin = value;
    notifyListeners();
  }

  changeReTypePasswordEye() {
    _visibleRetypePassword = !_visibleRetypePassword;
    notifyListeners();
  }

  get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  // data pribadi

  get firstnameValue => _firstnameValue;
  get lastnameValue => _lastnameValue;

  set firstnameValue(value) {
    _firstnameValue = value;
    // notifyListeners();
  }

  set lastnameValue(value) {
    _lastnameValue = value;
    // notifyListeners();
  }

  get emailValue => _emailValue;

  set emailValue(value) {
    _emailValue = value;
  }

  get noHpValue => _noHpValue;

  set noHpValue(value) {
    _noHpValue = value;
  }

  get passwordValue => _passwordValue;

  set passwordValue(value) {
    _passwordValue = value;
  }

  get reTypePasswordValue => _reTypePasswordValue;

  set reTypePasswordValue(value) {
    _reTypePasswordValue = value;
  }

  get batalOtpTelepon => _batalOtpTelepon;

  set batalOtpTelepon(value) {
    _batalOtpTelepon = value;
  }

  bool _firstnameEmpty = false;
  bool _lastnameEmpty = false;
  bool _emailEmpty = false;
  bool _noHpEmpty = false;
  bool _passwordEmpty = false;
  bool _reTypePasswordEmpty = false;
  bool _tglLahirEmpty = false;

  get firstnameEmpty => _firstnameEmpty;
  get lastnameEmpty => _lastnameEmpty;

  set firstnameEmpty(value) {
    _firstnameEmpty = value;
  }

  set lastnameEmpty(value) {
    _lastnameEmpty = value;
  }

  get emailEmpty => _emailEmpty;

  set emailEmpty(value) {
    _emailEmpty = value;
  }

  get noHpEmpty => _noHpEmpty;

  set noHpEmpty(value) {
    _noHpEmpty = value;
  }

  get passwordEmpty => _passwordEmpty;

  set passwordEmpty(value) {
    _passwordEmpty = value;
  }

  get reTypePasswordEmpty => _reTypePasswordEmpty;

  set reTypePasswordEmpty(value) {
    _reTypePasswordEmpty = value;
  }

  get tglLahirEmpty => _tglLahirEmpty;

  set tglLahirEmpty(value) {
    _tglLahirEmpty = value;
  }

  // data pribadi
  String _firstnameError = "";
  String _lastnameError = "";
  String _emailError = "";
  String _noHpError = "";
  String _passwordError = "";
  String _reTypePasswordError = "";
  String _tglLahirError = "";

  get firstnameError => _firstnameError;
  get lastnameError => _lastnameError;

  set firstnameError(value) {
    _firstnameError = value;
  }

  set lastnameError(value) {
    _firstnameError = value;
  }

  get emailError => _emailError;

  set emailError(value) {
    _emailError = value;
  }

  get noHpError => _noHpError;

  set noHpError(value) {
    _noHpError = value;
  }

  get passwordError => _passwordError;

  set passwordError(value) {
    _passwordError = value;
  }

  get reTypePasswordError => _reTypePasswordError;

  set reTypePasswordError(value) {
    _reTypePasswordError = value;
  }

  get tglLahirError => _tglLahirError;

  set tglLahirError(value) {
    _tglLahirError = value;
  }

  // data resto
  String namaUsahaError = "";
  String _noTelpError = "";
  String _emailRestoError = "";
  String _provinsiError = "";
  String _kotaError = "";
  String _alamatError = "";
  String _noNpwpError = "";

  get getNamaUsahaError => namaUsahaError;

  set setNamaUsahaError(value) {
    namaUsahaError = value;
  }

  get noTelpError => _noTelpError;

  set noTelpError(value) {
    _noTelpError = value;
  }

  get emailRestoError => _emailRestoError;

  set emailRestoError(value) {
    _emailRestoError = value;
  }

  get provinsiError => _provinsiError;

  set provinsiError(value) {
    _provinsiError = value;
  }

  get kotaError => _kotaError;

  set kotaError(value) {
    _kotaError = value;
  }

  get alamatError => _alamatError;

  set alamatError(value) {
    _alamatError = value;
  }

  get noNpwpError => _noNpwpError;

  set noNpwpError(value) {
    _noNpwpError = value;
  }
}
