import 'package:freezed_annotation/freezed_annotation.dart';
import 'field_model.dart';
part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    required FieldModel email,
    required FieldModel password,
    @Default(false) bool isLoading,
    @Default(false) bool visiblePassword,
  }) = _LoginState;
  // const LoginState._();

  factory LoginState.noError() => LoginState(
      email: const FieldModel(value: ''),
      password: const FieldModel(value: ''),
      isLoading: false);
  // const factory LoginState.noError() = _NoError;
  // const factory LoginState.error(String errorText) = _Error;
  // const factory LoginState.loading() = _Loading;
  // const factory LoginState.emailValue(String emailValue) = _EmailValue;
  // const factory LoginState.emailEmpty() = _EmailEmpty;
  // const factory LoginState.emailError(String emailError) = _EmailError;
  // const factory LoginState.passwordValue(String passwordValue) = _PasswordValue;
  // const factory LoginState.passwordEmpty() = _PasswordEmpty;
  // const factory LoginState.passwordError(String passwordError) = _PasswordError;
  // const factory LoginState.visiblePassword(bool visiblePasswordValue) =
  //     _VisiblePassword;
}
