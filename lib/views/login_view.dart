import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/login_state.dart';
import '../services/login_service.dart';
import '../providers/login_provider.dart';
import '../libraries/decoration.dart';
import '../libraries/loading.dart';
import '../libraries/textstyle.dart';
import '../libraries/validator.dart';

final loginProvider =
    StateNotifierProvider<LoginProvider, LoginState>((ref) => LoginProvider());

class LoginView extends StatefulWidget {
  const LoginView({
    super.key,
    this.isLoading = false,
    this.emailEmpty = false,
    this.passwordEmpty = false,
    this.visiblePassword = false,
    required this.login,
    required this.checkEmail,
    required this.checkPassword,
    required this.changeVisiblePassword,
    this.emailError = "",
    this.passwordError = "",
    this.username = "",
    this.password = "",
  });
  final bool isLoading, emailEmpty, passwordEmpty, visiblePassword;
  final String emailError, passwordError, username, password;
  final Function(String) login;
  final Function(bool) changeVisiblePassword;
  final Function(String, bool, String) checkEmail, checkPassword;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginService loginService = LoginService();
  late LoginProvider lp;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController emailC = TextEditingController(),
      passwordC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {},
          child: SingleChildScrollView(
            child: Form(
              key: loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ...text(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              // padding: const EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                emailTitle(),
                                emailField(widget.isLoading, widget.username,
                                    widget.emailEmpty, widget.emailError),
                                emailErrorText(
                                    widget.emailEmpty, widget.emailError),
                                passwordTitle(),
                                passwordField(
                                    widget.isLoading,
                                    widget.visiblePassword,
                                    widget.password,
                                    widget.passwordEmpty,
                                    widget.passwordError),
                                passwordErrorText(
                                    widget.passwordEmpty, widget.passwordError),
                                widget.isLoading
                                    ? loadingWidget
                                    : ElevatedButton(
                                        style: ButtonStyle(
                                            overlayColor:
                                                MaterialStateProperty.resolveWith(
                                                    (states) =>
                                                        states.contains(MaterialState.pressed)
                                                            ? Colors.blueGrey
                                                            : null),
                                            shadowColor:
                                                MaterialStateProperty.all<Color>(
                                                    Colors.transparent),
                                            fixedSize: MaterialStateProperty.all(Size(
                                                MediaQuery.of(navigatorKey.currentState!.context)
                                                    .size
                                                    .width,
                                                40)),
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors.blue)),
                                        onPressed: () async {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          // log("EMAIL ${widget.emailEmpty}");
                                          // log("PASSWORD ${widget.passwordEmpty}");
                                          // widget.checkEmail(
                                          //     emailC.text,
                                          //     widget.emailEmpty,
                                          //     widget.emailError);
                                          // log("EMAIL ${widget.emailEmpty}");
                                          // log("PASSWORD ${widget.passwordEmpty}");
                                          bool validate = loginFormKey
                                              .currentState!
                                              .validate();
                                          // setState(() {});
                                          if (validate) {
                                            // log("LOGIN :${state.whenOrNull(loading: () => true)}");
                                            // state = const LoginState.loading();

                                            // model.changeLoading();
                                            // log("LOGIN :${state.whenOrNull(loading: () => true)}");
                                            Map<String, dynamic> result =
                                                await widget.login(
                                              emailC.text);
                                              setState(() {
                                                
                                              });
                                            log("LOGIN RESULT : $result");
                                            if (result.isNotEmpty &&result['status']['kode'] ==
                                                'success') {
                                              emailC.text = "";
                                              passwordC.text = "";
                                              prefs.setString('token',
                                                  result['access_token']);
                                              await routes.welcomeView();
                                            } else {
                                              emailC.text = "";
                                              passwordC.text = "";
                                            }
                                            // state = const LoginState.noError();
                                          }
                                        },
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                widget.isLoading
                                    ? const SizedBox()
                                    : const Flexible(
                                        child: SizedBox(height: 2)),
                                widget.isLoading
                                    ? const SizedBox()
                                    : const Flexible(
                                        child: SizedBox(height: 16)),
                                registerButton(),
                                // loading(widget.isLoading),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> loadingList = [CircularProgressIndicator()];

  Widget loading(bool isLoading) => Visibility(
      visible: isLoading, child: SizedBox(height: 124, child: loadingWidget));

  List<Widget> text() {
    return [
      const Padding(
          padding: EdgeInsets.only(top: 48),
          child: Text('Login Page',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700))),
      const Text('Login dulu disini',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      // const SizedBox(height: 16),
    ];
  }

  emailTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 24),
      child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  emailField(
      bool isLoading, String emailValue, bool emailEmpty, String emailError) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        enabled: !isLoading,
        controller: emailC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          widget.checkEmail(val!, emailEmpty, emailError);
          return null;
        },
        onChanged: (val) {
          emailValue = val;
          widget.checkEmail(val, emailEmpty, emailError);
          // setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: generalDecoration('Masukkan Email', emailEmpty),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  emailErrorText(bool emailEmpty, String emailError) {
    return Text(emailEmpty ? emailError : "",
        style: redValidateErrorRequired());
  }

  passwordTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          const Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('*', style: redRequired())
        ],
      ),
    );
  }

  passwordField(bool isLoading, bool visiblePassword, String passwordValue,
      bool passwordEmpty, String passwordError) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextFormField(
        enabled: !widget.isLoading,
        obscureText: visiblePassword,
        controller: passwordC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          widget.checkPassword(val!, passwordEmpty, passwordError);
          return null;
        },
        onChanged: (val) {
          passwordValue = val;
          widget.checkPassword(val, passwordEmpty, passwordError);
          // setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () => widget.changeVisiblePassword,
                icon: Icon(visiblePassword
                    ? Icons.visibility_off
                    : Icons.remove_red_eye),
                color: visiblePassword ? Colors.grey : Colors.blue),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              borderSide:
                  BorderSide(color: passwordEmpty ? Colors.red : Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              borderSide:
                  BorderSide(color: passwordEmpty ? Colors.red : Colors.grey),
            ),
            contentPadding: const EdgeInsets.all(10),
            alignLabelWithHint: true,
            hintText: 'Masukkan Password'),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  passwordErrorText(bool passwordEmpty, String passwordError) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(passwordEmpty ? passwordError : "",
          style: redValidateErrorRequired()),
    );
  }

  Widget forgotPassButton() {
    return widget.isLoading
        ? const SizedBox()
        : InkWell(
            onTap: () => null,
            // onTap: () => routes.pembayaranView(context),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Forgot Password",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
  }

  Widget registerButton() {
    return widget.isLoading
        ? const SizedBox()
        : InkWell(
            // onTap: () => null,
            onTap: () => routes.registerView(),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Belum Punya Akun ? Daftar di sini",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
  }
}
