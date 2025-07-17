import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/food/meal_food_display_card.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealDiaryCard extends StatelessWidget {
  const MealDiaryCard({required this.mealType, super.key});

  final String mealType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _Styles.getContainerDecoration(context),
      width: AppStyles.kDoubleInfinity,
      child: Column(
        children: [
          getHeaderContainer(context),
          getDivider(context),
          ListView.separated(
            padding: AppStyles.kPaddSV16H20,
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => MealFoodDisplayCard(),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          ),
        ],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on MealDiaryCard {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on MealDiaryCard {
  // Header Container
  Widget getHeaderContainer(BuildContext context) {
    return Container(
      padding: AppStyles.kPaddSV16H20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  getMealTypeLabel(context),
                  AppStyles.kSizedBoxW8,
                  getCalorieTag(context),
                ],
              ),
            ],
          ),
          getIconContainer(context)
        ],
      ),
    );
  }

  // Meal Type Label
  Widget getMealTypeLabel(BuildContext context) {
    return Text(mealType, style: _Styles.getMealTypeLabelTextStyle(context));
  }

  // Calorie Tag
  Widget getCalorieTag(BuildContext context) {
    return NutritionTag(
      tag: S.current.calorieUnit,
      label: '500/360',
      icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kIconSize16),
    );
  }

  // Icon Container
  Widget getIconContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: AppStyles.kSize32,
        height: AppStyles.kSize32,
        decoration: _Styles.getIconContainerDecoration(context),
        child: Center(child: getIcon(context)),
      ),
    );
  }

  // Get Icon
  Widget getIcon(BuildContext context) {
    return FaIcon(
      FontAwesomeIcons.add,
      size: AppStyles.kIconSize20,
      color: context.theme.colorScheme.onPrimary,
    );
  }

  // Get Divider
  Widget getDivider(BuildContext context) {
    return Divider(
      height: 1,
      color: context.theme.colorScheme.tertiaryFixedDim,
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.onPrimary, borderRadius: AppStyles.kRad10, boxShadow: [
      BoxShadow(
        color: context.theme.colorScheme.tertiaryFixedDim,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ]);
  }

  // Icon Container Decoration
  static BoxDecoration getIconContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.secondary,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Meal Type Label Text Style
  static TextStyle getMealTypeLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.large).copyWith(color: context.theme.colorScheme.primary);
  }
}
