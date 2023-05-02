import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:koffiesoft_test/main.dart';
import 'package:koffiesoft_test/models/user_model.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  late LoginProvider lp;
  late UserModel userModel;
  String name = "";
  @override
  void initState() {
    lp = Provider.of<LoginProvider>(context, listen: false);
    userModel = userModelFromJson(prefs.getString("user") ?? "");
    name = "${userModel.firstname} ${userModel.lastname}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome $name"),
            const SizedBox(height: 16),
            logoutBotton(),
          ],
        ),
      ),
    );
  }

  Widget logoutBotton() {
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
              lp.isLoading = true;
              prefs.remove("user");
              prefs.remove("access_token");
              routes.welcomeView();
              lp.isLoading = false;
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          );
  }
}
