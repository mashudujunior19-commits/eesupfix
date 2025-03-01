// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Choice {
  @JsonKey(name: 'option_id')
  int get choiceId;
  @JsonKey(name: 'option')
  String get choice;
  @JsonKey(name: 'is_correct')
  bool get isCorrect;
  @JsonKey(name: 'is_selected', includeFromJson: false)
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isSelected;

  /// Create a copy of Choice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChoiceCopyWith<Choice> get copyWith =>
      _$ChoiceCopyWithImpl<Choice>(this as Choice, _$identity);

  /// Serializes this Choice to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Choice &&
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

  @override
  String toString() {
    return 'Choice(choiceId: $choiceId, choice: $choice, isCorrect: $isCorrect, isSelected: $isSelected)';
  }
}

/// @nodoc
abstract mixin class $ChoiceCopyWith<$Res> {
  factory $ChoiceCopyWith(Choice value, $Res Function(Choice) _then) =
      _$ChoiceCopyWithImpl;
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
class _$ChoiceCopyWithImpl<$Res> implements $ChoiceCopyWith<$Res> {
  _$ChoiceCopyWithImpl(this._self, this._then);

  final Choice _self;
  final $Res Function(Choice) _then;

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
    return _then(_self.copyWith(
      choiceId: null == choiceId
          ? _self.choiceId
          : choiceId // ignore: cast_nullable_to_non_nullable
              as int,
      choice: null == choice
          ? _self.choice
          : choice // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelected: null == isSelected
          ? _self.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Choice implements Choice {
  const _Choice(
      {@JsonKey(name: 'option_id') required this.choiceId,
      @JsonKey(name: 'option') required this.choice,
      @JsonKey(name: 'is_correct') required this.isCorrect,
      @JsonKey(name: 'is_selected', includeFromJson: false)
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.isSelected = false});
  factory _Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

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

  /// Create a copy of Choice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChoiceCopyWith<_Choice> get copyWith =>
      __$ChoiceCopyWithImpl<_Choice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChoiceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Choice &&
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

  @override
  String toString() {
    return 'Choice(choiceId: $choiceId, choice: $choice, isCorrect: $isCorrect, isSelected: $isSelected)';
  }
}

/// @nodoc
abstract mixin class _$ChoiceCopyWith<$Res> implements $ChoiceCopyWith<$Res> {
  factory _$ChoiceCopyWith(_Choice value, $Res Function(_Choice) _then) =
      __$ChoiceCopyWithImpl;
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
class __$ChoiceCopyWithImpl<$Res> implements _$ChoiceCopyWith<$Res> {
  __$ChoiceCopyWithImpl(this._self, this._then);

  final _Choice _self;
  final $Res Function(_Choice) _then;

  /// Create a copy of Choice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? choiceId = null,
    Object? choice = null,
    Object? isCorrect = null,
    Object? isSelected = null,
  }) {
    return _then(_Choice(
      choiceId: null == choiceId
          ? _self.choiceId
          : choiceId // ignore: cast_nullable_to_non_nullable
              as int,
      choice: null == choice
          ? _self.choice
          : choice // ignore: cast_nullable_to_non_nullable
              as String,
      isCorrect: null == isCorrect
          ? _self.isCorrect
          : isCorrect // ignore: cast_nullable_to_non_nullable
              as bool,
      isSelected: null == isSelected
          ? _self.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
