import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class ProgressPage extends BaseStatefulPage {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends BaseStatefulState<ProgressPage> {
  @override
  bool useGradientBackground() => false;

  @override
  Color backgroundColor() => context.theme.colorScheme.surface;

  @override
  Widget body() {
    return const Center(
      child: Text('ProgressPage body'),
    );
  }
}
