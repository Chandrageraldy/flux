// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_ratio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealRatioModelImpl _$$MealRatioModelImplFromJson(Map<String, dynamic> json) =>
    _$MealRatioModelImpl(
      calorieKcal: (json['calorieKcal'] as num?)?.toDouble(),
      proteinG: (json['proteinG'] as num?)?.toDouble(),
      fatG: (json['fatG'] as num?)?.toDouble(),
      carbsG: (json['carbsG'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MealRatioModelImplToJson(
        _$MealRatioModelImpl instance) =>
    <String, dynamic>{
      'calorieKcal': instance.calorieKcal,
      'proteinG': instance.proteinG,
      'fatG': instance.fatG,
      'carbsG': instance.carbsG,
    };
