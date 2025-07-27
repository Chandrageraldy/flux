// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DashboardNavigatorPage]
class DashboardNavigatorRoute extends PageRouteInfo<void> {
  const DashboardNavigatorRoute({List<PageRouteInfo>? children})
    : super(DashboardNavigatorRoute.name, initialChildren: children);

  static const String name = 'DashboardNavigatorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardNavigatorPage();
    },
  );
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardPage();
    },
  );
}

/// generated route for
/// [DiaryPage]
class DiaryRoute extends PageRouteInfo<void> {
  const DiaryRoute({List<PageRouteInfo>? children})
    : super(DiaryRoute.name, initialChildren: children);

  static const String name = 'DiaryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DiaryPage();
    },
  );
}

/// generated route for
/// [FoodDetailsPage]
class FoodDetailsRoute extends PageRouteInfo<FoodDetailsRouteArgs> {
  FoodDetailsRoute({
    required FoodResponseModel foodResponseModel,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         FoodDetailsRoute.name,
         args: FoodDetailsRouteArgs(
           foodResponseModel: foodResponseModel,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'FoodDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FoodDetailsRouteArgs>();
      return FoodDetailsPage(
        foodResponseModel: args.foodResponseModel,
        key: args.key,
      );
    },
  );
}

class FoodDetailsRouteArgs {
  const FoodDetailsRouteArgs({required this.foodResponseModel, this.key});

  final FoodResponseModel foodResponseModel;

  final Key? key;

  @override
  String toString() {
    return 'FoodDetailsRouteArgs{foodResponseModel: $foodResponseModel, key: $key}';
  }
}

/// generated route for
/// [FoodSearchPage]
class FoodSearchRoute extends PageRouteInfo<void> {
  const FoodSearchRoute({List<PageRouteInfo>? children})
    : super(FoodSearchRoute.name, initialChildren: children);

  static const String name = 'FoodSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FoodSearchPage();
    },
  );
}

/// generated route for
/// [LoggingSelectionModal]
class LoggingSelectionRoute extends PageRouteInfo<void> {
  const LoggingSelectionRoute({List<PageRouteInfo>? children})
    : super(LoggingSelectionRoute.name, initialChildren: children);

  static const String name = 'LoggingSelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoggingSelectionModal();
    },
  );
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [ManualPlanSetupPage]
class ManualPlanSetupRoute extends PageRouteInfo<void> {
  const ManualPlanSetupRoute({List<PageRouteInfo>? children})
    : super(ManualPlanSetupRoute.name, initialChildren: children);

  static const String name = 'ManualPlanSetupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ManualPlanSetupPage();
    },
  );
}

/// generated route for
/// [MealDetailsPage]
class MealDetailsRoute extends PageRouteInfo<MealDetailsRouteArgs> {
  MealDetailsRoute({
    required MealType mealType,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         MealDetailsRoute.name,
         args: MealDetailsRouteArgs(mealType: mealType, key: key),
         initialChildren: children,
       );

  static const String name = 'MealDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealDetailsRouteArgs>();
      return MealDetailsPage(mealType: args.mealType, key: args.key);
    },
  );
}

class MealDetailsRouteArgs {
  const MealDetailsRouteArgs({required this.mealType, this.key});

  final MealType mealType;

  final Key? key;

  @override
  String toString() {
    return 'MealDetailsRouteArgs{mealType: $mealType, key: $key}';
  }
}

/// generated route for
/// [MorePage]
class MoreRoute extends PageRouteInfo<void> {
  const MoreRoute({List<PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MorePage();
    },
  );
}

/// generated route for
/// [PersonalizingPlanLoadingPage]
class PersonalizingPlanLoadingRoute extends PageRouteInfo<void> {
  const PersonalizingPlanLoadingRoute({List<PageRouteInfo>? children})
    : super(PersonalizingPlanLoadingRoute.name, initialChildren: children);

  static const String name = 'PersonalizingPlanLoadingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PersonalizingPlanLoadingPage();
    },
  );
}

/// generated route for
/// [PlanSelectionModal]
class PlanSelectionRoute extends PageRouteInfo<void> {
  const PlanSelectionRoute({List<PageRouteInfo>? children})
    : super(PlanSelectionRoute.name, initialChildren: children);

  static const String name = 'PlanSelectionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PlanSelectionModal();
    },
  );
}

/// generated route for
/// [ProgressPage]
class ProgressRoute extends PageRouteInfo<void> {
  const ProgressRoute({List<PageRouteInfo>? children})
    : super(ProgressRoute.name, initialChildren: children);

  static const String name = 'ProgressRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProgressPage();
    },
  );
}

/// generated route for
/// [RootNavigatorPage]
class RootNavigatorRoute extends PageRouteInfo<void> {
  const RootNavigatorRoute({List<PageRouteInfo>? children})
    : super(RootNavigatorRoute.name, initialChildren: children);

  static const String name = 'RootNavigatorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootNavigatorPage();
    },
  );
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootPage();
    },
  );
}

/// generated route for
/// [ScanBarcodePage]
class ScanBarcodeRoute extends PageRouteInfo<void> {
  const ScanBarcodeRoute({List<PageRouteInfo>? children})
    : super(ScanBarcodeRoute.name, initialChildren: children);

  static const String name = 'ScanBarcodeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ScanBarcodePage();
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    required Map<String, String> bodyMetrics,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         SignUpRoute.name,
         args: SignUpRouteArgs(bodyMetrics: bodyMetrics, key: key),
         initialChildren: children,
       );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignUpRouteArgs>();
      return SignUpPage(bodyMetrics: args.bodyMetrics, key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({required this.bodyMetrics, this.key});

  final Map<String, String> bodyMetrics;

  final Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{bodyMetrics: $bodyMetrics, key: $key}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}
