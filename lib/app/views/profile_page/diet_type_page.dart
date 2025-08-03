import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class DietTypePage extends BaseStatefulPage {
  const DietTypePage({super.key});

  @override
  State<DietTypePage> createState() => _DietTypePageState();
}

class _DietTypePageState extends BaseStatefulState<DietTypePage> {
  @override
  Widget body() {
    return const Center(
      child: Text('DietTypePage body'),
    );
  }
}
