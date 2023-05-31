import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.noError() = _NoError;
  const factory LoginState.error(String errorText) = _Error;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.emailValue(String emailValue) = _EmailValue;
  const factory LoginState.emailEmpty() = _EmailEmpty;
  const factory LoginState.emailError(String emailError) = _EmailError;
  const factory LoginState.passwordValue(String passwordValue) = _PasswordValue;
  const factory LoginState.passwordEmpty() = _PasswordEmpty;
  const factory LoginState.passwordError(String passwordError) = _PasswordError;
  const factory LoginState.visiblePassword(bool visiblePasswordValue) =
      _VisiblePassword;
}
