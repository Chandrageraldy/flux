import 'package:camera/camera.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_response_model/food_response_model.dart';
import 'package:flux/app/models/ingredient_model/ingredient_model.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/views/app_entry_page/splash_screen.dart';
import 'package:flux/app/views/auth_page/login_page.dart';
import 'package:flux/app/views/auth_page/signup_page.dart';
import 'package:flux/app/views/daily_report_page/daily_report_page.dart';
import 'package:flux/app/views/dashboard_page/dashboard_navigator_page.dart';
import 'package:flux/app/views/dashboard_page/dashboard_page.dart';
import 'package:flux/app/views/diary_page/diary_page.dart';
import 'package:flux/app/views/error_modal/error_modal.dart';
import 'package:flux/app/views/food_details_page/food_details_page.dart';
import 'package:flux/app/views/food_search_page/food_search_page.dart';
import 'package:flux/app/views/ingredient_details_page.dart/ingredient_details_page.dart';
import 'package:flux/app/views/logged_food_page/food_search_logged_food_details_page.dart';
import 'package:flux/app/views/logged_food_page/logged_food_ingredient_details_page.dart';
import 'package:flux/app/views/logged_food_page/meal_scan_logged_food_details_page.dart';
import 'package:flux/app/views/logged_food_page/meal_scan_logged_food_navigator_page.dart';
import 'package:flux/app/views/meal_scan_page/meal_scan_page.dart';
import 'package:flux/app/views/meal_scan_result_page.dart/meal_scan_navigator_page.dart';
import 'package:flux/app/views/meal_scan_result_page.dart/meal_scan_result_page.dart';
import 'package:flux/app/views/personalizing_plan_loading_page/personalizing_plan_loading_page.dart';
import 'package:flux/app/views/logging_selection_modal/logging_selection_modal.dart';
import 'package:flux/app/views/manual_plan_setup_page/manual_plan_setup_page.dart';
import 'package:flux/app/views/meal_details_page/meal_details_page.dart';
import 'package:flux/app/views/profile_page/account_page.dart';
import 'package:flux/app/views/profile_page/meal_ratio_page.dart';
import 'package:flux/app/views/profile_page/nutrition_goals_page.dart';
import 'package:flux/app/views/profile_page/personal_details_page.dart';
import 'package:flux/app/views/profile_page/profile_page.dart';
import 'package:flux/app/views/plan_selection_modal/plan_selection_modal.dart';
import 'package:flux/app/views/progress_page/progress_page.dart';
import 'package:flux/app/views/root_page/root_page.dart';
import 'package:flux/app/views/root_page/root_navigator_page.dart';
import 'package:flux/app/views/barcode_scan_page.dart/barcode_scan_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen|Modal,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: RootNavigatorRoute.page,
          initial: true,
          children: [
            ...getAppEntryRoutes(),
            getDashboardRoutes(),
          ],
        ),
      ];

  List<AutoRoute> getAppEntryRoutes() {
    return [
      AutoRoute(page: SplashRoute.page, initial: true),
      AutoRoute(page: RootRoute.page),
      CustomRoute(page: PlanSelectionRoute.page, customRouteBuilder: _modalSheetBuilder),
      AutoRoute(page: LoginRoute.page),
      AutoRoute(page: SignUpRoute.page),
      AutoRoute(page: ManualPlanSetupRoute.page),
      AutoRoute(page: PersonalizingPlanLoadingRoute.page),
    ];
  }

  AutoRoute getDashboardRoutes() {
    return AutoRoute(
      page: DashboardNavigatorRoute.page,
      children: [
        AutoRoute(
          page: DashboardRoute.page,
          initial: true,
          children: [
            AutoRoute(page: ProgressRoute.page, initial: true),
            AutoRoute(page: DiaryRoute.page),
            AutoRoute(page: LoggingSelectionRoute.page),
            AutoRoute(page: FoodSearchRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        CustomRoute(page: LoggingSelectionRoute.page, customRouteBuilder: _modalSheetBuilder),
        AutoRoute(page: FoodDetailsRoute.page),
        AutoRoute(page: MealDetailsRoute.page),
        AutoRoute(page: BarcodeScanRoute.page),
        CustomRoute(page: ErrorRoute.page, customRouteBuilder: _modalSheetBuilder),
        AutoRoute(page: PersonalDetailsRoute.page),
        AutoRoute(page: NutritionGoalsRoute.page),
        AutoRoute(page: MealRatioRoute.page),
        AutoRoute(page: AccountRoute.page),
        AutoRoute(page: MealScanRoute.page),
        getMealScanRoutes(),
        AutoRoute(page: FoodSearchLoggedFoodDetailsRoute.page),
        getMealScanLoggedFoodDetailsRoutes(),
        AutoRoute(page: DailyReportRoute.page)
      ],
    );
  }

  AutoRoute getMealScanRoutes() {
    return AutoRoute(
      page: MealScanNavigatorRoute.page,
      children: [
        AutoRoute(page: MealScanResultRoute.page, initial: true),
        AutoRoute(page: IngredientDetailsRoute.page),
      ],
    );
  }

  AutoRoute getMealScanLoggedFoodDetailsRoutes() {
    return AutoRoute(
      page: MealScanLoggedFoodNavigatorRoute.page,
      children: [
        AutoRoute(page: MealScanLoggedFoodDetailsRoute.page, initial: true),
        AutoRoute(page: LoggedFoodIngredientDetailsRoute.page)
      ],
    );
  }
}

Route<T> _modalSheetBuilder<T>(
  BuildContext context,
  Widget child,
  AutoRoutePage<T> page,
) {
  return ModalBottomSheetRoute(
    settings: page,
    builder: (context) => SafeArea(
      // Wrap to layout based on the intrinsic height of its content
      child: Wrap(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: AppStyles.kRadVT10, color: context.theme.colorScheme.onPrimary),
            clipBehavior: Clip.hardEdge,
            child: child,
          ),
        ],
      ),
    ),
    isScrollControlled: true,
    backgroundColor: context.theme.colorScheme.onPrimary,
  );
}

// Route<T> _fullScreenModalSheetBuilder<T>(
//   BuildContext _,
//   Widget child,
//   AutoRoutePage<T> page,
// ) {
//   return ModalBottomSheetRoute(
//     settings: page,
//     builder: (context) => SafeArea(
//       child: Container(
//         decoration: BoxDecoration(borderRadius: AppStyles.kRadVT10),
//         clipBehavior: Clip.hardEdge,
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height * 0.9,
//           child: child,
//         ),
//       ),
//     ),
//     isScrollControlled: true,
//   );
// }
