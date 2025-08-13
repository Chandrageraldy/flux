import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/viewmodels/logged_food_vm/meal_scan_logged_food_details_view_model.dart';

@RoutePage()
class MealScanLoggedFoodNavigatorPage extends StatelessWidget {
  const MealScanLoggedFoodNavigatorPage({required this.loggedFood, super.key});

  final LoggedFoodModel loggedFood;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MealScanLoggedFoodDetailsViewModel(loggedFood: loggedFood),
      child: AutoRouter(),
    );
  }
}
