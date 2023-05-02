import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koffiesoft_test/libraries/decoration.dart';
import 'package:koffiesoft_test/services/register_service.dart';
import 'package:provider/provider.dart';

import '../libraries/convert_date.dart';
import '../libraries/dialog.dart';
import '../libraries/loading.dart';
import '../libraries/textstyle.dart';
import '../libraries/validator.dart';
import '../main.dart';
import '../plugins/scroll_date_picker/src/scroll_date_picker.dart';
import '../providers/register_provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  DateTime _selectedTglLahir = DateTime.now();
  DraggableScrollableController dragC = DraggableScrollableController();
  late RegisterProvider rp;
  RegisterService registerService = RegisterService();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  TextEditingController firstnameC = TextEditingController(),
      lastnameC = TextEditingController(),
      emailC = TextEditingController(),
      noHpC = TextEditingController(),
      passwordC = TextEditingController(),
      tanggalLahirC = TextEditingController(),
      reTypePasswordC = TextEditingController();

  @override
  void initState() {
    rp = Provider.of<RegisterProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    return Consumer<RegisterProvider>(
      builder: (context, rv, child) => Scaffold(
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
                child: Form(
                  key: registerFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rv.isLoading
                        ? [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: loadingWidget)
                          ]
                        : fieldWidgets(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> fieldWidgets() => [
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text("Daftar",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        const SizedBox(height: 16),
        firstnameTitle(),
        firstnameField(),
        firstnameErrorText(),
        lastnameTitle(),
        lastnameField(),
        lastnameErrorText(),
        emailTitle(),
        emailField(),
        emailErrorText(),
        noHpTitle(),
        noHpField(),
        noHpErrorText(),
        tanggalLahirTitle(),
        tanggalLahirField(),
        tanggalLahirErrorText(),
        passwordTitle(),
        passwordField(),
        passwordErrorText(),
        reTypePasswordTitle(),
        reTypePasswordField(),
        reTypePasswordErrorText(),
        registerButton()
      ];

  firstnameTitle() {
    return Row(
      children: [
        Text('Firstname', style: inter14Medium()),
        Text('*', style: redRequired())
      ],
    );
  }

  lastnameTitle() {
    return Row(
      children: [
        Text('Lastname', style: inter14Medium()),
        Text('*', style: redRequired())
      ],
    );
  }

  tanggalLahirTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text('Tanggal Lahir', style: inter14Medium()),
          Text('*', style: redRequired())
        ],
      ),
    );
  }

  firstnameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: firstnameC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkFirstname(val);
          return null;
        },
        onChanged: (val) {
          rp.firstnameValue = val;
          checkFirstname(val);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: generalDecoration("Masukkan Firstname", rp.firstnameEmpty),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  lastnameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: lastnameC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkLastname(val);
          return null;
        },
        onChanged: (val) {
          rp.lastnameValue = val;
          checkLastname(val);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: generalDecoration("Masukkan Lastname", rp.lastnameEmpty),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  tanggalLahirField() {
    return InkWell(
      onTap: () => calendarSheet(),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextFormField(
              enabled: false,
              controller: tanggalLahirC,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (val) {
                checkTanggalLahir(val);
                return null;
              },
              onChanged: (val) {
                // mp.tanggalBerlakuValue = val;
                checkTanggalLahir(rp.tglLahir);
                setState(() {});
              },
              style: inter12(),
              decoration: generalDecoration(
                  "Masukkan Tanggal Lahir", rp.tglLahirEmpty))),
    );
  }

  emailTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text('Email', style: inter14Medium()),
          Text('*', style: redRequired())
        ],
      ),
    );
  }

  emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: emailC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkEmail(val);
          return null;
        },
        onChanged: (val) {
          rp.emailValue = val;
          checkEmail(val);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: generalDecoration('Masukkan Email', rp.emailEmpty),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  noHpTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text('No HP/WA', style: inter14Medium()),
          Text('*', style: redRequired())
        ],
      ),
    );
  }

  noHpField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: noHpC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkNoHpWa(val);
          return null;
        },
        onChanged: (val) {
          rp.noHpValue = val;
          checkNoHpWa(val);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: generalDecoration('Masukkan No HP', rp.noHpEmpty),
        keyboardType: TextInputType.number,
        scrollPadding: const EdgeInsets.only(bottom: 52),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ],
      ),
    );
  }

  passwordTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text('Password', style: inter14Medium()),
          Text('*', style: redRequired())
        ],
      ),
    );
  }

  passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: rp.visiblePassword,
        controller: passwordC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkPassword(val);
          return null;
        },
        onChanged: (val) {
          rp.passwordValue = val;
          checkPassword(val);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        inputFormatters: [
          // FilteringTextInputFormatter.allow(RegExp(r"^(?=.*?[0-9]).{8,}$"))
        ],
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () => rp.changePasswordEye(),
                icon: Icon(rp.visiblePassword
                    ? Icons.visibility_off
                    : Icons.remove_red_eye),
                color: rp.visiblePassword ? Colors.grey : Colors.blue),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                  color: rp.passwordEmpty ? Colors.red : Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                  color: rp.passwordEmpty ? Colors.red : Colors.grey),
            ),
            contentPadding: const EdgeInsets.all(10),
            alignLabelWithHint: true,
            hintText: 'Masukkan Password'),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  reTypePasswordTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Text('Retype Password', style: inter14Medium()),
          Text('*', style: redRequired())
        ],
      ),
    );
  }

  reTypePasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: rp.visibleRetypePassword,
        controller: reTypePasswordC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkReTypePassword(val, rp.passwordValue, false);
          return null;
        },
        onChanged: (val) {
          rp.reTypePasswordValue = val;
          checkReTypePassword(val, rp.passwordValue, false);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () => rp.changeReTypePasswordEye(),
                icon: Icon(rp.visibleRetypePassword
                    ? Icons.visibility_off
                    : Icons.remove_red_eye),
                color: rp.visibleRetypePassword ? Colors.grey : Colors.blue),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                  color: rp.reTypePasswordEmpty ? Colors.red : Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                  color: rp.reTypePasswordEmpty ? Colors.red : Colors.grey),
            ),
            contentPadding: const EdgeInsets.all(10),
            alignLabelWithHint: true,
            hintText: 'Masukkan Password'),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  firstnameErrorText() {
    return Text(rp.firstnameEmpty ? rp.firstnameError : "",
        style: redValidateErrorRequired());
  }

  lastnameErrorText() {
    return Text(rp.lastnameEmpty ? rp.lastnameError : "",
        style: redValidateErrorRequired());
  }

  emailErrorText() {
    return Text(rp.emailEmpty ? rp.emailError : "",
        style: redValidateErrorRequired());
  }

  noHpErrorText() {
    return Text(rp.noHpEmpty ? rp.noHpError : "",
        style: redValidateErrorRequired());
  }

  passwordErrorText() {
    return Text(rp.passwordEmpty ? rp.passwordError : "",
        style: redValidateErrorRequired());
  }

  reTypePasswordErrorText() {
    return Text(rp.reTypePasswordEmpty ? rp.reTypePasswordError : "",
        style: redValidateErrorRequired());
  }

  tanggalLahirErrorText() {
    return Text(rp.tglLahirEmpty ? rp.tglLahirError : "",
        style: redValidateErrorRequired());
  }

  checkFirstname(String? val) {
    String? msg = registerFirstname(val);
    rp.firstnameEmpty = msg != null;
    rp.firstnameError = msg ?? "";
  }

  checkLastname(String? val) {
    String? msg = registerLastname(val);
    rp.lastnameEmpty = msg != null;
    rp.lastnameError = msg ?? "";
  }

  checkEmail(String? val) {
    String? msg = registerEmail(val);
    rp.emailEmpty = msg != null;
    rp.emailError = msg ?? "";
  }

  checkNoHpWa(String? val) {
    String? msg = registerNoHpWa(val);
    rp.noHpEmpty = msg != null;
    rp.noHpError = msg ?? "";
  }

  checkPassword(String? val) {
    String? msg = registerPassword(val);
    rp.passwordEmpty = msg != null;
    rp.passwordError = msg ?? "";
  }

  checkReTypePassword(String? val, String? val2, bool isSubmitted) {
    String? msg = registerReTypePassword(val, val2, isSubmitted);
    rp.reTypePasswordEmpty = msg != null;
    rp.reTypePasswordError = msg ?? "";
  }

  checkTanggalLahir(String? val) {
    // mp.tanggalBerlakuValue = val ?? "";
    log("TANGGAL LAHIR : $val");
    String? msg = menuTanggalLahir(val);
    rp.tglLahirEmpty = msg != null;
    rp.tglLahirError = msg ?? "";
  }

  registerButton() {
    if (rp.isLoading) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
            child: SizedBox(width: 40, height: 40, child: loadingWidget)),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: ElevatedButton(
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.pressed)
                    ? Colors.blueGrey
                    : null),
            fixedSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 40)),
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
        onPressed: () async {
          rp.isLoading = true;
          FocusManager.instance.primaryFocus?.unfocus();
          log("RETYPE : ${rp.reTypePasswordValue}");
          log("PASSWORD : ${rp.passwordValue}");
          registerFormKey.currentState!.validate();
          checkReTypePassword(rp.reTypePasswordValue, rp.passwordValue, true);
          Map<String, dynamic> result =
              await registerService.registerUser(context);
          // await otpWindow(context, emailHp: emailC.text);
          // log("LOGIN RESULT : $result");
          if (result['status']['kode'] == 'success') {
            firstnameC.text = "";
            lastnameC.text = "";
            tanggalLahirC.text = "";
            passwordC.text = "";
            reTypePasswordC.text = "";
            await routes.loginView();
          } else {}
          rp.isLoading = false;
        },
        child: const Text("Daftar"),
      ),
    );
  }

  void calendarSheet() {
    Future.delayed(
        const Duration(milliseconds: 100),
        () => showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            ),
            context: context,
            builder: (context) {
              return DraggableScrollableSheet(
                controller: dragC,
                // initialChildSize: iconItems != null && (0.109 * iconItems!.length) < 1
                //     ? 0.109 * iconItems!.length
                //     : 0.96,
                initialChildSize: 0.5,
                minChildSize: kBottomNavigationBarHeight / 500,
                maxChildSize: 0.96,
                expand: false,
                snap: true,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return StatefulBuilder(builder: (context, setState) {
                    return Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration:
                              const BoxDecoration(boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Color.fromARGB(30, 0, 0, 0),
                              offset: Offset(4, 4),
                              blurRadius: 8,
                              spreadRadius: 4,
                            )
                          ], color: Color(0xfff8faf7)),
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  color: Colors.black,
                                  width: 100,
                                  height: 4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15.0,
                                    top: 10.0,
                                    bottom: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /// Bottom sheet title text
                                    Expanded(
                                        child: Text("Tanggal Lahir",
                                            style: inter28Bold())),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          Navigator.of(context).pop(null);
                                        },
                                        child: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Listview (list of data with check box for multiple selection & on tile tap single selection)
                        Expanded(
                          child: SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: ScrollDatePicker(
                              selectedDate: _selectedTglLahir,
                              minimumDate: DateTime(1945, 1, 1),
                              maximumDate: DateTime(2099, 12, 31),
                              locale: const Locale('id'),
                              onDateTimeChanged: (DateTime value) {
                                log("DATE : $value");
                                log("DATE 2 : ${DateTime.now()}");
                                setState(() => _selectedTglLahir = value);
                                checkTanggalLahir(_selectedTglLahir.toString());
                                rp.tglLahir =
                                    convertTglInggris(value.toString());
                                log("DATE 3 : ${convertTglInggris(value.toString())}");
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                        pilihButton(),
                      ],
                    );
                  });
                },
              );
            }));
  }

  Widget pilihButton() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(30, 8, 30, 16),
      child: ElevatedButton(
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
            fixedSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width, 40)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
            backgroundColor: MaterialStateProperty.all(Colors.blue)),
        onPressed: () async {
          // _selectedTglLahir = _selectedTglLahir;
          log("SELECTED DATE : $_selectedTglLahir");
          rp.tglLahir = _selectedTglLahir.toString();
          checkTanggalLahir(_selectedTglLahir.toString());
          setState(() {});

          tanggalLahirC.text = convertTglIndo(_selectedTglLahir.toString());
          setState(() {});
          Navigator.pop(context, null);
        },
        child: const Text(
          'Pilih',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
