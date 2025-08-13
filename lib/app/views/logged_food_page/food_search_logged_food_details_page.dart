import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/models/logged_food_model/logged_food_model.dart';
import 'package:flux/app/viewmodels/logged_food_vm/food_search_logged_food_details_view_model.dart';

@RoutePage()
class FoodSearchLoggedFoodDetailsPage extends StatelessWidget {
  const FoodSearchLoggedFoodDetailsPage({required this.loggedFood, super.key});

  final LoggedFoodModel loggedFood;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FoodSearchLoggedFoodDetailsViewModel(),
      child: _FoodSearchLoggedFoodDetailsPage(loggedFood: loggedFood),
    );
  }
}

class _FoodSearchLoggedFoodDetailsPage extends BaseStatefulPage {
  const _FoodSearchLoggedFoodDetailsPage({required this.loggedFood});

  final LoggedFoodModel loggedFood;

  @override
  State<_FoodSearchLoggedFoodDetailsPage> createState() => _FoodSearchLoggedFoodDetailsPageState();
}

class _FoodSearchLoggedFoodDetailsPageState extends BaseStatefulState<_FoodSearchLoggedFoodDetailsPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('_FoodSearchLoggedFoodDetailsPage body'),
    );
  }
}
