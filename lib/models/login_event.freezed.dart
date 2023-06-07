// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginEvent {
  String get val => throw _privateConstructorUsedError;
  bool get emailEmpty => throw _privateConstructorUsedError;
  String get emailError => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String val, bool emailEmpty, String emailError)
        checkEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String val, bool emailEmpty, String emailError)?
        checkEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String val, bool emailEmpty, String emailError)?
        checkEmail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckEmail value) checkEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckEmail value)? checkEmail,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckEmail value)? checkEmail,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginEventCopyWith<LoginEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res, LoginEvent>;
  @useResult
  $Res call({String val, bool emailEmpty, String emailError});
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? val = null,
    Object? emailEmpty = null,
    Object? emailError = null,
  }) {
    return _then(_value.copyWith(
      val: null == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as String,
      emailEmpty: null == emailEmpty
          ? _value.emailEmpty
          : emailEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
      emailError: null == emailError
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CheckEmailCopyWith<$Res>
    implements $LoginEventCopyWith<$Res> {
  factory _$$CheckEmailCopyWith(
          _$CheckEmail value, $Res Function(_$CheckEmail) then) =
      __$$CheckEmailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String val, bool emailEmpty, String emailError});
}

/// @nodoc
class __$$CheckEmailCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$CheckEmail>
    implements _$$CheckEmailCopyWith<$Res> {
  __$$CheckEmailCopyWithImpl(
      _$CheckEmail _value, $Res Function(_$CheckEmail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? val = null,
    Object? emailEmpty = null,
    Object? emailError = null,
  }) {
    return _then(_$CheckEmail(
      val: null == val
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as String,
      emailEmpty: null == emailEmpty
          ? _value.emailEmpty
          : emailEmpty // ignore: cast_nullable_to_non_nullable
              as bool,
      emailError: null == emailError
          ? _value.emailError
          : emailError // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckEmail implements CheckEmail {
  const _$CheckEmail(
      {required this.val, required this.emailEmpty, required this.emailError});

  @override
  final String val;
  @override
  final bool emailEmpty;
  @override
  final String emailError;

  @override
  String toString() {
    return 'LoginEvent.checkEmail(val: $val, emailEmpty: $emailEmpty, emailError: $emailError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckEmail &&
            (identical(other.val, val) || other.val == val) &&
            (identical(other.emailEmpty, emailEmpty) ||
                other.emailEmpty == emailEmpty) &&
            (identical(other.emailError, emailError) ||
                other.emailError == emailError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, val, emailEmpty, emailError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckEmailCopyWith<_$CheckEmail> get copyWith =>
      __$$CheckEmailCopyWithImpl<_$CheckEmail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String val, bool emailEmpty, String emailError)
        checkEmail,
  }) {
    return checkEmail(val, emailEmpty, emailError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String val, bool emailEmpty, String emailError)?
        checkEmail,
  }) {
    return checkEmail?.call(val, emailEmpty, emailError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String val, bool emailEmpty, String emailError)?
        checkEmail,
    required TResult orElse(),
  }) {
    if (checkEmail != null) {
      return checkEmail(val, emailEmpty, emailError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckEmail value) checkEmail,
  }) {
    return checkEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckEmail value)? checkEmail,
  }) {
    return checkEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckEmail value)? checkEmail,
    required TResult orElse(),
  }) {
    if (checkEmail != null) {
      return checkEmail(this);
    }
    return orElse();
  }
}

abstract class CheckEmail implements LoginEvent {
  const factory CheckEmail(
      {required final String val,
      required final bool emailEmpty,
      required final String emailError}) = _$CheckEmail;

  @override
  String get val;
  @override
  bool get emailEmpty;
  @override
  String get emailError;
  @override
  @JsonKey(ignore: true)
  _$$CheckEmailCopyWith<_$CheckEmail> get copyWith =>
      throw _privateConstructorUsedError;
}
