import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/widgets/food/meal_food_display_card.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MealDiaryCard extends StatefulWidget {
  const MealDiaryCard({
    super.key,
    required this.mealType,
    required this.meals,
    required this.selectedDate,
    required this.getLoggedFoods,
  });

  final MealType mealType;
  final List<LoggedFoodModel> meals;
  final DateTime selectedDate;
  final VoidCallback getLoggedFoods;

  @override
  State<MealDiaryCard> createState() => _MealDiaryCardState();
}

class _MealDiaryCardState extends State<MealDiaryCard> {
  bool _isExpanded = false;

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
            if (_isExpanded) getMealListView(context),
          ],
        ),
      ),
    );
  }

  // Enable Set State inside Extension
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MealDiaryCardState {
  void _onHeaderTap(BuildContext context) {
    context.router.push(MealDetailsRoute(mealType: widget.mealType, selectedDate: widget.selectedDate)).then((result) {
      if (result == true) {
        widget.getLoggedFoods();
      }
    });
  }

  void _onLoggedFoodTap(LoggedFoodModel loggedFood, BuildContext context) {
    if (loggedFood.source == LogSource.foodSearch.value) {
      context.router.push(FoodSearchLoggedFoodDetailsRoute(loggedFood: loggedFood)).then((result) {
        if (result == true) {
          widget.getLoggedFoods();
        }
      });
    } else {
      context.router.push(MealScanLoggedFoodNavigatorRoute(loggedFood: loggedFood)).then((result) {
        if (result == true) {
          widget.getLoggedFoods();
        }
      });
    }
  }

  void _toggleExpanded() {
    _setState(() {
      _isExpanded = !_isExpanded;
    });
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MealDiaryCardState {
  // Header Container
  Widget getHeaderContainer(BuildContext context) {
    final totalNutrition = FunctionUtils.calculateTotalNutrition(widget.meals);
    return Container(
      padding: AppStyles.kPaddSV12H16,
      child: Row(
        spacing: AppStyles.kSpac4,
        children: [
          Column(
            spacing: AppStyles.kSpac4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getMealTypeLabel(context),
              Row(
                spacing: AppStyles.kSpac4,
                children: [
                  getCalorieTag(context, totalNutrition[Nutrition.calorie.key] ?? 0),
                  getProteinTag(context, totalNutrition[Nutrition.protein.key] ?? 0),
                  getCarbsTag(context, totalNutrition[Nutrition.carbs.key] ?? 0),
                  getFatTag(context, totalNutrition[Nutrition.fat.key] ?? 0),
                ],
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: _toggleExpanded,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _isExpanded ? 0.5 : 0,
              child: Container(
                padding: AppStyles.kPadd6,
                child: FaIcon(
                  FontAwesomeIcons.chevronDown,
                  color: context.theme.colorScheme.primary,
                  size: AppStyles.kSize16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Meal Type Label
  Widget getMealTypeLabel(BuildContext context) {
    return Text(widget.mealType.label, style: _Styles.getMealTypeLabelTextStyle(context));
  }

  // Calorie Tag
  Widget getCalorieTag(BuildContext context, int value) {
    return NutritionTag(label: '$value', icon: FaIcon(FontAwesomeIcons.fire, size: AppStyles.kSize10));
  }

  // Protein Tag
  Widget getProteinTag(BuildContext context, int value) {
    return NutritionTag(label: '$value', tag: MacroNutrients.protein.tag);
  }

  // Carbs Tag
  Widget getCarbsTag(BuildContext context, int value) {
    return NutritionTag(label: '$value', tag: MacroNutrients.carbs.tag);
  }

  // Fat Tag
  Widget getFatTag(BuildContext context, int value) {
    return NutritionTag(label: '$value', tag: MacroNutrients.fat.tag);
  }

  // Meal List View
  Widget getMealListView(BuildContext context) {
    return widget.meals.isNotEmpty
        ? ListView.separated(
            padding: AppStyles.kPadd16,
            itemCount: widget.meals.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final meal = widget.meals[index];
              return MealFoodDisplayCard(meal: meal, onLoggedFoodTap: () => _onLoggedFoodTap(meal, context));
            },
            separatorBuilder: (_, __) => const SizedBox(height: AppStyles.kSize12),
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Text('No meals logged', style: Theme.of(context).textTheme.bodySmall),
          );
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
