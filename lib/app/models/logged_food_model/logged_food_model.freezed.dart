// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logged_food_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoggedFoodModel _$LoggedFoodModelFromJson(Map<String, dynamic> json) {
  return _LoggedFoodModel.fromJson(json);
}

/// @nodoc
mixin _$LoggedFoodModel {
  int? get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get foodName => throw _privateConstructorUsedError;
  String? get brandName => throw _privateConstructorUsedError;
  double? get servingQty => throw _privateConstructorUsedError;
  String? get servingUnit => throw _privateConstructorUsedError;
  double? get servingWeightGrams => throw _privateConstructorUsedError;
  double? get calorieKcal => throw _privateConstructorUsedError;
  double? get fatG => throw _privateConstructorUsedError;
  double? get carbsG => throw _privateConstructorUsedError;
  double? get proteinG => throw _privateConstructorUsedError;
  String? get nixBrandName => throw _privateConstructorUsedError;
  String? get nixItemName => throw _privateConstructorUsedError;
  String? get nixItemId => throw _privateConstructorUsedError;
  String? get tagId => throw _privateConstructorUsedError;
  String? get ingredientStatement => throw _privateConstructorUsedError;
  List<FullNutrientsModel>? get fullNutrients =>
      throw _privateConstructorUsedError;
  List<AltMeasureModel>? get altMeasures => throw _privateConstructorUsedError;
  double? get healthScore => throw _privateConstructorUsedError;
  String? get healthScoreDesc => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;
  List<IngredientModel>? get ingredients => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  String? get mealType => throw _privateConstructorUsedError;
  DateTime? get loggedAt => throw _privateConstructorUsedError;

  /// Serializes this LoggedFoodModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoggedFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoggedFoodModelCopyWith<LoggedFoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoggedFoodModelCopyWith<$Res> {
  factory $LoggedFoodModelCopyWith(
          LoggedFoodModel value, $Res Function(LoggedFoodModel) then) =
      _$LoggedFoodModelCopyWithImpl<$Res, LoggedFoodModel>;
  @useResult
  $Res call(
      {int? id,
      String? userId,
      String? foodName,
      String? brandName,
      double? servingQty,
      String? servingUnit,
      double? servingWeightGrams,
      double? calorieKcal,
      double? fatG,
      double? carbsG,
      double? proteinG,
      String? nixBrandName,
      String? nixItemName,
      String? nixItemId,
      String? tagId,
      String? ingredientStatement,
      List<FullNutrientsModel>? fullNutrients,
      List<AltMeasureModel>? altMeasures,
      double? healthScore,
      String? healthScoreDesc,
      double? quantity,
      List<IngredientModel>? ingredients,
      String? source,
      String? mealType,
      DateTime? loggedAt});
}

/// @nodoc
class _$LoggedFoodModelCopyWithImpl<$Res, $Val extends LoggedFoodModel>
    implements $LoggedFoodModelCopyWith<$Res> {
  _$LoggedFoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoggedFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
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
    Object? healthScore = freezed,
    Object? healthScoreDesc = freezed,
    Object? quantity = freezed,
    Object? ingredients = freezed,
    Object? source = freezed,
    Object? mealType = freezed,
    Object? loggedAt = freezed,
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
      healthScore: freezed == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as double?,
      healthScoreDesc: freezed == healthScoreDesc
          ? _value.healthScoreDesc
          : healthScoreDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      ingredients: freezed == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<IngredientModel>?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      mealType: freezed == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String?,
      loggedAt: freezed == loggedAt
          ? _value.loggedAt
          : loggedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoggedFoodModelImplCopyWith<$Res>
    implements $LoggedFoodModelCopyWith<$Res> {
  factory _$$LoggedFoodModelImplCopyWith(_$LoggedFoodModelImpl value,
          $Res Function(_$LoggedFoodModelImpl) then) =
      __$$LoggedFoodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? userId,
      String? foodName,
      String? brandName,
      double? servingQty,
      String? servingUnit,
      double? servingWeightGrams,
      double? calorieKcal,
      double? fatG,
      double? carbsG,
      double? proteinG,
      String? nixBrandName,
      String? nixItemName,
      String? nixItemId,
      String? tagId,
      String? ingredientStatement,
      List<FullNutrientsModel>? fullNutrients,
      List<AltMeasureModel>? altMeasures,
      double? healthScore,
      String? healthScoreDesc,
      double? quantity,
      List<IngredientModel>? ingredients,
      String? source,
      String? mealType,
      DateTime? loggedAt});
}

/// @nodoc
class __$$LoggedFoodModelImplCopyWithImpl<$Res>
    extends _$LoggedFoodModelCopyWithImpl<$Res, _$LoggedFoodModelImpl>
    implements _$$LoggedFoodModelImplCopyWith<$Res> {
  __$$LoggedFoodModelImplCopyWithImpl(
      _$LoggedFoodModelImpl _value, $Res Function(_$LoggedFoodModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoggedFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
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
    Object? healthScore = freezed,
    Object? healthScoreDesc = freezed,
    Object? quantity = freezed,
    Object? ingredients = freezed,
    Object? source = freezed,
    Object? mealType = freezed,
    Object? loggedAt = freezed,
  }) {
    return _then(_$LoggedFoodModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      healthScore: freezed == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as double?,
      healthScoreDesc: freezed == healthScoreDesc
          ? _value.healthScoreDesc
          : healthScoreDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
      ingredients: freezed == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<IngredientModel>?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
      mealType: freezed == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String?,
      loggedAt: freezed == loggedAt
          ? _value.loggedAt
          : loggedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoggedFoodModelImpl implements _LoggedFoodModel {
  const _$LoggedFoodModelImpl(
      {this.id,
      this.userId,
      this.foodName,
      this.brandName,
      this.servingQty,
      this.servingUnit,
      this.servingWeightGrams,
      this.calorieKcal,
      this.fatG,
      this.carbsG,
      this.proteinG,
      this.nixBrandName,
      this.nixItemName,
      this.nixItemId,
      this.tagId,
      this.ingredientStatement,
      final List<FullNutrientsModel>? fullNutrients,
      final List<AltMeasureModel>? altMeasures,
      this.healthScore,
      this.healthScoreDesc,
      this.quantity,
      final List<IngredientModel>? ingredients,
      this.source,
      this.mealType,
      this.loggedAt})
      : _fullNutrients = fullNutrients,
        _altMeasures = altMeasures,
        _ingredients = ingredients;

  factory _$LoggedFoodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoggedFoodModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? userId;
  @override
  final String? foodName;
  @override
  final String? brandName;
  @override
  final double? servingQty;
  @override
  final String? servingUnit;
  @override
  final double? servingWeightGrams;
  @override
  final double? calorieKcal;
  @override
  final double? fatG;
  @override
  final double? carbsG;
  @override
  final double? proteinG;
  @override
  final String? nixBrandName;
  @override
  final String? nixItemName;
  @override
  final String? nixItemId;
  @override
  final String? tagId;
  @override
  final String? ingredientStatement;
  final List<FullNutrientsModel>? _fullNutrients;
  @override
  List<FullNutrientsModel>? get fullNutrients {
    final value = _fullNutrients;
    if (value == null) return null;
    if (_fullNutrients is EqualUnmodifiableListView) return _fullNutrients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<AltMeasureModel>? _altMeasures;
  @override
  List<AltMeasureModel>? get altMeasures {
    final value = _altMeasures;
    if (value == null) return null;
    if (_altMeasures is EqualUnmodifiableListView) return _altMeasures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? healthScore;
  @override
  final String? healthScoreDesc;
  @override
  final double? quantity;
  final List<IngredientModel>? _ingredients;
  @override
  List<IngredientModel>? get ingredients {
    final value = _ingredients;
    if (value == null) return null;
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? source;
  @override
  final String? mealType;
  @override
  final DateTime? loggedAt;

  @override
  String toString() {
    return 'LoggedFoodModel(id: $id, userId: $userId, foodName: $foodName, brandName: $brandName, servingQty: $servingQty, servingUnit: $servingUnit, servingWeightGrams: $servingWeightGrams, calorieKcal: $calorieKcal, fatG: $fatG, carbsG: $carbsG, proteinG: $proteinG, nixBrandName: $nixBrandName, nixItemName: $nixItemName, nixItemId: $nixItemId, tagId: $tagId, ingredientStatement: $ingredientStatement, fullNutrients: $fullNutrients, altMeasures: $altMeasures, healthScore: $healthScore, healthScoreDesc: $healthScoreDesc, quantity: $quantity, ingredients: $ingredients, source: $source, mealType: $mealType, loggedAt: $loggedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoggedFoodModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
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
                .equals(other._altMeasures, _altMeasures) &&
            (identical(other.healthScore, healthScore) ||
                other.healthScore == healthScore) &&
            (identical(other.healthScoreDesc, healthScoreDesc) ||
                other.healthScoreDesc == healthScoreDesc) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.loggedAt, loggedAt) ||
                other.loggedAt == loggedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
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
        const DeepCollectionEquality().hash(_altMeasures),
        healthScore,
        healthScoreDesc,
        quantity,
        const DeepCollectionEquality().hash(_ingredients),
        source,
        mealType,
        loggedAt
      ]);

  /// Create a copy of LoggedFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoggedFoodModelImplCopyWith<_$LoggedFoodModelImpl> get copyWith =>
      __$$LoggedFoodModelImplCopyWithImpl<_$LoggedFoodModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoggedFoodModelImplToJson(
      this,
    );
  }
}

abstract class _LoggedFoodModel implements LoggedFoodModel {
  const factory _LoggedFoodModel(
      {final int? id,
      final String? userId,
      final String? foodName,
      final String? brandName,
      final double? servingQty,
      final String? servingUnit,
      final double? servingWeightGrams,
      final double? calorieKcal,
      final double? fatG,
      final double? carbsG,
      final double? proteinG,
      final String? nixBrandName,
      final String? nixItemName,
      final String? nixItemId,
      final String? tagId,
      final String? ingredientStatement,
      final List<FullNutrientsModel>? fullNutrients,
      final List<AltMeasureModel>? altMeasures,
      final double? healthScore,
      final String? healthScoreDesc,
      final double? quantity,
      final List<IngredientModel>? ingredients,
      final String? source,
      final String? mealType,
      final DateTime? loggedAt}) = _$LoggedFoodModelImpl;

  factory _LoggedFoodModel.fromJson(Map<String, dynamic> json) =
      _$LoggedFoodModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get userId;
  @override
  String? get foodName;
  @override
  String? get brandName;
  @override
  double? get servingQty;
  @override
  String? get servingUnit;
  @override
  double? get servingWeightGrams;
  @override
  double? get calorieKcal;
  @override
  double? get fatG;
  @override
  double? get carbsG;
  @override
  double? get proteinG;
  @override
  String? get nixBrandName;
  @override
  String? get nixItemName;
  @override
  String? get nixItemId;
  @override
  String? get tagId;
  @override
  String? get ingredientStatement;
  @override
  List<FullNutrientsModel>? get fullNutrients;
  @override
  List<AltMeasureModel>? get altMeasures;
  @override
  double? get healthScore;
  @override
  String? get healthScoreDesc;
  @override
  double? get quantity;
  @override
  List<IngredientModel>? get ingredients;
  @override
  String? get source;
  @override
  String? get mealType;
  @override
  DateTime? get loggedAt;

  /// Create a copy of LoggedFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoggedFoodModelImplCopyWith<_$LoggedFoodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
