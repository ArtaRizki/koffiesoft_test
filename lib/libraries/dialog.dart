import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:koffiesoft_test/main.dart';
import 'package:koffiesoft_test/services/register_service.dart';
import '../providers/register_provider.dart';
import 'color.dart';
import 'textstyle.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

Future<void> otpWindow(
  BuildContext context, {
  Function()? nextStep,
  required String emailHp,
}) async {
  final rp = Provider.of<RegisterProvider>(context, listen: false);
  bool otpInvalid = false;
  bool isLoading = false;
  String otp = "";
  RegisterService registerService = RegisterService();
  await showDialog(
      context: context,
      builder: (context) => WillPopScope(
            onWillPop: () async => true,
            child: AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Verifikasi Kode OTP', style: inter22Bold()),
                  InkWell(
                      onTap: () {
                        routes.goBack();
                        routes.loginView();
                      },
                      child: const SizedBox(
                          width: 24, height: 24, child: Icon(Icons.close)))
                ],
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: otpInvalid
                            ? const Text("OTP tidak sesuai",
                                style: TextStyle(color: Colors.red))
                            : const Text("Segera verifikasi akunmu!")),
                    const Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text('Masukkan kode OTP yang telah kami')),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text('kirimkan ke $emailHp')),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 6,
                        onChanged: (val) => otp = val,
                        autoFocus: true,
                        animationType: AnimationType.scale,
                        keyboardType: TextInputType.number,
                        useHapticFeedback: true,
                        hapticFeedbackTypes: HapticFeedbackTypes.selection,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(6),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          borderWidth: 1,
                          activeFillColor: Colors.white,
                          activeColor: Colors.blue,
                          errorBorderColor: Colors.red,
                          selectedColor: Colors.blue,
                          inactiveColor: gray,
                        ),
                        cursorColor: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: InkWell(
                          onTap: () => registerService.sendOtp(context,
                              emailHp: emailHp),
                          child: Text('Resend OTP',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: isLoading ? gray : hyperlinkBlue))),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      padding: const EdgeInsets.only(bottom: 18),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          onPressed: () async {
                            try {
                              isLoading = true;
                              Map<String, dynamic> verifyOtp =
                                  await registerService.verifyOtp(context,
                                      emailHp: emailHp, otp: otp);
                              log('VERIFY OTP : $verifyOtp');
                              if (verifyOtp['status']['kode'] == 'success') {
                                otpInvalid = false;
                                log("SUKSES OTP");
                                Fluttertoast.showToast(
                                    msg: jsonEncode(
                                        verifyOtp['status']['keterangan']));
                                await routes.goBack();
                                await routes.loginView();
                              } else {
                                otpInvalid = true;
                              }
                              isLoading = false;
                            } catch (e) {
                              log("ERROR $e");
                              isLoading = false;
                            }
                          },
                          child: Text('Verifikasi', style: inter18Medium())),
                    ),
                  ],
                ),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              actionsPadding: const EdgeInsets.only(right: 10, bottom: 5),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
      barrierDismissible: true);
}
