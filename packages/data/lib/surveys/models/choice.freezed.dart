// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Choice _$ChoiceFromJson(Map<String, dynamic> json) {
  return _Choice.fromJson(json);
}

/// @nodoc
mixin _$Choice {
  @JsonKey(name: 'option_id')
  int get choiceId => throw _privateConstructorUsedError;
  @JsonKey(name: 'option')
  String get choice => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_correct')
  bool get isCorrect => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_selected', includeFromJson: false)
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isSelected => throw _privateConstructorUsedError;

  /// Serializes this Choice to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Choice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChoiceCopyWith<Choice> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChoiceCopyWith<$Res> {
  factory $ChoiceCopyWith(Choice value, $Res Function(Choice) then) =
      _$ChoiceCopyWithImpl<$Res, Choice>;
  @useResult
  $Res call(
      {@JsonKey(name: 'option_id') int choiceId,
      @JsonKey(name: 'option') String choice,
      @JsonKey(name: 'is_correct') bool isCorrect,
      @JsonKey(name: 'is_selected', includeFromJson: false)
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isSelected});
}

/// @nodoc
class _$ChoiceCopyWithImpl<$Res, $Val extends Choice>
    implements $ChoiceCopyWith<$Res> {
  _$ChoiceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Choice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? choiceId = null,
    Object? choice = null,
    Object? isCorrect = null,
    Object? isSelected = null,
  }) {
    return _then(_value.copyWith(
      choiceId: null == choiceId
          ? _value.choiceId
          : choiceId // ignore: cast_nullable_to_non_nullable
              as int,
      choice: null == choice
          ? _value.choice
          : choice // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChoiceImplCopyWith<$Res> implements $ChoiceCopyWith<$Res> {
  factory _$$ChoiceImplCopyWith(
          _$ChoiceImpl value, $Res Function(_$ChoiceImpl) then) =
      __$$ChoiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'option_id') int choiceId,
      @JsonKey(name: 'option') String choice,
      @JsonKey(name: 'is_correct') bool isCorrect,
      @JsonKey(name: 'is_selected', includeFromJson: false)
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool isSelected});
}

/// @nodoc
class __$$ChoiceImplCopyWithImpl<$Res>
    extends _$ChoiceCopyWithImpl<$Res, _$ChoiceImpl>
    implements _$$ChoiceImplCopyWith<$Res> {
  __$$ChoiceImplCopyWithImpl(
      _$ChoiceImpl _value, $Res Function(_$ChoiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of Choice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? choiceId = null,
    Object? choice = null,
    Object? isCorrect = null,
    Object? isSelected = null,
  }) {
    return _then(_$ChoiceImpl(
      choiceId: null == choiceId
          ? _value.choiceId
          : choiceId // ignore: cast_nullable_to_non_nullable
              as int,
      choice: null == choice
          ? _value.choice
          : choice // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _value.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelected: null == isSelected
          ? _value.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChoiceImpl implements _Choice {
  const _$ChoiceImpl(
      {@JsonKey(name: 'option_id') required this.choiceId,
      @JsonKey(name: 'option') required this.choice,
      @JsonKey(name: 'is_correct') required this.isCorrect,
      @JsonKey(name: 'is_selected', includeFromJson: false)
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.isSelected = false});

  factory _$ChoiceImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChoiceImplFromJson(json);

  @override
  @JsonKey(name: 'option_id')
  final int choiceId;
  @override
  @JsonKey(name: 'option')
  final String choice;
  @override
  @JsonKey(name: 'is_correct')
  final bool isCorrect;
  @override
  @JsonKey(name: 'is_selected', includeFromJson: false)
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isSelected;

  @override
  String toString() {
    return 'Choice(choiceId: $choiceId, choice: $choice, isCorrect: $isCorrect, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChoiceImpl &&
            (identical(other.choiceId, choiceId) ||
                other.choiceId == choiceId) &&
            (identical(other.choice, choice) || other.choice == choice) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, choiceId, choice, isCorrect, isSelected);

  /// Create a copy of Choice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChoiceImplCopyWith<_$ChoiceImpl> get copyWith =>
      __$$ChoiceImplCopyWithImpl<_$ChoiceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChoiceImplToJson(
      this,
    );
  }
}

abstract class _Choice implements Choice {
  const factory _Choice(
      {@JsonKey(name: 'option_id') required final int choiceId,
      @JsonKey(name: 'option') required final String choice,
      @JsonKey(name: 'is_correct') required final bool isCorrect,
      @JsonKey(name: 'is_selected', includeFromJson: false)
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool isSelected}) = _$ChoiceImpl;

  factory _Choice.fromJson(Map<String, dynamic> json) = _$ChoiceImpl.fromJson;

  @override
  @JsonKey(name: 'option_id')
  int get choiceId;
  @override
  @JsonKey(name: 'option')
  String get choice;
  @override
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  @override
  @JsonKey(name: 'is_selected', includeFromJson: false)
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isSelected;

  /// Create a copy of Choice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChoiceImplCopyWith<_$ChoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
