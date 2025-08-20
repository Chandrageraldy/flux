// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_energy_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserEnergyModel _$UserEnergyModelFromJson(Map<String, dynamic> json) {
  return _UserEnergyModel.fromJson(json);
}

/// @nodoc
mixin _$UserEnergyModel {
  int? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  int? get energies => throw _privateConstructorUsedError;

  /// Serializes this UserEnergyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserEnergyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserEnergyModelCopyWith<UserEnergyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEnergyModelCopyWith<$Res> {
  factory $UserEnergyModelCopyWith(
          UserEnergyModel value, $Res Function(UserEnergyModel) then) =
      _$UserEnergyModelCopyWithImpl<$Res, UserEnergyModel>;
  @useResult
  $Res call({int? id, String? userId, int? energies});
}

/// @nodoc
class _$UserEnergyModelCopyWithImpl<$Res, $Val extends UserEnergyModel>
    implements $UserEnergyModelCopyWith<$Res> {
  _$UserEnergyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserEnergyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? energies = freezed,
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
      energies: freezed == energies
          ? _value.energies
          : energies // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserEnergyModelImplCopyWith<$Res>
    implements $UserEnergyModelCopyWith<$Res> {
  factory _$$UserEnergyModelImplCopyWith(_$UserEnergyModelImpl value,
          $Res Function(_$UserEnergyModelImpl) then) =
      __$$UserEnergyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? userId, int? energies});
}

/// @nodoc
class __$$UserEnergyModelImplCopyWithImpl<$Res>
    extends _$UserEnergyModelCopyWithImpl<$Res, _$UserEnergyModelImpl>
    implements _$$UserEnergyModelImplCopyWith<$Res> {
  __$$UserEnergyModelImplCopyWithImpl(
      _$UserEnergyModelImpl _value, $Res Function(_$UserEnergyModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserEnergyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? energies = freezed,
  }) {
    return _then(_$UserEnergyModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      energies: freezed == energies
          ? _value.energies
          : energies // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserEnergyModelImpl implements _UserEnergyModel {
  _$UserEnergyModelImpl({this.id, this.userId, this.energies});

  factory _$UserEnergyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserEnergyModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? userId;
  @override
  final int? energies;

  @override
  String toString() {
    return 'UserEnergyModel(id: $id, userId: $userId, energies: $energies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEnergyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.energies, energies) ||
                other.energies == energies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, energies);

  /// Create a copy of UserEnergyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserEnergyModelImplCopyWith<_$UserEnergyModelImpl> get copyWith =>
      __$$UserEnergyModelImplCopyWithImpl<_$UserEnergyModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserEnergyModelImplToJson(
      this,
    );
  }
}

abstract class _UserEnergyModel implements UserEnergyModel {
  factory _UserEnergyModel(
      {final int? id,
      final String? userId,
      final int? energies}) = _$UserEnergyModelImpl;

  factory _UserEnergyModel.fromJson(Map<String, dynamic> json) =
      _$UserEnergyModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get userId;
  @override
  int? get energies;

  /// Create a copy of UserEnergyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserEnergyModelImplCopyWith<_$UserEnergyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
