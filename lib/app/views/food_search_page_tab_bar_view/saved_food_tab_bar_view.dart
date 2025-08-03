import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/utils/mixins/error_handling_mixin.dart';
import 'package:flux/app/viewmodels/food_search_vm/food_search_view_model.dart';
import 'package:flux/app/widgets/food/food_display_card.dart';
import 'package:flux/app/widgets/skeleton/food_list_skeleton.dart';

class SavedFoodTabBarView extends StatefulWidget {
  const SavedFoodTabBarView({required this.onFoodCardPressed, super.key});

  final void Function(FoodResponseModel) onFoodCardPressed;

  @override
  State<SavedFoodTabBarView> createState() => _SavedFoodTabBarViewState();
}

class _SavedFoodTabBarViewState extends State<SavedFoodTabBarView> with ErrorHandlingMixin {
  @override
  void initState() {
    super.initState();
    getSavedFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyles.kPaddSH16,
      child: CustomScrollView(
        slivers: [getHeader(context), getFoodSliverList(context)],
      ),
    );
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on _SavedFoodTabBarViewState {
  void getSavedFoods() async {
    await tryCatch(context, () => context.read<FoodSearchViewModel>().getSavedFoods());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SavedFoodTabBarViewState {
  // Header
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
                spacing: AppStyles.kSpac8,
                children: [
                  Expanded(
                    child: Column(
                      spacing: AppStyles.kSpac4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [getHeaderLabel(context), getHeaderDescriptionLabel(context)],
                    ),
                  ),
                  getSaveContainer(context)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Food Sliver List
  Widget getFoodSliverList(BuildContext context) {
    final savedFoodResults = context.select((FoodSearchViewModel vm) => vm.savedFoodResults);
    final isSavedFoodLoading = context.select((FoodSearchViewModel vm) => vm.isSavedFoodLoading);

    if (isSavedFoodLoading) {
      return FoodListSkeleton();
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final food = savedFoodResults[index];
          return Padding(
            padding: index == 0 ? AppStyles.kPaddSV12 : AppStyles.kPaddOB12,
            child: FoodDisplayCard(
              foodName: food.foodName ?? '',
              calories: food.calorieKcal ?? 0,
              servingUnit: food.servingUnit ?? '',
              servingQuantity: food.servingQty ?? 0,
              brandName: food.brandName ?? '',
              onCardPressed: () => widget.onFoodCardPressed(
                FoodResponseModel(
                  tagId: food.tagId,
                  foodName: food.foodName,
                  brandName: food.brandName,
                  calorieKcal: food.calorieKcal,
                  servingQty: food.servingQty,
                  servingUnit: food.servingUnit,
                  brandNameItemName: food.brandNameItemName,
                  nixItemId: food.nixItemId,
                ),
              ),
            ),
          );
        },
        childCount: savedFoodResults.length,
      ),
    );
  }

  // Save Container
  Widget getSaveContainer(BuildContext context) {
    return Container(
      padding: AppStyles.kPadd6,
      decoration: _Styles.getSaveContainerDecoration(context),
      child: Icon(Icons.bookmark_add_outlined),
    );
  }

  // Header Label
  Widget getHeaderLabel(BuildContext context) {
    return Text(
      S.current.saveYourFoodLabel,
      style: _Styles.getHeaderLabelTextStyle(context),
      textAlign: TextAlign.center,
    );
  }

  // Header Description Label
  Widget getHeaderDescriptionLabel(BuildContext context) {
    return Text(
      S.current.saveYourFoodDesc,
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
    return AltmannGrotesk.bold.withSize(FontSizes.small);
  }

  // Header Description Label Text Style
  static TextStyle getHeaderDescriptionLabelTextStyle(BuildContext context) {
    return AltmannGrotesk.light.withSize(FontSizes.extraSmall);
  }

  // Save Container Decoration
  static BoxDecoration getSaveContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryFixedDim,
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }
}
