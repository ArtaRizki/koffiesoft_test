import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
                            // isLoading = true;
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

Future<void> successWindow(
    BuildContext context, String txt, Function()? nextStep) async {
  txt = txt == "Telepon" ? "Nomor Telepon" : "Email";
  await showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => AlertDialog(
            content: SizedBox(
              width: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.only(bottom: 24, top: 32),
                    width: 80,
                    height: 80,
                    child: FittedBox(
                        child: Image.asset('assets/images/check-circle.png',
                            width: 80, height: 80)),
                  ),
                  const SizedBox(height: 24),
                  Text("Verifikasi $txt Sukses", style: inter22BoldGreen()),
                  const SizedBox(height: 16),
                  Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(txt.contains("Email")
                          ? "Setelah ini silahkan lengkapi data resto Anda"
                          : "Setelah ini silahkan lakukan verifikasi email proses ini bisa Anda lewati"),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    padding: const EdgeInsets.only(bottom: 18),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.blue,
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6))),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          if (nextStep != null) {
                            nextStep();
                          }
                        },
                        child: Text('Lanjut', style: inter18Medium())),
                  ),
                ],
              ),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            actionsPadding: const EdgeInsets.only(right: 10, bottom: 5),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
      barrierDismissible: true);
}

// void showSearchSheet(String title, List<SelectedListItem> _listItem,
//     Function(List<dynamic> selectedList) onSelected) {
//   DropDownState(DropDown(
//     title: title,
//     bottomSheetTitle: Text(title, style: inter28Bold()),
//     data: _listItem,
//     selectedItems: onSelected,
//     enableMultipleSelection: false,
//   )).showModal(navigatorKey.currentContext);
// }

// void showSheet(String title, List<SelectedListItem> _listItem,
//     Function(List<dynamic> selectedList) onSelected,
//     {List<String>? iconList, List<bool>? enabled}) {
//   DropDownState(DropDown(
//     isSearchVisible: false,
//     title: title,
//     bottomSheetTitle: Text(
//       title,
//       style: inter28Bold(),
//       overflow: TextOverflow.ellipsis,
//       maxLines: 1,
//     ),
//     data: _listItem,
//     selectedItems: onSelected,
//     enableMultipleSelection: false,
//     iconList: iconList,
//     enabledList: enabled,
//   )).showModal(navigatorKey.currentContext);
// }

// categoryDialog(
//         {required String title,
//         required String itemName,
//         required String imagePath,
//         required String buttonName,
//         required Function? onTap}) =>
//     showGeneralDialog(
//       barrierLabel: "Label",
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.5),
//       context: navigatorKey.currentContext!,
//       pageBuilder: (context, anim1, anim2) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.all(12),
//           insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.close),
//                 ),
//               ),
//               Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(image: AssetImage(imagePath))),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
//                 child: Column(
//                   children: [
//                     Text(
//                       title,
//                       style: inter12GrayMedium(),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       " $itemName ?",
//                       style: inter12BlackBold(),
//                       maxLines: null,
//                       softWrap: true,
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 4.0),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.white,
//                               fixedSize:
//                                   Size(MediaQuery.of(context).size.width, 40),
//                               primary: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                   side: BorderSide(color: green5),
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: () => Navigator.pop(context),
//                           child: Text('Batal', style: inter16Medium())),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 4.0),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.transparent,
//                               fixedSize:
//                                   Size(MediaQuery.of(context).size.width, 40),
//                               primary: green5,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: () {
//                             onTap!();
//                             Navigator.pop(context);
//                           },
//                           child: Text(buttonName, style: inter16Medium())),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//             ],
//           ),
//         );
//       },
//     );

// paketDialog(
//         {required String title,
//         required String itemName,
//         required String imagePath,
//         required String buttonName,
//         required Function? onTap}) =>
//     showGeneralDialog(
//       barrierLabel: "Label",
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.5),
//       context: navigatorKey.currentContext!,
//       pageBuilder: (context, anim1, anim2) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.all(12),
//           insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.close),
//                 ),
//               ),
//               Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(image: AssetImage(imagePath))),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
//                 child: Column(
//                   children: [
//                     Text(
//                       title,
//                       style: inter12GrayMedium(),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       " $itemName ?",
//                       style: inter12BlackBold(),
//                       maxLines: null,
//                       softWrap: true,
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 4.0),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.white,
//                               fixedSize:
//                                   Size(MediaQuery.of(context).size.width, 40),
//                               primary: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                   side: BorderSide(color: green5),
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: () => Navigator.pop(context),
//                           child: Text('Batal', style: inter16Medium())),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 4.0),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.transparent,
//                               fixedSize:
//                                   Size(MediaQuery.of(context).size.width, 40),
//                               primary: green5,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: () {
//                             onTap!();
//                             Navigator.pop(context);
//                           },
//                           child: Text(buttonName, style: inter16Medium())),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//             ],
//           ),
//         );
//       },
//     );

// tagihanDialog(
//         {required String title,
//         required String itemName,
//         required String imagePath,
//         required String buttonName,
//         required Function? onTap}) =>
//     showGeneralDialog(
//       barrierLabel: "Label",
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.5),
//       context: navigatorKey.currentContext!,
//       pageBuilder: (context, anim1, anim2) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.all(12),
//           insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.close),
//                 ),
//               ),
//               Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(image: AssetImage(imagePath))),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
//                 child: Column(
//                   children: [
//                     Text(
//                       title,
//                       style: inter12GrayMedium(),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       " $itemName ?",
//                       style: inter12BlackBold(),
//                       maxLines: null,
//                       softWrap: true,
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 4.0),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.white,
//                               fixedSize:
//                                   Size(MediaQuery.of(context).size.width, 40),
//                               primary: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                   side: BorderSide(color: green5),
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: () => Navigator.pop(context),
//                           child: Text('Batal', style: inter16Medium())),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 4.0),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.transparent,
//                               fixedSize:
//                                   Size(MediaQuery.of(context).size.width, 40),
//                               primary: green5,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: () {
//                             onTap!();
//                             Navigator.pop(context);
//                           },
//                           child: Text(buttonName, style: inter16Medium())),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//             ],
//           ),
//         );
//       },
//     );

// void transferDialog(
//         {required String title,
//         required String itemName,
//         required String imagePath,
//         required String buttonName,
//         required Function? onTap}) =>
//     showGeneralDialog(
//       barrierLabel: "Label",
//       barrierDismissible: false,
//       barrierColor: Colors.black.withOpacity(0.5),
//       context: navigatorKey.currentContext!,
//       pageBuilder: (context, anim1, anim2) {
//         return AlertDialog(
//           contentPadding: const EdgeInsets.all(12),
//           insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: const Icon(Icons.close),
//                 ),
//               ),
//               Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(image: AssetImage(imagePath))),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
//                 child: Column(
//                   children: [
//                     Text(
//                       title,
//                       style: inter14Medium(),
//                       textAlign: TextAlign.center,
//                     ),
//                     Text(
//                       " $itemName ?",
//                       style: inter14Medium(),
//                       maxLines: null,
//                       softWrap: true,
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 4.0),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.white,
//                               fixedSize:
//                                   Size(MediaQuery.of(context).size.width, 40),
//                               primary: Colors.white,
//                               shape: RoundedRectangleBorder(
//                                   side: BorderSide(color: green5),
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: () => Navigator.pop(context),
//                           child: Text('Batal', style: inter16Medium())),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 4.0),
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               shadowColor: Colors.transparent,
//                               fixedSize:
//                                   Size(MediaQuery.of(context).size.width, 40),
//                               primary: green5,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6))),
//                           onPressed: () => onTap!(),
//                           child: Text(buttonName, style: inter16Medium())),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//             ],
//           ),
//         );
//       },
//     );

// void transferProgressDialog(
//   BuildContext context, {
//   required String title,
//   required int number,
//   required int total,
// }) {
//   Navigator.pop(context);
//   showGeneralDialog(
//     barrierLabel: "Label",
//     barrierDismissible: false,
//     barrierColor: Colors.black.withOpacity(0.5),
//     context: navigatorKey.currentContext!,
//     transitionDuration: Duration.zero,
//     pageBuilder: (context, anim1, anim2) {
//       return AlertDialog(
//         contentPadding: const EdgeInsets.all(12),
//         insetPadding: const EdgeInsets.symmetric(horizontal: 16),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text("Transfer Data", style: inter14Bold()),
//             Container(
//               margin: const EdgeInsets.only(top: 9, bottom: 16),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   color: const Color(0xff88D8CA),
//                   borderRadius: BorderRadius.circular(40)),
//               height: 12,
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     flex: (number / total).round(),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(40),
//                           color: Colors.blue),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 13),
//                         child: Text("${(number / total).round() * 100}%",
//                             style: inter10Normal()),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                       flex: 10 - ((number / total).round()),
//                       child: const SizedBox())
//                 ],
//               ),
//             ),
//             const SizedBox(height: 4),
//           ],
//         ),
//       );
//     },
//   );
// }
    

// // void showClearDialogPackaging(indexVariasi) {
// //   showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: Text(
// //             'Confirmation',
// //             textScaleFactor: 1.0,
// //           ),
// //           content: Container(
// //             child: Text(
// //               "Apakah Anda yakin ingin menghapus barang ini dari keranjang belanja?",
// //               textScaleFactor: 1.0,
// //             ),
// //           ),
// //           actions: <Widget>[
// //             FlatButton(
// //               onPressed: () async {
// //                 Get.back();
// //                 _setQtyPackaging(indexVariasi, "0");
// //               },
// //               child: Text(
// //                 'Ya',
// //                 textScaleFactor: 1.0,
// //                 style: TextStyle(color: Colors.black),
// //               ),
// //             ),
// //             FlatButton(
// //               onPressed: () async {
// //                 Get.back();
// //               },
// //               child: Text('Tidak',
// //                   textScaleFactor: 1.0, style: TextStyle(color: Colors.black)),
// //             )
// //           ],
// //         );
// //       });
