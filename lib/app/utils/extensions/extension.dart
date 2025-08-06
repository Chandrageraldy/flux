import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/models/recent_food_model.dart/recent_food_model.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  DateTime toDateTime(String format) {
    return DateFormat(format).parse(this);
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString(String format) {
    return DateFormat(format).format(this);
  }
}

extension RecentFoodMapper on RecentFoodModel {
  FoodResponseModel toFoodResponseModel() {
    return FoodResponseModel(
      foodName: foodName,
      calorieKcal: calorieKcal,
      servingUnit: servingUnit,
      servingQty: servingQty,
      brandName: brandName,
      nixItemId: nixItemId,
      tagId: tagId,
      // Add any other fields you use
    );
  }
}
