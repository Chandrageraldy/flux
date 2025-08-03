import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class MealRatioPage extends BaseStatefulPage {
  const MealRatioPage({super.key});

  @override
  State<MealRatioPage> createState() => _MealRatioPageState();
}

class _MealRatioPageState extends BaseStatefulState<MealRatioPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('MealRatioPage body'),
    );
  }
}
