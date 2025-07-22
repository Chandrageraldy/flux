import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_model/food_model.dart';
import 'package:flux/app/viewmodels/food_vm/food_view_model.dart';
import 'package:flux/app/widgets/food/food_action_header.dart';
import 'package:flux/app/widgets/food/food_display_card.dart';

import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class FoodSearchPage extends StatelessWidget {
  const FoodSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => FoodViewModel(), child: _FoodSearchPage());
  }
}

class _FoodSearchPage extends BaseStatefulPage {
  @override
  State<_FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends BaseStatefulState<_FoodSearchPage> {
  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  @override
  Widget body() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [getHeaderContainer(), getTabBarView()],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _FoodSearchPageState {
  void _onBarcodeScannerPressed() {}

  void _onFoodCardPressed(FoodModel food) {
    context.router.push(FoodDetailsRoute(food: food));
  }

  void _onSubmitted(String value) async {
    await tryCatch(context, () => context.read<FoodViewModel>().searchInstant(value));
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _FoodSearchPageState {
  // Header Container
  Widget getHeaderContainer() {
    return Container(
      padding: AppStyles.kPaddSV12H20,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Column(
        children: [
          AppStyles.kSizedBoxH20,
          Row(
            children: [Expanded(child: getSearchTextFormField()), AppStyles.kSizedBoxW12, getBarcodeScannerButton()],
          ),
          AppStyles.kSizedBoxH12,
          getTabBarContainer(),
        ],
      ),
    );
  }

  // Search Text Form Field
  Widget getSearchTextFormField() {
    return AppTextFormField(
      field: FormFields.search,
      placeholder: S.current.searchFoodPlaceholder,
      validator: FormBuilderValidators.compose([]),
      icon: FaIcon(FontAwesomeIcons.search, size: AppStyles.kIconSize16),
      onSubmitted: _onSubmitted,
    );
  }

  // Barcode Scanner Button
  Widget getBarcodeScannerButton() {
    return GestureDetector(
      onTap: _onBarcodeScannerPressed,
      child: Container(
        height: AppStyles.kSize48,
        width: AppStyles.kSize48,
        decoration: BoxDecoration(color: context.theme.colorScheme.tertiaryFixedDim, borderRadius: AppStyles.kRad10),
        child: Icon(Icons.qr_code_scanner, color: context.theme.colorScheme.primary),
      ),
    );
  }

  // Tabs Container
  Widget getTabBarContainer() {
    return Container(
      height: AppStyles.kSize30,
      decoration: _Styles.getTabBarContainerDecoration(context),
      child: TabBar(
        indicator: _Styles.getTabBarIndicatorDecoration(context),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: context.theme.colorScheme.onPrimary,
        unselectedLabelColor: context.theme.colorScheme.onTertiary,
        tabs: [Tab(text: S.current.allLabel), Tab(text: S.current.myMealsLabel), Tab(text: S.current.favoritesLabel)],
      ),
    );
  }

  // Tab Bar View
  Widget getTabBarView() {
    return Expanded(
      child: TabBarView(
        children: [getAllTabBarView(), getMyMealsTabBarView(), getFavoritesTabBarView()],
      ),
    );
  }

  // Tab Bar View -> "All"
  Widget getAllTabBarView() {
    return Padding(
      padding: AppStyles.kPaddSH20,
      child: CustomScrollView(
        slivers: [getFoodActionHeader(), getFoodSliverList()],
      ),
    );
  }

  // Food Action Header
  Widget getFoodActionHeader() {
    return SliverToBoxAdapter(
      child: Column(
        children: [AppStyles.kSizedBoxH12, getFoodActionHeaderRow(), AppStyles.kSizedBoxH12],
      ),
    );
  }

  // Food Action Header Row
  Widget getFoodActionHeaderRow() {
    return Row(
      children: [
        Expanded(
          child: FoodActionHeader(
            title: S.current.scanABarcodeLabel,
            icon: FaIcon(
              FontAwesomeIcons.barcode,
              size: AppStyles.kIconSize25,
              color: context.theme.colorScheme.primary,
            ),
            onPressed: _onBarcodeScannerPressed,
          ),
        ),
        AppStyles.kSizedBoxW12,
        Expanded(
          child: FoodActionHeader(
            title: S.current.describeAMealLabel,
            icon: FaIcon(
              FontAwesomeIcons.keyboard,
              size: AppStyles.kIconSize25,
              color: context.theme.colorScheme.primary,
            ),
            onPressed: _onBarcodeScannerPressed,
          ),
        ),
      ],
    );
  }

  // Food Sliver List
  Widget getFoodSliverList() {
    final foodSearchResults = context.select((FoodViewModel vm) => vm.foodSearchResults);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final food = foodSearchResults[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: FoodDisplayCard(
              foodName: food.foodName ?? '',
              calories: food.calorieKcal ?? 0,
              servingUnit: food.servingUnit ?? '',
              servingQuantity: food.servingQty ?? 0,
              onCardPressed: () {},
            ),
          );
        },
        childCount: foodSearchResults.length,
      ),
    );
  }

  // Tab Bar View -> "My Meals"
  Widget getMyMealsTabBarView() {
    return Center(child: Text(S.current.myMealsLabel));
  }

  // Tab Bar View -> "Favorites"
  Widget getFavoritesTabBarView() {
    return Center(child: Text(S.current.favoritesLabel));
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Header Container Decoration
  static BoxDecoration getHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOBL20BR20,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Tab Bar Container Decoration
  static BoxDecoration getTabBarContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad10,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 4, offset: const Offset(0, 2)),
      ],
    );
  }

  // Tab Bar Indicator Decoration
  static BoxDecoration getTabBarIndicatorDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.primary,
      borderRadius: AppStyles.kRad10,
    );
  }
}
