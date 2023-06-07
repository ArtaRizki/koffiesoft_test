import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koffiesoft_test/views/login_view.dart';
import '../models/login_state.dart';
import '../models/login_event.dart';
import '../providers/login_provider.dart';

final loginProvider =
    StateNotifierProvider<LoginProvider, LoginState>((ref) => LoginProvider());

class LoginBuilder extends ConsumerWidget {
  const LoginBuilder({super.key});

  // const LoginBuilder({Key? key}) : super(key: key);
  Future<Map<String, dynamic>> login(
      BuildContext context, WidgetRef ref, String? val) async {
    final model = ref.read(loginProvider.notifier);
    Map<String, dynamic> result = await model.loginUser(context, val);
    return result;
  }

  Future<void> checkEmail(BuildContext context, WidgetRef ref, String val,
      bool emailEmpty, String emailError, LoginState state) async {
    final model = ref.watch(loginProvider.notifier);

    log("CHECK EMAIL : $val");
    log("CHECK EMAIL : $emailEmpty");
    log("CHECK EMAIL : $emailError");
    model.mapEventsToState(
        CheckEmail(val: val, emailEmpty: emailEmpty, emailError: emailError));
    // model.checkEmail(val, emailEmpty, emailError);
  }

  Future<void> checkPassword(BuildContext context, WidgetRef ref, String val,
      bool passwordEmpty, String passwordError) async {
    final model = ref.read(loginProvider.notifier);
    await model.checkPassword(val, passwordEmpty, passwordError);
  }

  Future<void> changeVisiblePassword(
      BuildContext context, WidgetRef ref, bool val) async {
    final model = ref.read(loginProvider.notifier);
    await model.changeVisiblePassword(val);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    // log("STATE EMAIL EMPTY : ${state.maybeWhen(emailEmpty: () => true, orElse: () => false)}");
    // log("STATE EMAIL ERROR : ${state.maybeWhen(emailError: (a) => a, orElse: () => "")}");
    // log("STATE LOADING STATUS : ${state.maybeWhen(loading: () => true, orElse: () => false)}");

    return LoginView(
      login: (val) => login(context, ref, val),
      isLoading: state.isLoading,
      email: state.email.value,
      emailEmpty: state.email.isEmpty,
      emailError: state.email.errorMessage,
      checkEmail: (val, emailEmpty, emailError) =>
          checkEmail(context, ref, val, emailEmpty, emailError, state),
      password: state.password.value,
      passwordEmpty: state.password.isEmpty,
      passwordError: state.password.errorMessage,
      visiblePassword: state.visiblePassword,
      checkPassword: (val, passwordEmpty, passwordError) =>
          checkPassword(context, ref, val, passwordEmpty, passwordError),
      changeVisiblePassword: (val) => changeVisiblePassword(context, ref, val),
    );
  }
}
