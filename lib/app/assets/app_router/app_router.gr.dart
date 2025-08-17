// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AccountPage]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
    : super(AccountRoute.name, initialChildren: children);

  static const String name = 'AccountRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AccountPage();
    },
  );
}

/// generated route for
/// [BarcodeScanPage]
class BarcodeScanRoute extends PageRouteInfo<void> {
  const BarcodeScanRoute({List<PageRouteInfo>? children})
    : super(BarcodeScanRoute.name, initialChildren: children);

  static const String name = 'BarcodeScanRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BarcodeScanPage();
    },
  );
}

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
/// [ErrorModal]
class ErrorRoute extends PageRouteInfo<ErrorRouteArgs> {
  ErrorRoute({
    IconData? icon,
    Color? iconBackgroundColor,
    required String label,
    required String description,
    List<Widget>? actions,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ErrorRoute.name,
         args: ErrorRouteArgs(
           icon: icon,
           iconBackgroundColor: iconBackgroundColor,
           label: label,
           description: description,
           actions: actions,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ErrorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ErrorRouteArgs>();
      return ErrorModal(
        icon: args.icon,
        iconBackgroundColor: args.iconBackgroundColor,
        label: args.label,
        description: args.description,
        actions: args.actions,
        key: args.key,
      );
    },
  );
}

class ErrorRouteArgs {
  const ErrorRouteArgs({
    this.icon,
    this.iconBackgroundColor,
    required this.label,
    required this.description,
    this.actions,
    this.key,
  });

  final IconData? icon;

  final Color? iconBackgroundColor;

  final String label;

  final String description;

  final List<Widget>? actions;

  final Key? key;

  @override
  String toString() {
    return 'ErrorRouteArgs{icon: $icon, iconBackgroundColor: $iconBackgroundColor, label: $label, description: $description, actions: $actions, key: $key}';
  }
}

/// generated route for
/// [FoodDetailsPage]
class FoodDetailsRoute extends PageRouteInfo<FoodDetailsRouteArgs> {
  FoodDetailsRoute({
    required FoodResponseModel foodResponseModel,
    required bool saveRecent,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         FoodDetailsRoute.name,
         args: FoodDetailsRouteArgs(
           foodResponseModel: foodResponseModel,
           saveRecent: saveRecent,
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
        saveRecent: args.saveRecent,
        key: args.key,
      );
    },
  );
}

class FoodDetailsRouteArgs {
  const FoodDetailsRouteArgs({
    required this.foodResponseModel,
    required this.saveRecent,
    this.key,
  });

  final FoodResponseModel foodResponseModel;

  final bool saveRecent;

  final Key? key;

  @override
  String toString() {
    return 'FoodDetailsRouteArgs{foodResponseModel: $foodResponseModel, saveRecent: $saveRecent, key: $key}';
  }
}

/// generated route for
/// [FoodSearchLoggedFoodDetailsPage]
class FoodSearchLoggedFoodDetailsRoute
    extends PageRouteInfo<FoodSearchLoggedFoodDetailsRouteArgs> {
  FoodSearchLoggedFoodDetailsRoute({
    required LoggedFoodModel loggedFood,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         FoodSearchLoggedFoodDetailsRoute.name,
         args: FoodSearchLoggedFoodDetailsRouteArgs(
           loggedFood: loggedFood,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'FoodSearchLoggedFoodDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FoodSearchLoggedFoodDetailsRouteArgs>();
      return FoodSearchLoggedFoodDetailsPage(
        loggedFood: args.loggedFood,
        key: args.key,
      );
    },
  );
}

class FoodSearchLoggedFoodDetailsRouteArgs {
  const FoodSearchLoggedFoodDetailsRouteArgs({
    required this.loggedFood,
    this.key,
  });

  final LoggedFoodModel loggedFood;

  final Key? key;

  @override
  String toString() {
    return 'FoodSearchLoggedFoodDetailsRouteArgs{loggedFood: $loggedFood, key: $key}';
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
/// [IngredientDetailsPage]
class IngredientDetailsRoute extends PageRouteInfo<IngredientDetailsRouteArgs> {
  IngredientDetailsRoute({
    required IngredientModel ingredient,
    required int index,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         IngredientDetailsRoute.name,
         args: IngredientDetailsRouteArgs(
           ingredient: ingredient,
           index: index,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'IngredientDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IngredientDetailsRouteArgs>();
      return IngredientDetailsPage(
        ingredient: args.ingredient,
        index: args.index,
        key: args.key,
      );
    },
  );
}

class IngredientDetailsRouteArgs {
  const IngredientDetailsRouteArgs({
    required this.ingredient,
    required this.index,
    this.key,
  });

  final IngredientModel ingredient;

  final int index;

  final Key? key;

  @override
  String toString() {
    return 'IngredientDetailsRouteArgs{ingredient: $ingredient, index: $index, key: $key}';
  }
}

/// generated route for
/// [LoggedFoodIngredientDetailsPage]
class LoggedFoodIngredientDetailsRoute
    extends PageRouteInfo<LoggedFoodIngredientDetailsRouteArgs> {
  LoggedFoodIngredientDetailsRoute({
    required IngredientModel ingredient,
    required int index,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         LoggedFoodIngredientDetailsRoute.name,
         args: LoggedFoodIngredientDetailsRouteArgs(
           ingredient: ingredient,
           index: index,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'LoggedFoodIngredientDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoggedFoodIngredientDetailsRouteArgs>();
      return LoggedFoodIngredientDetailsPage(
        ingredient: args.ingredient,
        index: args.index,
        key: args.key,
      );
    },
  );
}

class LoggedFoodIngredientDetailsRouteArgs {
  const LoggedFoodIngredientDetailsRouteArgs({
    required this.ingredient,
    required this.index,
    this.key,
  });

  final IngredientModel ingredient;

  final int index;

  final Key? key;

  @override
  String toString() {
    return 'LoggedFoodIngredientDetailsRouteArgs{ingredient: $ingredient, index: $index, key: $key}';
  }
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
    Key? key,
    required MealType mealType,
    required DateTime selectedDate,
    List<PageRouteInfo>? children,
  }) : super(
         MealDetailsRoute.name,
         args: MealDetailsRouteArgs(
           key: key,
           mealType: mealType,
           selectedDate: selectedDate,
         ),
         initialChildren: children,
       );

  static const String name = 'MealDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealDetailsRouteArgs>();
      return MealDetailsPage(
        key: args.key,
        mealType: args.mealType,
        selectedDate: args.selectedDate,
      );
    },
  );
}

class MealDetailsRouteArgs {
  const MealDetailsRouteArgs({
    this.key,
    required this.mealType,
    required this.selectedDate,
  });

  final Key? key;

  final MealType mealType;

  final DateTime selectedDate;

  @override
  String toString() {
    return 'MealDetailsRouteArgs{key: $key, mealType: $mealType, selectedDate: $selectedDate}';
  }
}

/// generated route for
/// [MealRatioPage]
class MealRatioRoute extends PageRouteInfo<void> {
  const MealRatioRoute({List<PageRouteInfo>? children})
    : super(MealRatioRoute.name, initialChildren: children);

  static const String name = 'MealRatioRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MealRatioPage();
    },
  );
}

/// generated route for
/// [MealScanLoggedFoodDetailsPage]
class MealScanLoggedFoodDetailsRoute extends PageRouteInfo<void> {
  const MealScanLoggedFoodDetailsRoute({List<PageRouteInfo>? children})
    : super(MealScanLoggedFoodDetailsRoute.name, initialChildren: children);

  static const String name = 'MealScanLoggedFoodDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MealScanLoggedFoodDetailsPage();
    },
  );
}

/// generated route for
/// [MealScanLoggedFoodNavigatorPage]
class MealScanLoggedFoodNavigatorRoute
    extends PageRouteInfo<MealScanLoggedFoodNavigatorRouteArgs> {
  MealScanLoggedFoodNavigatorRoute({
    required LoggedFoodModel loggedFood,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         MealScanLoggedFoodNavigatorRoute.name,
         args: MealScanLoggedFoodNavigatorRouteArgs(
           loggedFood: loggedFood,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'MealScanLoggedFoodNavigatorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealScanLoggedFoodNavigatorRouteArgs>();
      return MealScanLoggedFoodNavigatorPage(
        loggedFood: args.loggedFood,
        key: args.key,
      );
    },
  );
}

class MealScanLoggedFoodNavigatorRouteArgs {
  const MealScanLoggedFoodNavigatorRouteArgs({
    required this.loggedFood,
    this.key,
  });

  final LoggedFoodModel loggedFood;

  final Key? key;

  @override
  String toString() {
    return 'MealScanLoggedFoodNavigatorRouteArgs{loggedFood: $loggedFood, key: $key}';
  }
}

/// generated route for
/// [MealScanNavigatorPage]
class MealScanNavigatorRoute extends PageRouteInfo<void> {
  const MealScanNavigatorRoute({List<PageRouteInfo>? children})
    : super(MealScanNavigatorRoute.name, initialChildren: children);

  static const String name = 'MealScanNavigatorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MealScanNavigatorPage();
    },
  );
}

/// generated route for
/// [MealScanPage]
class MealScanRoute extends PageRouteInfo<void> {
  const MealScanRoute({List<PageRouteInfo>? children})
    : super(MealScanRoute.name, initialChildren: children);

  static const String name = 'MealScanRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MealScanPage();
    },
  );
}

/// generated route for
/// [MealScanResultPage]
class MealScanResultRoute extends PageRouteInfo<MealScanResultRouteArgs> {
  MealScanResultRoute({
    Key? key,
    required XFile imageFile,
    List<PageRouteInfo>? children,
  }) : super(
         MealScanResultRoute.name,
         args: MealScanResultRouteArgs(key: key, imageFile: imageFile),
         initialChildren: children,
       );

  static const String name = 'MealScanResultRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealScanResultRouteArgs>();
      return MealScanResultPage(key: args.key, imageFile: args.imageFile);
    },
  );
}

class MealScanResultRouteArgs {
  const MealScanResultRouteArgs({this.key, required this.imageFile});

  final Key? key;

  final XFile imageFile;

  @override
  String toString() {
    return 'MealScanResultRouteArgs{key: $key, imageFile: $imageFile}';
  }
}

/// generated route for
/// [NutritionGoalsPage]
class NutritionGoalsRoute extends PageRouteInfo<void> {
  const NutritionGoalsRoute({List<PageRouteInfo>? children})
    : super(NutritionGoalsRoute.name, initialChildren: children);

  static const String name = 'NutritionGoalsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NutritionGoalsPage();
    },
  );
}

/// generated route for
/// [PersonalDetailsPage]
class PersonalDetailsRoute extends PageRouteInfo<void> {
  const PersonalDetailsRoute({List<PageRouteInfo>? children})
    : super(PersonalDetailsRoute.name, initialChildren: children);

  static const String name = 'PersonalDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PersonalDetailsPage();
    },
  );
}

/// generated route for
/// [PersonalizingPlanLoadingPage]
class PersonalizingPlanLoadingRoute
    extends PageRouteInfo<PersonalizingPlanLoadingRouteArgs> {
  PersonalizingPlanLoadingRoute({
    Key? key,
    PlanAction? planAction = PlanAction.CREATE,
    Map<String, String>? mealRatio,
    Map<String, String>? nutritionGoals,
    List<PageRouteInfo>? children,
  }) : super(
         PersonalizingPlanLoadingRoute.name,
         args: PersonalizingPlanLoadingRouteArgs(
           key: key,
           planAction: planAction,
           mealRatio: mealRatio,
           nutritionGoals: nutritionGoals,
         ),
         initialChildren: children,
       );

  static const String name = 'PersonalizingPlanLoadingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PersonalizingPlanLoadingRouteArgs>(
        orElse: () => const PersonalizingPlanLoadingRouteArgs(),
      );
      return PersonalizingPlanLoadingPage(
        key: args.key,
        planAction: args.planAction,
        mealRatio: args.mealRatio,
        nutritionGoals: args.nutritionGoals,
      );
    },
  );
}

class PersonalizingPlanLoadingRouteArgs {
  const PersonalizingPlanLoadingRouteArgs({
    this.key,
    this.planAction = PlanAction.CREATE,
    this.mealRatio,
    this.nutritionGoals,
  });

  final Key? key;

  final PlanAction? planAction;

  final Map<String, String>? mealRatio;

  final Map<String, String>? nutritionGoals;

  @override
  String toString() {
    return 'PersonalizingPlanLoadingRouteArgs{key: $key, planAction: $planAction, mealRatio: $mealRatio, nutritionGoals: $nutritionGoals}';
  }
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
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
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
