import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class NutritionGoalsPage extends BaseStatefulPage {
  const NutritionGoalsPage({super.key});

  @override
  State<NutritionGoalsPage> createState() => _NutritionGoalsPageState();
}

class _NutritionGoalsPageState extends BaseStatefulState<NutritionGoalsPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('NutritionGoalsPage body'),
    );
  }
}
