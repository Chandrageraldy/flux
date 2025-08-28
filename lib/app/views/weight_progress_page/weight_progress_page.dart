import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/weight_progress_vm/weight_progress_view_model.dart';

@RoutePage()
class WeightProgressPage extends StatelessWidget {
  const WeightProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => WeightProgressViewModel(), child: _WeightProgressPage());
  }
}

class _WeightProgressPage extends BaseStatefulPage {
  @override
  State<_WeightProgressPage> createState() => _WeightProgressPageState();
}

class _WeightProgressPageState extends BaseStatefulState<_WeightProgressPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('_WeightProgressPage body'),
    );
  }
}
