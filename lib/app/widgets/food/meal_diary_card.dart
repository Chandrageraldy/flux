import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/food/meal_food_display_card.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealDiaryCard extends StatelessWidget {
  const MealDiaryCard({required this.mealType, super.key});

  final MealType mealType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onHeaderTap(context),
      child: Container(
        decoration: _Styles.getContainerDecoration(context),
        width: AppStyles.kDoubleInfinity,
        child: Column(
          children: [
            getHeaderContainer(context),
            getDivider(context),
            ListView.separated(
              padding: AppStyles.kPaddSV16H12,
              itemCount: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => MealFoodDisplayCard(),
              separatorBuilder: (context, index) => const SizedBox(height: 12),
            ),
            getDivider(context),
            getAddToButton(context)
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on MealDiaryCard {
  void _onHeaderTap(BuildContext context) {
    context.router.push(MealDetailsRoute(mealType: mealType));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealDiaryCard {
  // Header Container
  Widget getHeaderContainer(BuildContext context) {
    return Container(
      padding: AppStyles.kPaddSV12H20,
      child: Row(
        spacing: AppStyles.kSpac8,
        children: [
          getMealTypeLabel(context),
          getCalorieTag(context),
          NutritionTag(tag: MacroNutrients.protein.tag, label: '31'),
          NutritionTag(tag: MacroNutrients.carbs.tag, label: '20'),
          NutritionTag(tag: MacroNutrients.fat.tag, label: '62'),
        ],
      ),
    );
  }

  // Meal Type Label
  Widget getMealTypeLabel(BuildContext context) {
    return Text(mealType.label, style: _Styles.getMealTypeLabelTextStyle(context));
  }

  // Calorie Tag
  Widget getCalorieTag(BuildContext context) {
    return NutritionTag(
      label: '500/360',
      icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kIconSize12),
    );
  }

  // Divider
  Widget getDivider(BuildContext context) {
    return Divider(
      height: 1,
      color: context.theme.colorScheme.tertiaryFixedDim,
    );
  }

  // Add To Button
  Widget getAddToButton(BuildContext context) {
    return Container(
      padding: AppStyles.kPaddSV10,
      child: Text('+ ADD TO ${mealType.label.toUpperCase()}', style: _Styles.getAddToButtonTextStyle(context)),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.onPrimary, borderRadius: AppStyles.kRad10, boxShadow: [
      BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
    ]);
  }

  // Meal Type Label Text Style
  static TextStyle getMealTypeLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }

  // Add To Button Label Text Style
  static TextStyle getAddToButtonTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }
}
