import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../services/login_service.dart';
import '../providers/login_provider.dart';
import '../libraries/decoration.dart';
import '../libraries/loading.dart';
import '../libraries/textstyle.dart';
import '../libraries/validator.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginService loginService = LoginService();
  late LoginProvider lp;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    lp = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
  }

  TextEditingController emailC = TextEditingController(),
      passwordC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom == 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    return Consumer<LoginProvider>(
      builder: (context, lv, child) {
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
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1),
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
                                    emailField(),
                                    emailErrorText(),
                                    passwordTitle(),
                                    passwordField(),
                                    passwordErrorText(),
                                    loginButton(),
                                    lp.isLoading
                                        ? const SizedBox()
                                        : const Flexible(
                                            child: SizedBox(height: 2)),
                                    lp.isLoading
                                        ? const SizedBox()
                                        : const Flexible(
                                            child: SizedBox(height: 16)),
                                    registerButton(),
                                    loading(),
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
      },
    );
  }

  Widget loading() => Visibility(
      visible: lp.isLoading,
      child: SizedBox(height: 124, child: loadingWidget));

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

  emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        enabled: !lp.isLoading,
        controller: emailC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkEmail(val);
          return null;
        },
        onChanged: (val) {
          lp.emailValue = val;
          checkEmail(val);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: generalDecoration('Masukkan Email', lp.emailEmpty),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  emailErrorText() {
    return Text(lp.emailEmpty ? lp.emailError : "",
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

  passwordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: TextFormField(
        enabled: !lp.isLoading,
        obscureText: lp.visiblePassword,
        controller: passwordC,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          checkPassword(val);
          return null;
        },
        onChanged: (val) {
          lp.passwordValue = val;
          checkPassword(val);
          setState(() {});
        },
        style: inter12(),
        cursorColor: Colors.blue,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () => lp.setVisiblePassword(),
                icon: Icon(lp.visiblePassword
                    ? Icons.visibility_off
                    : Icons.remove_red_eye),
                color: lp.visiblePassword ? Colors.grey : Colors.blue),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                  color: lp.passwordEmpty ? Colors.red : Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                  color: lp.passwordEmpty ? Colors.red : Colors.grey),
            ),
            contentPadding: const EdgeInsets.all(10),
            alignLabelWithHint: true,
            hintText: 'Masukkan Password'),
        scrollPadding: const EdgeInsets.only(bottom: 52),
      ),
    );
  }

  passwordErrorText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(lp.passwordEmpty ? lp.passwordError : "",
          style: redValidateErrorRequired()),
    );
  }

  Widget loginButton() {
    return lp.isLoading
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
              if (validate && !lp.emailEmpty && !lp.passwordEmpty) {
                lp.isLoading = true;
                Map<String, dynamic> result =
                    await loginService.loginUser(context);
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
                lp.isLoading = false;
              }
            },
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
  }

  Widget forgotPassButton() {
    return lp.isLoading
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
    return lp.isLoading
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

  checkEmail(String? val) {
    String? msg = loginEmail(val);
    lp.emailEmpty = msg != null;
    lp.emailError = msg ?? "";
  }

  checkPassword(String? val) {
    String? msg = registerPassword(val);
    lp.passwordEmpty = msg != null;
    lp.passwordError = msg ?? "";
  }
}
