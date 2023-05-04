import 'package:flutter/material.dart';
import 'package:koffiesoft_test/providers/login_provider.dart';
import 'package:koffiesoft_test/providers/register_provider.dart';
import 'package:koffiesoft_test/providers/user_provider.dart';
import 'package:koffiesoft_test/views/login_view.dart';
import 'package:koffiesoft_test/views/welcome_view.dart';
import 'package:provider/provider.dart';
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
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

    return const LoginView();
  }
}
