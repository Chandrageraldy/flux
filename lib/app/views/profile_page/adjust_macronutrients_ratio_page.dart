import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class AdjustMacronutrientsRatioPage extends BaseStatefulPage {
  const AdjustMacronutrientsRatioPage({super.key});

  @override
  State<AdjustMacronutrientsRatioPage> createState() => _AdjustMacronutrientsRatioPageState();
}

class _AdjustMacronutrientsRatioPageState extends BaseStatefulState<AdjustMacronutrientsRatioPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('AdjustMacronutrientsRatioPage body'),
    );
  }
}
