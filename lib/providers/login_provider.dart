import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' as d;
import 'package:fluttertoast/fluttertoast.dart';
import '../consts/url.dart';
import '../libraries/dio_client.dart';
import '../libraries/validator.dart';
import '../models/login_state.dart';

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider() : super(const LoginState.noError());

  static final DioClient dio = DioClient();

  Future<void> changeLoading() async {
    state = const LoginState.loading();
  }

  Future<Map<String, dynamic>> loginUser(
      BuildContext context, String? val) async {
    final bool emailEmpty =
            state.maybeWhen(loading: () => true, orElse: () => false),
        passwordEmpty =
            state.maybeWhen(loading: () => true, orElse: () => false);
    final String username = state.maybeWhen(
        emailValue: (emailValue) => emailValue, orElse: () => "");
    final String password = state.maybeWhen(
        passwordValue: (passwordValue) => passwordValue, orElse: () => "");
    final String emailError = state.maybeWhen(
        emailError: (emailError) => emailError, orElse: () => "");
    checkEmail(val, emailEmpty, emailError);
    log("EMAIL KOSONG : $emailEmpty");
    log("EMAIL KOSONG : $emailError");
    log("PASSWORD KOSONG : $passwordEmpty");
    state = const LoginState.loading();
    if (!emailEmpty && !passwordEmpty) {
      // try {
      d.Response<dynamic>? response = await dio.requestPost(
        loginPath,
        {"username": username, "password": password},
        onSendProgress: null,
        onReceiveProgress: null,
        options: null,
      );
      Map<String, dynamic> result = response!.data;
      if (result['status']['kode'] == 'success') {
        state = const LoginState.emailValue("");
        state = const LoginState.passwordValue("");
        log("LOGIN RESULT : ${jsonEncode(result['data'])}");
        // up.user = userModelFromJson(jsonEncode(result['data']));
        // log("USER EMAIL : ${up.user.email}");
        // log("USER ID : ${up.user.id}");
        Fluttertoast.showToast(msg: "Login Sukses");
        state = const LoginState.noError();
        log("LOGIN RESULT 2 : ${jsonEncode(result)}");
        return result;
      } else {
        Fluttertoast.showToast(msg: jsonEncode(result['status']['keterangan']));
        state = const LoginState.noError();
        return {};
      }
      // } catch (e) {
      //   lp.isLoading = false;
      //   return null;
      // }
    } else {
      state = const LoginState.noError();
      return {};
    }
  }

  checkEmail(String? val, bool emailEmpty, String emailError) {
    String? msg = loginEmail(val);
    emailEmpty = msg != null;
    if (emailEmpty) {
      state = const LoginState.emailEmpty();
    }
    emailError = msg ?? "";
    log("CHECK EMAIL2 : $emailEmpty");
    log("CHECK EMAIL2 : $emailError");
    log("CHECK EMAIL2 : ${state.maybeWhen(emailEmpty: () => true, orElse: () => false)}");

    state = LoginState.emailError(emailError);
  }

  checkPassword(String? val, bool passwordEmpty, String passwordError) {
    String? msg = registerPassword(val);
    passwordEmpty = msg != null;
    passwordError = msg ?? "";
  }

  changeVisiblePassword(bool val) {
    state = LoginState.visiblePassword(val);
  }
}
