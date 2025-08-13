import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class MealScanLoggedFoodDetailsPage extends BaseStatefulPage {
  const MealScanLoggedFoodDetailsPage({super.key});

  @override
  State<MealScanLoggedFoodDetailsPage> createState() => _MealScanLoggedFoodDetailsPageState();
}

class _MealScanLoggedFoodDetailsPageState extends BaseStatefulState<MealScanLoggedFoodDetailsPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('MealScanLoggedFoodDetailsPage body'),
    );
  }
}
