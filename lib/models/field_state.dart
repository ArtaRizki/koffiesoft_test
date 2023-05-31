import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_state.freezed.dart';

@freezed
class Field with _$Field {
  const factory Field(
      {required String value,
      @Default('') String errorMessage,
      @Default(false) bool isEmpty}) = _Field;
}
