import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/food/nutrition_tag.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FoodDisplayCard extends StatelessWidget {
  const FoodDisplayCard({
    required this.calories,
    required this.foodName,
    required this.servingUnit,
    required this.servingQuantity,
    required this.onCardPressed,
    super.key,
  });

  final double calories;
  final String foodName;
  final String servingUnit;
  final double servingQuantity;
  final VoidCallback onCardPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardPressed,
      child: Container(
        decoration: _Styles.getFoodCardContainerDecoration(context),
        child: Padding(padding: AppStyles.kPaddSV16H16, child: getContentRow(context)),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on FoodDisplayCard {
  // Content Row
  Widget getContentRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppStyles.kSpac4,
            children: [getTitleLabel(context), getTagRow(context)],
          ),
        ),
        FaIcon(FontAwesomeIcons.chevronRight, size: AppStyles.kIconSize16)
      ],
    );
  }

  // Tag Row
  Widget getTagRow(BuildContext context) {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [getServingTag(context), getCalorieTag(context)],
    );
  }

  // Title Label
  Widget getTitleLabel(BuildContext context) {
    return Text(
      foodName,
      style: _Styles.getTitleLabelTextStyle(context),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }

  // Description Label
  // Widget getDescriptionLabel(BuildContext context) {
  //   return Text(
  //     '$servingQuantity $servingUnit',
  //     style: _Styles.getDescriptionTextStyle(context),
  //     maxLines: 1,
  //     overflow: TextOverflow.ellipsis,
  //     softWrap: false,
  //   );
  // }

  // Serving Tag
  Widget getServingTag(BuildContext context) {
    return NutritionTag(
      tag: servingUnit,
      label: servingQuantity.toString(),
    );
  }

  // Calorie Tag
  Widget getCalorieTag(BuildContext context) {
    return NutritionTag(
      label: calories.toString(),
      icon: FaIcon(
        FontAwesomeIcons.fire,
        size: AppStyles.kIconSize16,
      ),
    );
  }

  // Icon Container
  // Widget getIconContainer(BuildContext context) {
  //   return GestureDetector(
  //     onTap: onCardPressed,
  //     child: Container(
  //       width: 32,
  //       height: 32,
  //       decoration: _Styles.getIconContainerDecoration(context),
  //       child: Center(child: getIcon(context)),
  //     ),
  //   );
  // }

  // Get Icon
  // Widget getIcon(BuildContext context) {
  //   return FaIcon(
  //     FontAwesomeIcons.add,
  //     size: AppStyles.kIconSize20,
  //     color: context.theme.colorScheme.onPrimary,
  //   );
  // }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getFoodCardContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Title Label Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }

  // Description Text Style
  // static TextStyle getDescriptionTextStyle(BuildContext context) {
  //   return Quicksand.regular.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  // }

  // Icon Container Decoration
  // static BoxDecoration getIconContainerDecoration(BuildContext context) {
  //   return BoxDecoration(
  //     color: context.theme.colorScheme.secondary,
  //     borderRadius: AppStyles.kRad100,
  //   );
  // }
}
