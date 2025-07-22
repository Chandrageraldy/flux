import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/food_model/food_model.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/views/app_entry_page/splash_screen.dart';
import 'package:flux/app/views/auth_page/login_page.dart';
import 'package:flux/app/views/auth_page/signup_page.dart';
import 'package:flux/app/views/dashboard_page/dashboard_navigator_page.dart';
import 'package:flux/app/views/dashboard_page/dashboard_page.dart';
import 'package:flux/app/views/diary_page/diary_page.dart';
import 'package:flux/app/views/food_details_page/food_details_page.dart';
import 'package:flux/app/views/food_search_page/food_search_page.dart';
import 'package:flux/app/views/personalizing_plan_loading_page/personalizing_plan_loading_page.dart';
import 'package:flux/app/views/logging_selection_modal/logging_selection_modal.dart';
import 'package:flux/app/views/manual_plan_setup_page/manual_plan_setup_page.dart';
import 'package:flux/app/views/meal_details_page/meal_details_page.dart';
import 'package:flux/app/views/more_page/more_page.dart';
import 'package:flux/app/views/plan_selection_modal/plan_selection_modal.dart';
import 'package:flux/app/views/progress_page/progress_page.dart';
import 'package:flux/app/views/root_page/root_page.dart';
import 'package:flux/app/views/root_page/root_navigator_page.dart';
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
            AutoRoute(page: MoreRoute.page),
          ],
        ),
        CustomRoute(page: LoggingSelectionRoute.page, customRouteBuilder: _modalSheetBuilder),
        AutoRoute(page: FoodDetailsRoute.page),
        AutoRoute(page: MealDetailsRoute.page),
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
            decoration: BoxDecoration(borderRadius: AppStyles.kRadVT24),
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
