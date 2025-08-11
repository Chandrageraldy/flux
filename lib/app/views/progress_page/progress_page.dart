import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/plan_vm/plan_view_model.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';

@RoutePage()
class ProgressPage extends BaseStatefulPage {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends BaseStatefulState<ProgressPage> {
  @override
  void initState() {
    super.initState();
    _getPersonalizedPlan();
  }

  @override
  Widget body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(onPressed: _testAPI, child: Text('Test API')),
          ElevatedButton(onPressed: _onLogoutPressed, child: Text(S.current.logOutLabel)),
        ],
      ),
    );
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ProgressPageState {
  void _getPersonalizedPlan() async {
    await tryLoad(context, () => context.read<PlanViewModel>().getPersonalizedPlan()) ?? false;
  }

  void _testAPI() async {}

  void _onLogoutPressed() async {
    final response = await tryLoad(context, () => context.read<UserViewModel>().logout());

    if (response == true && mounted) {
      context.router.replaceAll([RootRoute()]);
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ProgressPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ProgressPageState {}

// * ----------------------------- Styles ----------------------------
// abstract class _Styles {}
