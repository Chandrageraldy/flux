// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_details_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FoodDetailsModel _$FoodDetailsModelFromJson(Map<String, dynamic> json) {
  return _FoodDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$FoodDetailsModel {
  @JsonKey(name: 'food_name')
  String? get foodName => throw _privateConstructorUsedError;
  @JsonKey(name: 'brand_name')
  String? get brandName => throw _privateConstructorUsedError;
  @JsonKey(name: 'serving_qty')
  double? get servingQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'serving_unit')
  String? get servingUnit => throw _privateConstructorUsedError;
  @JsonKey(name: 'serving_weight_grams')
  double? get servingWeightGrams => throw _privateConstructorUsedError;
  @JsonKey(name: 'nf_calories')
  double? get calorieKcal => throw _privateConstructorUsedError;
  @JsonKey(name: 'nf_total_fat')
  double? get fatG => throw _privateConstructorUsedError;
  @JsonKey(name: 'nf_total_carbohydrate')
  double? get carbsG => throw _privateConstructorUsedError;
  @JsonKey(name: 'nf_protein')
  double? get proteinG => throw _privateConstructorUsedError;
  @JsonKey(name: 'nix_brand_name')
  String? get nixBrandName => throw _privateConstructorUsedError;
  @JsonKey(name: 'nix_item_name')
  String? get nixItemName => throw _privateConstructorUsedError;
  @JsonKey(name: 'nix_item_id')
  String? get nixItemId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tag_id')
  String? get tagId => throw _privateConstructorUsedError;
  @JsonKey(name: 'nf_ingredient_statement')
  String? get ingredientStatement => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_nutrients')
  List<FullNutrientsModel>? get fullNutrients =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'alt_measures')
  List<AltMeasureModel>? get altMeasures => throw _privateConstructorUsedError;

  /// Serializes this FoodDetailsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodDetailsModelCopyWith<FoodDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodDetailsModelCopyWith<$Res> {
  factory $FoodDetailsModelCopyWith(
          FoodDetailsModel value, $Res Function(FoodDetailsModel) then) =
      _$FoodDetailsModelCopyWithImpl<$Res, FoodDetailsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'food_name') String? foodName,
      @JsonKey(name: 'brand_name') String? brandName,
      @JsonKey(name: 'serving_qty') double? servingQty,
      @JsonKey(name: 'serving_unit') String? servingUnit,
      @JsonKey(name: 'serving_weight_grams') double? servingWeightGrams,
      @JsonKey(name: 'nf_calories') double? calorieKcal,
      @JsonKey(name: 'nf_total_fat') double? fatG,
      @JsonKey(name: 'nf_total_carbohydrate') double? carbsG,
      @JsonKey(name: 'nf_protein') double? proteinG,
      @JsonKey(name: 'nix_brand_name') String? nixBrandName,
      @JsonKey(name: 'nix_item_name') String? nixItemName,
      @JsonKey(name: 'nix_item_id') String? nixItemId,
      @JsonKey(name: 'tag_id') String? tagId,
      @JsonKey(name: 'nf_ingredient_statement') String? ingredientStatement,
      @JsonKey(name: 'full_nutrients') List<FullNutrientsModel>? fullNutrients,
      @JsonKey(name: 'alt_measures') List<AltMeasureModel>? altMeasures});
}

/// @nodoc
class _$FoodDetailsModelCopyWithImpl<$Res, $Val extends FoodDetailsModel>
    implements $FoodDetailsModelCopyWith<$Res> {
  _$FoodDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodName = freezed,
    Object? brandName = freezed,
    Object? servingQty = freezed,
    Object? servingUnit = freezed,
    Object? servingWeightGrams = freezed,
    Object? calorieKcal = freezed,
    Object? fatG = freezed,
    Object? carbsG = freezed,
    Object? proteinG = freezed,
    Object? nixBrandName = freezed,
    Object? nixItemName = freezed,
    Object? nixItemId = freezed,
    Object? tagId = freezed,
    Object? ingredientStatement = freezed,
    Object? fullNutrients = freezed,
    Object? altMeasures = freezed,
  }) {
    return _then(_value.copyWith(
      foodName: freezed == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      servingQty: freezed == servingQty
          ? _value.servingQty
          : servingQty // ignore: cast_nullable_to_non_nullable
              as double?,
      servingUnit: freezed == servingUnit
          ? _value.servingUnit
          : servingUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      servingWeightGrams: freezed == servingWeightGrams
          ? _value.servingWeightGrams
          : servingWeightGrams // ignore: cast_nullable_to_non_nullable
              as double?,
      calorieKcal: freezed == calorieKcal
          ? _value.calorieKcal
          : calorieKcal // ignore: cast_nullable_to_non_nullable
              as double?,
      fatG: freezed == fatG
          ? _value.fatG
          : fatG // ignore: cast_nullable_to_non_nullable
              as double?,
      carbsG: freezed == carbsG
          ? _value.carbsG
          : carbsG // ignore: cast_nullable_to_non_nullable
              as double?,
      proteinG: freezed == proteinG
          ? _value.proteinG
          : proteinG // ignore: cast_nullable_to_non_nullable
              as double?,
      nixBrandName: freezed == nixBrandName
          ? _value.nixBrandName
          : nixBrandName // ignore: cast_nullable_to_non_nullable
              as String?,
      nixItemName: freezed == nixItemName
          ? _value.nixItemName
          : nixItemName // ignore: cast_nullable_to_non_nullable
              as String?,
      nixItemId: freezed == nixItemId
          ? _value.nixItemId
          : nixItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredientStatement: freezed == ingredientStatement
          ? _value.ingredientStatement
          : ingredientStatement // ignore: cast_nullable_to_non_nullable
              as String?,
      fullNutrients: freezed == fullNutrients
          ? _value.fullNutrients
          : fullNutrients // ignore: cast_nullable_to_non_nullable
              as List<FullNutrientsModel>?,
      altMeasures: freezed == altMeasures
          ? _value.altMeasures
          : altMeasures // ignore: cast_nullable_to_non_nullable
              as List<AltMeasureModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodDetailsModelImplCopyWith<$Res>
    implements $FoodDetailsModelCopyWith<$Res> {
  factory _$$FoodDetailsModelImplCopyWith(_$FoodDetailsModelImpl value,
          $Res Function(_$FoodDetailsModelImpl) then) =
      __$$FoodDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'food_name') String? foodName,
      @JsonKey(name: 'brand_name') String? brandName,
      @JsonKey(name: 'serving_qty') double? servingQty,
      @JsonKey(name: 'serving_unit') String? servingUnit,
      @JsonKey(name: 'serving_weight_grams') double? servingWeightGrams,
      @JsonKey(name: 'nf_calories') double? calorieKcal,
      @JsonKey(name: 'nf_total_fat') double? fatG,
      @JsonKey(name: 'nf_total_carbohydrate') double? carbsG,
      @JsonKey(name: 'nf_protein') double? proteinG,
      @JsonKey(name: 'nix_brand_name') String? nixBrandName,
      @JsonKey(name: 'nix_item_name') String? nixItemName,
      @JsonKey(name: 'nix_item_id') String? nixItemId,
      @JsonKey(name: 'tag_id') String? tagId,
      @JsonKey(name: 'nf_ingredient_statement') String? ingredientStatement,
      @JsonKey(name: 'full_nutrients') List<FullNutrientsModel>? fullNutrients,
      @JsonKey(name: 'alt_measures') List<AltMeasureModel>? altMeasures});
}

/// @nodoc
class __$$FoodDetailsModelImplCopyWithImpl<$Res>
    extends _$FoodDetailsModelCopyWithImpl<$Res, _$FoodDetailsModelImpl>
    implements _$$FoodDetailsModelImplCopyWith<$Res> {
  __$$FoodDetailsModelImplCopyWithImpl(_$FoodDetailsModelImpl _value,
      $Res Function(_$FoodDetailsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodName = freezed,
    Object? brandName = freezed,
    Object? servingQty = freezed,
    Object? servingUnit = freezed,
    Object? servingWeightGrams = freezed,
    Object? calorieKcal = freezed,
    Object? fatG = freezed,
    Object? carbsG = freezed,
    Object? proteinG = freezed,
    Object? nixBrandName = freezed,
    Object? nixItemName = freezed,
    Object? nixItemId = freezed,
    Object? tagId = freezed,
    Object? ingredientStatement = freezed,
    Object? fullNutrients = freezed,
    Object? altMeasures = freezed,
  }) {
    return _then(_$FoodDetailsModelImpl(
      foodName: freezed == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String?,
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      servingQty: freezed == servingQty
          ? _value.servingQty
          : servingQty // ignore: cast_nullable_to_non_nullable
              as double?,
      servingUnit: freezed == servingUnit
          ? _value.servingUnit
          : servingUnit // ignore: cast_nullable_to_non_nullable
              as String?,
      servingWeightGrams: freezed == servingWeightGrams
          ? _value.servingWeightGrams
          : servingWeightGrams // ignore: cast_nullable_to_non_nullable
              as double?,
      calorieKcal: freezed == calorieKcal
          ? _value.calorieKcal
          : calorieKcal // ignore: cast_nullable_to_non_nullable
              as double?,
      fatG: freezed == fatG
          ? _value.fatG
          : fatG // ignore: cast_nullable_to_non_nullable
              as double?,
      carbsG: freezed == carbsG
          ? _value.carbsG
          : carbsG // ignore: cast_nullable_to_non_nullable
              as double?,
      proteinG: freezed == proteinG
          ? _value.proteinG
          : proteinG // ignore: cast_nullable_to_non_nullable
              as double?,
      nixBrandName: freezed == nixBrandName
          ? _value.nixBrandName
          : nixBrandName // ignore: cast_nullable_to_non_nullable
              as String?,
      nixItemName: freezed == nixItemName
          ? _value.nixItemName
          : nixItemName // ignore: cast_nullable_to_non_nullable
              as String?,
      nixItemId: freezed == nixItemId
          ? _value.nixItemId
          : nixItemId // ignore: cast_nullable_to_non_nullable
              as String?,
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredientStatement: freezed == ingredientStatement
          ? _value.ingredientStatement
          : ingredientStatement // ignore: cast_nullable_to_non_nullable
              as String?,
      fullNutrients: freezed == fullNutrients
          ? _value._fullNutrients
          : fullNutrients // ignore: cast_nullable_to_non_nullable
              as List<FullNutrientsModel>?,
      altMeasures: freezed == altMeasures
          ? _value._altMeasures
          : altMeasures // ignore: cast_nullable_to_non_nullable
              as List<AltMeasureModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodDetailsModelImpl implements _FoodDetailsModel {
  _$FoodDetailsModelImpl(
      {@JsonKey(name: 'food_name') this.foodName,
      @JsonKey(name: 'brand_name') this.brandName,
      @JsonKey(name: 'serving_qty') this.servingQty,
      @JsonKey(name: 'serving_unit') this.servingUnit,
      @JsonKey(name: 'serving_weight_grams') this.servingWeightGrams,
      @JsonKey(name: 'nf_calories') this.calorieKcal,
      @JsonKey(name: 'nf_total_fat') this.fatG,
      @JsonKey(name: 'nf_total_carbohydrate') this.carbsG,
      @JsonKey(name: 'nf_protein') this.proteinG,
      @JsonKey(name: 'nix_brand_name') this.nixBrandName,
      @JsonKey(name: 'nix_item_name') this.nixItemName,
      @JsonKey(name: 'nix_item_id') this.nixItemId,
      @JsonKey(name: 'tag_id') this.tagId,
      @JsonKey(name: 'nf_ingredient_statement') this.ingredientStatement,
      @JsonKey(name: 'full_nutrients')
      final List<FullNutrientsModel>? fullNutrients,
      @JsonKey(name: 'alt_measures') final List<AltMeasureModel>? altMeasures})
      : _fullNutrients = fullNutrients,
        _altMeasures = altMeasures;

  factory _$FoodDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodDetailsModelImplFromJson(json);

  @override
  @JsonKey(name: 'food_name')
  final String? foodName;
  @override
  @JsonKey(name: 'brand_name')
  final String? brandName;
  @override
  @JsonKey(name: 'serving_qty')
  final double? servingQty;
  @override
  @JsonKey(name: 'serving_unit')
  final String? servingUnit;
  @override
  @JsonKey(name: 'serving_weight_grams')
  final double? servingWeightGrams;
  @override
  @JsonKey(name: 'nf_calories')
  final double? calorieKcal;
  @override
  @JsonKey(name: 'nf_total_fat')
  final double? fatG;
  @override
  @JsonKey(name: 'nf_total_carbohydrate')
  final double? carbsG;
  @override
  @JsonKey(name: 'nf_protein')
  final double? proteinG;
  @override
  @JsonKey(name: 'nix_brand_name')
  final String? nixBrandName;
  @override
  @JsonKey(name: 'nix_item_name')
  final String? nixItemName;
  @override
  @JsonKey(name: 'nix_item_id')
  final String? nixItemId;
  @override
  @JsonKey(name: 'tag_id')
  final String? tagId;
  @override
  @JsonKey(name: 'nf_ingredient_statement')
  final String? ingredientStatement;
  final List<FullNutrientsModel>? _fullNutrients;
  @override
  @JsonKey(name: 'full_nutrients')
  List<FullNutrientsModel>? get fullNutrients {
    final value = _fullNutrients;
    if (value == null) return null;
    if (_fullNutrients is EqualUnmodifiableListView) return _fullNutrients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AltMeasureModel>? _altMeasures;
  @override
  @JsonKey(name: 'alt_measures')
  List<AltMeasureModel>? get altMeasures {
    final value = _altMeasures;
    if (value == null) return null;
    if (_altMeasures is EqualUnmodifiableListView) return _altMeasures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FoodDetailsModel(foodName: $foodName, brandName: $brandName, servingQty: $servingQty, servingUnit: $servingUnit, servingWeightGrams: $servingWeightGrams, calorieKcal: $calorieKcal, fatG: $fatG, carbsG: $carbsG, proteinG: $proteinG, nixBrandName: $nixBrandName, nixItemName: $nixItemName, nixItemId: $nixItemId, tagId: $tagId, ingredientStatement: $ingredientStatement, fullNutrients: $fullNutrients, altMeasures: $altMeasures)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDetailsModelImpl &&
            (identical(other.foodName, foodName) ||
                other.foodName == foodName) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.servingQty, servingQty) ||
                other.servingQty == servingQty) &&
            (identical(other.servingUnit, servingUnit) ||
                other.servingUnit == servingUnit) &&
            (identical(other.servingWeightGrams, servingWeightGrams) ||
                other.servingWeightGrams == servingWeightGrams) &&
            (identical(other.calorieKcal, calorieKcal) ||
                other.calorieKcal == calorieKcal) &&
            (identical(other.fatG, fatG) || other.fatG == fatG) &&
            (identical(other.carbsG, carbsG) || other.carbsG == carbsG) &&
            (identical(other.proteinG, proteinG) ||
                other.proteinG == proteinG) &&
            (identical(other.nixBrandName, nixBrandName) ||
                other.nixBrandName == nixBrandName) &&
            (identical(other.nixItemName, nixItemName) ||
                other.nixItemName == nixItemName) &&
            (identical(other.nixItemId, nixItemId) ||
                other.nixItemId == nixItemId) &&
            (identical(other.tagId, tagId) || other.tagId == tagId) &&
            (identical(other.ingredientStatement, ingredientStatement) ||
                other.ingredientStatement == ingredientStatement) &&
            const DeepCollectionEquality()
                .equals(other._fullNutrients, _fullNutrients) &&
            const DeepCollectionEquality()
                .equals(other._altMeasures, _altMeasures));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      foodName,
      brandName,
      servingQty,
      servingUnit,
      servingWeightGrams,
      calorieKcal,
      fatG,
      carbsG,
      proteinG,
      nixBrandName,
      nixItemName,
      nixItemId,
      tagId,
      ingredientStatement,
      const DeepCollectionEquality().hash(_fullNutrients),
      const DeepCollectionEquality().hash(_altMeasures));

  /// Create a copy of FoodDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDetailsModelImplCopyWith<_$FoodDetailsModelImpl> get copyWith =>
      __$$FoodDetailsModelImplCopyWithImpl<_$FoodDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _FoodDetailsModel implements FoodDetailsModel {
  factory _FoodDetailsModel(
      {@JsonKey(name: 'food_name') final String? foodName,
      @JsonKey(name: 'brand_name') final String? brandName,
      @JsonKey(name: 'serving_qty') final double? servingQty,
      @JsonKey(name: 'serving_unit') final String? servingUnit,
      @JsonKey(name: 'serving_weight_grams') final double? servingWeightGrams,
      @JsonKey(name: 'nf_calories') final double? calorieKcal,
      @JsonKey(name: 'nf_total_fat') final double? fatG,
      @JsonKey(name: 'nf_total_carbohydrate') final double? carbsG,
      @JsonKey(name: 'nf_protein') final double? proteinG,
      @JsonKey(name: 'nix_brand_name') final String? nixBrandName,
      @JsonKey(name: 'nix_item_name') final String? nixItemName,
      @JsonKey(name: 'nix_item_id') final String? nixItemId,
      @JsonKey(name: 'tag_id') final String? tagId,
      @JsonKey(name: 'nf_ingredient_statement')
      final String? ingredientStatement,
      @JsonKey(name: 'full_nutrients')
      final List<FullNutrientsModel>? fullNutrients,
      @JsonKey(name: 'alt_measures')
      final List<AltMeasureModel>? altMeasures}) = _$FoodDetailsModelImpl;

  factory _FoodDetailsModel.fromJson(Map<String, dynamic> json) =
      _$FoodDetailsModelImpl.fromJson;

  @override
  @JsonKey(name: 'food_name')
  String? get foodName;
  @override
  @JsonKey(name: 'brand_name')
  String? get brandName;
  @override
  @JsonKey(name: 'serving_qty')
  double? get servingQty;
  @override
  @JsonKey(name: 'serving_unit')
  String? get servingUnit;
  @override
  @JsonKey(name: 'serving_weight_grams')
  double? get servingWeightGrams;
  @override
  @JsonKey(name: 'nf_calories')
  double? get calorieKcal;
  @override
  @JsonKey(name: 'nf_total_fat')
  double? get fatG;
  @override
  @JsonKey(name: 'nf_total_carbohydrate')
  double? get carbsG;
  @override
  @JsonKey(name: 'nf_protein')
  double? get proteinG;
  @override
  @JsonKey(name: 'nix_brand_name')
  String? get nixBrandName;
  @override
  @JsonKey(name: 'nix_item_name')
  String? get nixItemName;
  @override
  @JsonKey(name: 'nix_item_id')
  String? get nixItemId;
  @override
  @JsonKey(name: 'tag_id')
  String? get tagId;
  @override
  @JsonKey(name: 'nf_ingredient_statement')
  String? get ingredientStatement;
  @override
  @JsonKey(name: 'full_nutrients')
  List<FullNutrientsModel>? get fullNutrients;
  @override
  @JsonKey(name: 'alt_measures')
  List<AltMeasureModel>? get altMeasures;

  /// Create a copy of FoodDetailsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodDetailsModelImplCopyWith<_$FoodDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
