import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../consts/url.dart';
import '../libraries/dio_client.dart';
import '../models/user_model.dart';
import '../providers/login_provider.dart';
import '../providers/user_provider.dart';

class LoginService {
  static final DioClient dio = DioClient();

  // Future<Map<String, dynamic>> loginUser(BuildContext context) async {
  //   final up = Provider.of<UserProvider>(context, listen: false);
  //   final lp = Provider.of<LoginProvider>(context, listen: false);
  //   lp.isLoading = true;

  //   if (!lp.emailEmpty && !lp.passwordEmpty) {
  //     // try {
  //     d.Response<dynamic>? response = await dio.requestPost(
  //       loginPath,
  //       // {"Email": "081217240058", "Password": "1234"},
  //       {"username": lp.emailValue, "password": lp.passwordValue},
  //       onSendProgress: null,
  //       onReceiveProgress: null,
  //       options: null,
  //     );
  //     Map<String, dynamic> result = response!.data;
  //     if (result['status']['kode'] == 'success') {
  //       lp.emailValue = "";
  //       lp.passwordValue = "";
  //       log("LOGIN RESULT : ${jsonEncode(result['data'])}");
  //       up.user = userModelFromJson(jsonEncode(result['data']));
  //       log("USER EMAIL : ${up.user.email}");
  //       log("USER ID : ${up.user.id}");
  //       Fluttertoast.showToast(msg: "Login Sukses");
  //       lp.isLoading = false;
  //       log("LOGIN RESULT 2 : ${jsonEncode(result)}");
  //       return result;
  //     } else {
  //       Fluttertoast.showToast(msg: jsonEncode(result['status']['keterangan']));
  //       lp.isLoading = false;
  //       return {};
  //     }
  //     // } catch (e) {
  //     //   lp.isLoading = false;
  //     //   return null;
  //     // }
  //   } else {
  //     lp.isLoading = false;
  //     return {};
  //   }
  // }
}
