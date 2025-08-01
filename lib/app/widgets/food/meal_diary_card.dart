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
            ListView.separated(
              padding: AppStyles.kPadd16,
              itemCount: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => MealFoodDisplayCard(),
              separatorBuilder: (context, index) => const SizedBox(height: AppStyles.kSize12),
            ),
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
      padding: AppStyles.kPaddOL16R16T16,
      child: Row(
        spacing: AppStyles.kSpac4,
        children: [
          getMealTypeLabel(context),
          getCalorieTag(context),
          getProteinTag(context),
          getCarbsTag(context),
          getFatTag(context),
          Spacer(),
          Container(
            padding: AppStyles.kPadd6,
            decoration: BoxDecoration(color: context.theme.colorScheme.secondary, shape: BoxShape.circle),
            child: FaIcon(FontAwesomeIcons.add, color: context.theme.colorScheme.onSecondary, size: AppStyles.kSize16),
          )
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
    return NutritionTag(label: '500/360', icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize10));
  }

  // Protein Tag
  Widget getProteinTag(BuildContext context) {
    return NutritionTag(tag: MacroNutrients.protein.tag, label: '31');
  }

  // Carbs Tag
  Widget getCarbsTag(BuildContext context) {
    return NutritionTag(tag: MacroNutrients.carbs.tag, label: '20');
  }

  // Fat Tag
  Widget getFatTag(BuildContext context) {
    return NutritionTag(tag: MacroNutrients.fat.tag, label: '62');
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Meal Type Label Text Style
  static TextStyle getMealTypeLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withCustomSize(13).copyWith(color: context.theme.colorScheme.primary);
  }
}
