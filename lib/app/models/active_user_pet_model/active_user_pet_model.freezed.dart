// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'active_user_pet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ActiveUserPetModel _$ActiveUserPetModelFromJson(Map<String, dynamic> json) {
  return _ActiveUserPetModel.fromJson(json);
}

/// @nodoc
mixin _$ActiveUserPetModel {
  int? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  int? get petId => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  int? get currentExp => throw _privateConstructorUsedError;
  @JsonKey(name: 'virtual_pets')
  VirtualPetsModel? get virtualPet => throw _privateConstructorUsedError;

  /// Serializes this ActiveUserPetModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActiveUserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveUserPetModelCopyWith<ActiveUserPetModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveUserPetModelCopyWith<$Res> {
  factory $ActiveUserPetModelCopyWith(
          ActiveUserPetModel value, $Res Function(ActiveUserPetModel) then) =
      _$ActiveUserPetModelCopyWithImpl<$Res, ActiveUserPetModel>;
  @useResult
  $Res call(
      {int? id,
      String? userId,
      int? petId,
      bool? isActive,
      int? currentExp,
      @JsonKey(name: 'virtual_pets') VirtualPetsModel? virtualPet});

  $VirtualPetsModelCopyWith<$Res>? get virtualPet;
}

/// @nodoc
class _$ActiveUserPetModelCopyWithImpl<$Res, $Val extends ActiveUserPetModel>
    implements $ActiveUserPetModelCopyWith<$Res> {
  _$ActiveUserPetModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveUserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? petId = freezed,
    Object? isActive = freezed,
    Object? currentExp = freezed,
    Object? virtualPet = freezed,
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
      virtualPet: freezed == virtualPet
          ? _value.virtualPet
          : virtualPet // ignore: cast_nullable_to_non_nullable
              as VirtualPetsModel?,
    ) as $Val);
  }

  /// Create a copy of ActiveUserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VirtualPetsModelCopyWith<$Res>? get virtualPet {
    if (_value.virtualPet == null) {
      return null;
    }

    return $VirtualPetsModelCopyWith<$Res>(_value.virtualPet!, (value) {
      return _then(_value.copyWith(virtualPet: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActiveUserPetModelImplCopyWith<$Res>
    implements $ActiveUserPetModelCopyWith<$Res> {
  factory _$$ActiveUserPetModelImplCopyWith(_$ActiveUserPetModelImpl value,
          $Res Function(_$ActiveUserPetModelImpl) then) =
      __$$ActiveUserPetModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? userId,
      int? petId,
      bool? isActive,
      int? currentExp,
      @JsonKey(name: 'virtual_pets') VirtualPetsModel? virtualPet});

  @override
  $VirtualPetsModelCopyWith<$Res>? get virtualPet;
}

/// @nodoc
class __$$ActiveUserPetModelImplCopyWithImpl<$Res>
    extends _$ActiveUserPetModelCopyWithImpl<$Res, _$ActiveUserPetModelImpl>
    implements _$$ActiveUserPetModelImplCopyWith<$Res> {
  __$$ActiveUserPetModelImplCopyWithImpl(_$ActiveUserPetModelImpl _value,
      $Res Function(_$ActiveUserPetModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveUserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? petId = freezed,
    Object? isActive = freezed,
    Object? currentExp = freezed,
    Object? virtualPet = freezed,
  }) {
    return _then(_$ActiveUserPetModelImpl(
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
      virtualPet: freezed == virtualPet
          ? _value.virtualPet
          : virtualPet // ignore: cast_nullable_to_non_nullable
              as VirtualPetsModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActiveUserPetModelImpl implements _ActiveUserPetModel {
  _$ActiveUserPetModelImpl(
      {this.id,
      this.userId,
      this.petId,
      this.isActive,
      this.currentExp,
      @JsonKey(name: 'virtual_pets') this.virtualPet});

  factory _$ActiveUserPetModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActiveUserPetModelImplFromJson(json);

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
  @JsonKey(name: 'virtual_pets')
  final VirtualPetsModel? virtualPet;

  @override
  String toString() {
    return 'ActiveUserPetModel(id: $id, userId: $userId, petId: $petId, isActive: $isActive, currentExp: $currentExp, virtualPet: $virtualPet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveUserPetModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.petId, petId) || other.petId == petId) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.currentExp, currentExp) ||
                other.currentExp == currentExp) &&
            (identical(other.virtualPet, virtualPet) ||
                other.virtualPet == virtualPet));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, petId, isActive, currentExp, virtualPet);

  /// Create a copy of ActiveUserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveUserPetModelImplCopyWith<_$ActiveUserPetModelImpl> get copyWith =>
      __$$ActiveUserPetModelImplCopyWithImpl<_$ActiveUserPetModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActiveUserPetModelImplToJson(
      this,
    );
  }
}

abstract class _ActiveUserPetModel implements ActiveUserPetModel {
  factory _ActiveUserPetModel(
          {final int? id,
          final String? userId,
          final int? petId,
          final bool? isActive,
          final int? currentExp,
          @JsonKey(name: 'virtual_pets') final VirtualPetsModel? virtualPet}) =
      _$ActiveUserPetModelImpl;

  factory _ActiveUserPetModel.fromJson(Map<String, dynamic> json) =
      _$ActiveUserPetModelImpl.fromJson;

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
  @override
  @JsonKey(name: 'virtual_pets')
  VirtualPetsModel? get virtualPet;

  /// Create a copy of ActiveUserPetModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveUserPetModelImplCopyWith<_$ActiveUserPetModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
