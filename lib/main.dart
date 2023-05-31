import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koffiesoft_test/builder/login_builder.dart';
import 'package:koffiesoft_test/views/welcome_view.dart';
import 'libraries/routes.dart';
import 'libraries/sharedpref.dart';

// key navigasi
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Prefs prefs = Prefs();
Routes routes = Routes();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await prefs.init();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KoffieSoft Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: checkLogin(),
      navigatorKey: navigatorKey,
    );
  }

  Widget checkLogin() {
    String? user = prefs.getString("user");
    if (user != null) {
      return const WelcomeView();
    }

    return const LoginBuilder();
  }
}
