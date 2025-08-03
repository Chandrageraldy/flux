import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class AdjustCalorieIntakePage extends BaseStatefulPage {
  const AdjustCalorieIntakePage({super.key});

  @override
  State<AdjustCalorieIntakePage> createState() => _AdjustCalorieIntakePageState();
}

class _AdjustCalorieIntakePageState extends BaseStatefulState<AdjustCalorieIntakePage> {
  @override
  Widget body() {
    return const Center(
      child: Text('AdjustCalorieIntakePage body'),
    );
  }
}
