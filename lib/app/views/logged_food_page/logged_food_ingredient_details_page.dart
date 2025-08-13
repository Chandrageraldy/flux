import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class LoggedFoodIngredientDetailsPage extends BaseStatefulPage {
  const LoggedFoodIngredientDetailsPage({super.key});

  @override
  State<LoggedFoodIngredientDetailsPage> createState() => _LoggedFoodIngredientDetailsPageState();
}

class _LoggedFoodIngredientDetailsPageState extends BaseStatefulState<LoggedFoodIngredientDetailsPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('LoggedFoodIngredientDetailsPage body'),
    );
  }
}
