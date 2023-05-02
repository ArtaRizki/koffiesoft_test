import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koffiesoft_test/providers/register_provider.dart';
import 'package:provider/provider.dart';
import '../consts/url.dart';
import '../libraries/dio_client.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class RegisterService {
  static final DioClient dio = DioClient();

  Future<Map<String, dynamic>> registerUser(BuildContext context) async {
    final up = Provider.of<UserProvider>(context, listen: false);
    final rp = Provider.of<RegisterProvider>(context, listen: false);
    rp.isLoading = true;

    if (!rp.emailEmpty &&
        !rp.noHpEmpty &&
        !rp.firstnameEmpty &&
        !rp.lastnameEmpty &&
        !rp.reTypePasswordEmpty) {
      try {
        d.Response<dynamic>? response = await dio.requestPost(
          registerUserPath,
          {
            "email": rp.emailValue,
            "hp": rp.noHpValue,
            "firstname": rp.firstnameValue,
            "lastname": rp.lastnameValue,
            "grup": "member",
            "role": "",
            "tgl_lahir": rp.tglLahir,
            "jenis_kelamin": rp.jenisKelamin,
            "password": rp.passwordValue,
            "strict_password": false,
            "referral_code": "",
          },
          onSendProgress: null,
          onReceiveProgress: null,
          isJson: true,
          options: d.Options(
            contentType: d.Headers.jsonContentType,
            responseType: d.ResponseType.json,
          ),
        );
        Map<String, dynamic> result = response!.data;
        if (result['status']['kode'] == 'success') {
          rp.emailValue = "";
          rp.noHpValue = "";
          rp.firstnameValue = "";
          rp.lastnameValue = "";
          rp.tglLahir = "";
          rp.passwordValue = "";
          rp.reTypePasswordValue = "";
          log("REGISTER RESULT : ${jsonEncode(result['data'])}");
          Fluttertoast.showToast(msg: "Register Sukses");
          rp.isLoading = false;
          log("REGISTER RESULT 2 : ${jsonEncode(result)}");
          return result;
        } else {
          Fluttertoast.showToast(
              msg: jsonEncode(result['status']['keterangan']));
          rp.isLoading = false;
          return {};
        }
      } catch (e) {
        rp.isLoading = false;
        return {};
      }
    } else {
      rp.isLoading = false;
      return {};
    }
  }

  Future<Map<String, dynamic>> sendOtp(BuildContext context,
      {required String emailHp}) async {
    // try {
    d.Response<dynamic>? response = await dio.requestPost(
      senderOTP,
      {
        "credential": emailHp,
        "tujuan": "sms",
        "zona_waktu": "Asia/Jakarta",
        "show_sms_result": false
      },
      onSendProgress: null,
      onReceiveProgress: null,
      isJson: true,
      options: d.Options(
        contentType: d.Headers.jsonContentType,
        responseType: d.ResponseType.json,
      ),
    );
    log("RESPONSE SENDOTP : $response");
    Map<String, dynamic> result = response!.data;
    if (result['status']['kode'] == 'success') {
      log("SEND OTP RESULT : ${jsonEncode(result['data'])}");
      Fluttertoast.showToast(msg: "Cek email untuk verifikasi OTP");
      log("SEND OTP RESULT 2 : ${jsonEncode(result)}");
      return result;
    } else {
      Fluttertoast.showToast(msg: jsonEncode(result['status']['keterangan']));
      return {};
    }
  }

  Future<Map<String, dynamic>> verifyOtp(BuildContext context,
      {required String emailHp, required String otp}) async {
    // try {
    d.Response<dynamic>? response = await dio.requestPost(
      verifierOTP,
      {"credential": emailHp, "otp": otp},
      onSendProgress: null,
      onReceiveProgress: null,
      isJson: true,
      options: d.Options(
        contentType: d.Headers.jsonContentType,
        responseType: d.ResponseType.json,
      ),
    );
    Map<String, dynamic> result = response!.data;
    if (result['status']['kode'] == 'success') {
      log("VERIFY OTP RESULT : ${jsonEncode(result['data'])}");
      Fluttertoast.showToast(msg: "Sukses verifikasi OTP");
      log("VERIFY OTP RESULT 2 : ${jsonEncode(result)}");
      return result;
    } else {
      Fluttertoast.showToast(msg: jsonEncode(result['status']['keterangan']));
      return {};
    }
  }
}
