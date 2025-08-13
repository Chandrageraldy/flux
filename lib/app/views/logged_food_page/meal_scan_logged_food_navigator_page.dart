import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/logged_food_vm/meal_scan_logged_food_details_view_model.dart';

@RoutePage()
class MealScanLoggedFoodNavigatorPage extends StatelessWidget {
  const MealScanLoggedFoodNavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MealScanLoggedFoodDetailsViewModel(),
      child: AutoRouter(),
    );
  }
}
