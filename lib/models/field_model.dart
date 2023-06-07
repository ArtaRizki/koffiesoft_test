import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_model.freezed.dart';

@freezed
class FieldModel with _$FieldModel {
  const factory FieldModel(
      {required String value,
      @Default('') String errorMessage,
      @Default(false) bool isEmpty}) = _FieldModel;

  // const FieldModel._();

  factory FieldModel.empty() =>
      const FieldModel(value: '', errorMessage: '', isEmpty: false);
}
