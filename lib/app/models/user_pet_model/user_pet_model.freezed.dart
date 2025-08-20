// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_pet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserPetModel _$UserPetModelFromJson(Map<String, dynamic> json) {
  return _UserPetModel.fromJson(json);
}

/// @nodoc
mixin _$UserPetModel {
  int? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  int? get petId => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get currentExp => throw _privateConstructorUsedError;

  /// Serializes this UserPetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserPetModelCopyWith<UserPetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPetModelCopyWith<$Res> {
  factory $UserPetModelCopyWith(
          UserPetModel value, $Res Function(UserPetModel) then) =
      _$UserPetModelCopyWithImpl<$Res, UserPetModel>;
  @useResult
  $Res call(
      {int? id, String? userId, int? petId, bool? isActive, int? currentExp});
}

/// @nodoc
class _$UserPetModelCopyWithImpl<$Res, $Val extends UserPetModel>
    implements $UserPetModelCopyWith<$Res> {
  _$UserPetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? petId = freezed,
    Object? isActive = freezed,
    Object? currentExp = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      petId: freezed == petId
          ? _value.petId
          : petId // ignore: cast_nullable_to_non_nullable
              as int?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      currentExp: freezed == currentExp
          ? _value.currentExp
          : currentExp // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserPetModelImplCopyWith<$Res>
    implements $UserPetModelCopyWith<$Res> {
  factory _$$UserPetModelImplCopyWith(
          _$UserPetModelImpl value, $Res Function(_$UserPetModelImpl) then) =
      __$$UserPetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, String? userId, int? petId, bool? isActive, int? currentExp});
}

/// @nodoc
class __$$UserPetModelImplCopyWithImpl<$Res>
    extends _$UserPetModelCopyWithImpl<$Res, _$UserPetModelImpl>
    implements _$$UserPetModelImplCopyWith<$Res> {
  __$$UserPetModelImplCopyWithImpl(
      _$UserPetModelImpl _value, $Res Function(_$UserPetModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? petId = freezed,
    Object? isActive = freezed,
    Object? currentExp = freezed,
  }) {
    return _then(_$UserPetModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      petId: freezed == petId
          ? _value.petId
          : petId // ignore: cast_nullable_to_non_nullable
              as int?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      currentExp: freezed == currentExp
          ? _value.currentExp
          : currentExp // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserPetModelImpl implements _UserPetModel {
  _$UserPetModelImpl(
      {this.id, this.userId, this.petId, this.isActive, this.currentExp});

  factory _$UserPetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserPetModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? userId;
  @override
  final int? petId;
  @override
  final bool? isActive;
  @override
  final int? currentExp;

  @override
  String toString() {
    return 'UserPetModel(id: $id, userId: $userId, petId: $petId, isActive: $isActive, currentExp: $currentExp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserPetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.petId, petId) || other.petId == petId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.currentExp, currentExp) ||
                other.currentExp == currentExp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, userId, petId, isActive, currentExp);

  /// Create a copy of UserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserPetModelImplCopyWith<_$UserPetModelImpl> get copyWith =>
      __$$UserPetModelImplCopyWithImpl<_$UserPetModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserPetModelImplToJson(
      this,
    );
  }
}

abstract class _UserPetModel implements UserPetModel {
  factory _UserPetModel(
      {final int? id,
      final String? userId,
      final int? petId,
      final bool? isActive,
      final int? currentExp}) = _$UserPetModelImpl;

  factory _UserPetModel.fromJson(Map<String, dynamic> json) =
      _$UserPetModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get userId;
  @override
  int? get petId;
  @override
  bool? get isActive;
  @override
  int? get currentExp;

  /// Create a copy of UserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserPetModelImplCopyWith<_$UserPetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
