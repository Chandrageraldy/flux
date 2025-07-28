import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class MorePage extends BaseStatefulPage {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends BaseStatefulState<MorePage> {
  @override
  bool useGradientBackground() => false;

  @override
  Widget body() {
    return Center(
      child: Text('More Page'),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MorePageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MorePageState {}

// * ----------------------------- Styles -----------------------------
// abstract class _Styles {}
