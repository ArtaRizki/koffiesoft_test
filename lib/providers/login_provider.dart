import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart' as d;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koffiesoft_test/models/field_model.dart';
import '../consts/url.dart';
import '../libraries/dio_client.dart';
import '../libraries/validator.dart';
import '../models/login_event.dart';
import '../models/login_state.dart';

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider() : super(LoginState.noError());

  static final DioClient dio = DioClient();

  Future<void> changeLoading() async {
    state = state.copyWith(isLoading: true);
  }

  Future<Map<String, dynamic>> loginUser(
      BuildContext context, String? val) async {
    final bool emailEmpty = state.email.isEmpty,
        passwordEmpty = state.password.isEmpty;
    final String email = state.email.value, password = state.password.value;
    final String emailError = state.email.errorMessage,
        passwordError = state.password.errorMessage;
    checkEmail(val, emailEmpty, emailError);
    checkPassword(val, passwordEmpty, passwordError);
    log("EMAIL KOSONG : $emailEmpty");
    log("EMAIL KOSONG : $emailError");
    log("PASSWORD KOSONG : $passwordEmpty");
    log("PASSWORD KOSONG : $passwordError");
    state = state.copyWith(isLoading: true);
    if (!emailEmpty && !passwordEmpty) {
      // try {
      d.Response<dynamic>? response = await dio.requestPost(
        loginPath,
        {"email": email, "password": password},
        onSendProgress: null,
        onReceiveProgress: null,
        options: null,
      );
      Map<String, dynamic> result = response!.data;
      if (result['status']['kode'] == 'success') {
        log("LOGIN RESULT : ${jsonEncode(result['data'])}");
        // up.user = userModelFromJson(jsonEncode(result['data']));
        // log("USER EMAIL : ${up.user.email}");
        // log("USER ID : ${up.user.id}");
        Fluttertoast.showToast(msg: "Login Sukses");
        state = LoginState.noError();
        log("LOGIN RESULT 2 : ${jsonEncode(result)}");
        return result;
      } else {
        Fluttertoast.showToast(msg: jsonEncode(result['status']['keterangan']));
        state = LoginState.noError();
        return {};
      }
      // } catch (e) {
      //   lp.isLoading = false;
      //   return null;
      // }
    } else {
      state = LoginState.noError();
      return {};
    }
  }

  checkEmail(String? val, bool emailEmpty, String emailError) async {
    String? msg = loginEmail(val);
    emailEmpty = msg != null;
    // if (emailEmpty) {
    //   state = state.copyWith(email: state.email.copyWith(isEmpty: true));
    // }
    emailError = msg ?? "";
    log("CHECK EMAIL2 : $emailEmpty");
    log("CHECK EMAIL2 : $emailError");
    // log("CHECK EMAIL2 : ${state.maybeWhen(emailEmpty: () => true, orElse: () => false)}");

    // state =
    //     state.copyWith(email: state.email.copyWith(errorMessage: emailError));
  }

  checkPassword(String? val, bool passwordEmpty, String passwordError) {
    String? msg = registerPassword(val);
    passwordEmpty = msg != null;
    passwordError = msg ?? "";
  }

  changeVisiblePassword(bool val) {
    state = state.copyWith(visiblePassword: true);
  }

  void mapEventsToState(LoginEvent loginEvent) async {
    loginEvent.map(checkEmail: (checkEmail) {
      String? msg = loginEmail(checkEmail.val);
      bool emailEmpty = msg != null;
      if (emailEmpty) {
        state = state.copyWith(email: state.email.copyWith(isEmpty: true));
      }
      String emailError = msg ?? "";
      log("CHECK EMAIL2 : $emailEmpty");
      log("CHECK EMAIL2 : $emailError");
      // log("CHECK EMAIL2 : ${state.maybeWhen(emailEmpty: () => true, orElse: () => false)}");

      state =
          state.copyWith(email: state.email.copyWith(errorMessage: emailError));
    });
  }
}
