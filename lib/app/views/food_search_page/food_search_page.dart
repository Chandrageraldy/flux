import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/viewmodels/food_search_vm/food_search_view_model.dart';
import 'package:flux/app/views/food_search_page_tab_bar_view/all_tab_bar_view.dart';
import 'package:flux/app/views/food_search_page_tab_bar_view/saved_food_tab_bar_view.dart';
import 'package:flux/app/widgets/text_form_field/app_text_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class FoodSearchPage extends StatelessWidget {
  const FoodSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => FoodSearchViewModel(), child: _FoodSearchPage());
  }
}

class _FoodSearchPage extends BaseStatefulPage {
  @override
  State<_FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends BaseStatefulState<_FoodSearchPage> {
  @override
  EdgeInsets defaultPadding() => AppStyles.kPadd0;

  late ScrollController _scrollController;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _getRecentFoods();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget body() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [getHeaderContainer(), getTabBarView()],
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _FoodSearchPageState {
  void _onBarcodeScannerPressed() {
    context.router.push(ScanBarcodeRoute());
  }

  void _onMealScanPressed() {}

  void _onFoodCardPressed(FoodResponseModel foodResponseModel) {
    context.router.push(FoodDetailsRoute(foodResponseModel: foodResponseModel, fromAllTab: true));
  }

  void _onFoodCardPressedFromSavedTab(FoodResponseModel foodResponseModel) {
    context.router.push(FoodDetailsRoute(foodResponseModel: foodResponseModel, fromAllTab: true)).then((_) {
      if (mounted) {
        tryCatch(context, () => context.read<FoodSearchViewModel>().getSavedFoods());
      }
    });
  }

  void _onChanged(String? value) async {
    if (value == null || value.isEmpty) {
      _getRecentFoods();
      return;
    }

    await tryCatch(context, () => context.read<FoodSearchViewModel>().searchInstant(value));

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _getRecentFoods() async {
    await tryCatch(context, () => context.read<FoodSearchViewModel>().getRecentFoods());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _FoodSearchPageState {
  // Header Container
  Widget getHeaderContainer() {
    return Container(
      padding: AppStyles.kPaddSV12H16,
      decoration: _Styles.getHeaderContainerDecoration(context),
      child: Column(
        children: [
          Row(
            children: [Expanded(child: getSearchTextFormField()), AppStyles.kSizedBoxW4, getBarcodeScannerButton()],
          ),
          AppStyles.kSizedBoxH12,
          getTabBarContainer(),
        ],
      ),
    );
  }

  // Search Text Form Field
  Widget getSearchTextFormField() {
    return FormBuilder(
      key: _formKey,
      child: AppTextFormField(
        field: FormFields.search,
        placeholder: S.current.searchFoodPlaceholder,
        validator: FormBuilderValidators.compose([]),
        icon: FaIcon(FontAwesomeIcons.search, size: AppStyles.kSize16),
        height: AppStyles.kSize40,
        onChanged: _onChanged,
      ),
    );
  }

  // Barcode Scanner Button
  Widget getBarcodeScannerButton() {
    return GestureDetector(
      onTap: _onBarcodeScannerPressed,
      child: Container(
        height: AppStyles.kSize40,
        width: AppStyles.kSize40,
        decoration: _Styles.getBarcodeScannerContainerDecoration(context),
        child: Icon(Icons.qr_code_scanner, color: context.theme.colorScheme.primary, size: AppStyles.kSize20),
      ),
    );
  }

  // Tabs Container
  Widget getTabBarContainer() {
    return Container(
      height: AppStyles.kSize26,
      decoration: _Styles.getTabBarContainerDecoration(context),
      child: TabBar(
        indicator: _Styles.getTabBarIndicatorDecoration(context),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: context.theme.colorScheme.onPrimary,
        unselectedLabelColor: context.theme.colorScheme.onTertiary,
        labelStyle: Quicksand.medium.withSize(FontSizes.small),
        tabs: [Tab(text: S.current.allLabel), Tab(text: S.current.savedLabel)],
      ),
    );
  }

  // Tab Bar View
  Widget getTabBarView() {
    return Expanded(
      child: TabBarView(
        children: [getAllTabBarView(), getSavedTabBarView()],
      ),
    );
  }

  // Tab Bar View -> "All"
  Widget getAllTabBarView() {
    return AllTabBarView(
      scrollController: _scrollController,
      onFoodCardPressed: _onFoodCardPressed,
      onMealScanPressed: _onMealScanPressed,
      onRefresh: _getRecentFoods,
    );
  }

  // Tab Bar View -> "My Meals"
  // Widget getMyMealsTabBarView() {
  //   return Center(child: Text(S.current.myMealsLabel));
  // }

  // Tab Bar View -> "Saved"
  Widget getSavedTabBarView() {
    return SavedFoodTabBarView(onFoodCardPressed: _onFoodCardPressedFromSavedTab);
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Header Container Decoration
  static BoxDecoration getHeaderContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.onPrimary,
      borderRadius: AppStyles.kRadOBL15BR15,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Tab Bar Container Decoration
  static BoxDecoration getTabBarContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.tertiaryContainer,
      borderRadius: AppStyles.kRad100,
      boxShadow: [
        BoxShadow(color: context.theme.colorScheme.tertiaryFixedDim, blurRadius: 2, offset: const Offset(0, 1)),
      ],
    );
  }

  // Tab Bar Indicator Decoration
  static BoxDecoration getTabBarIndicatorDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.theme.colorScheme.secondary,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Barcode Scanner Container Decoration
  static BoxDecoration getBarcodeScannerContainerDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.tertiaryFixedDim, borderRadius: AppStyles.kRad100);
  }
}
