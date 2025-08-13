import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';

@RoutePage()
class MealScanLoggedFoodDetailsPage extends BaseStatefulPage {
  const MealScanLoggedFoodDetailsPage({required this.loggedFood, super.key});

  final LoggedFoodModel loggedFood;

  @override
  State<MealScanLoggedFoodDetailsPage> createState() => _MealScanLoggedFoodDetailsPageState();
}

class _MealScanLoggedFoodDetailsPageState extends BaseStatefulState<MealScanLoggedFoodDetailsPage> {
  @override
  Widget body() {
    return Center(
      child: Text(widget.loggedFood.foodName ?? ''),
    );
  }
}
