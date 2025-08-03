import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/viewmodels/food_search_vm/food_search_view_model.dart';
import 'package:flux/app/widgets/food/food_display_card.dart';

class AllTabBarView extends StatelessWidget {
  final ScrollController scrollController;
  final void Function(FoodResponseModel) onFoodCardPressed;
  final VoidCallback onMealScanPressed;

  const AllTabBarView({
    super.key,
    required this.scrollController,
    required this.onFoodCardPressed,
    required this.onMealScanPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: CustomScrollView(
        controller: scrollController,
        slivers: [getHeader(context), getFoodSliverList(context)],
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on AllTabBarView {
  // Food Sliver List
  Widget getFoodSliverList(BuildContext context) {
    final foodSearchResults = context.select((FoodSearchViewModel vm) => vm.foodSearchResults);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final food = foodSearchResults[index];
          return Padding(
            padding: index == 0 ? AppStyles.kPaddSV12 : AppStyles.kPaddOB12,
            child: FoodDisplayCard(
              foodName: food.foodName ?? '',
              calories: food.calorieKcal ?? 0,
              servingUnit: food.servingUnit ?? '',
              servingQuantity: food.servingQty ?? 0,
              brandName: food.brandName ?? '',
              onCardPressed: () => onFoodCardPressed(food),
            ),
          );
        },
        childCount: foodSearchResults.length,
      ),
    );
  }

  // Food Action Header
  Widget getHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          AppStyles.kSizedBoxH12,
          Container(
            decoration: _Styles.getHeaderContainerDecoration(context),
            width: AppStyles.kDoubleInfinity,
            child: Padding(
              padding: AppStyles.kPaddSV12H16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      spacing: AppStyles.kSpac4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [getHeaderLabel(context), getHeaderDescriptionLabel(context)],
                    ),
                  ),
                  getMealScanButton(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Meal Scan Button
  Widget getMealScanButton(BuildContext context) {
    return Container(
      padding: AppStyles.kPadd6,
      decoration: _Styles.getMealScanContainerDecoration(context),
      child: Icon(Icons.camera_enhance),
    );
  }

  // Header Label
  Widget getHeaderLabel(BuildContext context) {
    return Text(
      S.current.scanYourMealLabel,
      style: _Styles.getHeaderLabelTextStyle(context),
      textAlign: TextAlign.center,
    );
  }

  // Header Description Label
  Widget getHeaderDescriptionLabel(BuildContext context) {
    return Text(
      S.current.scanYourMealDesc,
      style: _Styles.getHeaderDescriptionLabelTextStyle(context),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Header Container Decoration
  static BoxDecoration getHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Header Label Text Style
  static TextStyle getHeaderLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small);
  }

  // Header Description Label Text Style
  static TextStyle getHeaderDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.regular.withSize(FontSizes.extraSmall);
  }

  // Save Container Decoration
  static BoxDecoration getMealScanContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryFixedDim,
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }
}
