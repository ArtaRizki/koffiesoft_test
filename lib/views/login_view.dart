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

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  LoginService loginService = LoginService();
  late LoginProvider lp;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  TextEditingController emailC = TextEditingController(),
      passwordC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final LoginState state = context.watch<LoginState>();

    final isLoading = state.maybeWhen(loading: () => true, orElse: () => false);
    final bool emailEmpty =
            state.maybeWhen(loading: () => true, orElse: () => false),
        passwordEmpty =
            state.maybeWhen(passwordEmpty: () => true, orElse: () => false),
        visiblePassword =
            state.maybeWhen(visiblePassword: () => true, orElse: () => false);
    final String emailError = state.maybeWhen(
        emailError: (emailError) => emailError, orElse: () => "");
    final String passwordError = state.maybeWhen(
        passwordError: (passwordError) => passwordError, orElse: () => "");
    final String username = state.maybeWhen(
        emailValue: (emailValue) => emailValue, orElse: () => "");
    final String password = state.maybeWhen(
        passwordValue: (passwordValue) => passwordValue, orElse: () => "");

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
                                emailField(isLoading, username, emailEmpty,
                                    emailError),
                                emailErrorText(emailEmpty, emailError),
                                passwordTitle(),
                                passwordField(
                                    isLoading,
                                    visiblePassword,
                                    password,
                                    state,
                                    passwordEmpty,
                                    passwordError),
                                passwordErrorText(passwordEmpty, passwordError),
                                loginButton(
                                    isLoading, emailEmpty, passwordEmpty),
                                isLoading
                                    ? const SizedBox()
                                    : const Flexible(
                                        child: SizedBox(height: 2)),
                                isLoading
                                    ? const SizedBox()
                                    : const Flexible(
                                        child: SizedBox(height: 16)),
                                registerButton(isLoading),
                                loading(isLoading),
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
          checkEmail(val, emailEmpty, emailError);
          return null;
        },
        onChanged: (val) {
          emailValue = val;
          checkEmail(val, emailEmpty, emailError);
          setState(() {});
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
      LoginState state, bool passwordEmpty, String passwordError) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextFormField(
        enabled: !isLoading,
        obscureText: visiblePassword,
        controller: passwordC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkPassword(val, passwordEmpty, passwordError);
          return null;
        },
        onChanged: (val) {
          passwordValue = val;
          checkPassword(val, passwordEmpty, passwordError);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () => state = const LoginState.visiblePassword(),
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

  Widget loginButton(bool isLoading, bool emailEmpty, bool passwordEmpty) {
    return isLoading
        ? const SizedBox()
        : ElevatedButton(
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.resolveWith((states) =>
                    states.contains(MaterialState.pressed)
                        ? Colors.blueGrey
                        : null),
                shadowColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                fixedSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 40)),
                backgroundColor: MaterialStateProperty.all(Colors.blue)),
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              bool validate = loginFormKey.currentState!.validate();
              setState(() {});
              if (validate && !emailEmpty && !passwordEmpty) {
                isLoading = true;
                Map<String, dynamic> result =
                    await ref.read(loginProvider.notifier).loginUser(context);
                log("LOGIN RESULT : $result");
                if (result['status']['kode'] == 'success') {
                  emailC.text = "";
                  passwordC.text = "";
                  prefs.setString('token', result['access_token']);
                  await routes.welcomeView();
                } else {
                  emailC.text = "";
                  passwordC.text = "";
                }
                isLoading = false;
              }
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
  }

  Widget forgotPassButton(bool isLoading) {
    return isLoading
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

  Widget registerButton(bool isLoading) {
    return isLoading
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

  checkEmail(String? val, bool emailEmpty, String emailError) {
    String? msg = loginEmail(val);
    emailEmpty = msg != null;
    emailError = msg ?? "";
  }

  checkPassword(String? val, bool passwordEmpty, String passwordError) {
    String? msg = registerPassword(val);
    passwordEmpty = msg != null;
    passwordError = msg ?? "";
  }
}
