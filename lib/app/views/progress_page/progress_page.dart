import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/repositories/food_repo/food_repository.dart';
import 'package:flux/app/viewmodels/plan_vm/plan_view_model.dart';

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
      child: ElevatedButton(onPressed: _testAPI, child: Text('Test API')),
    );
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ProgressPageState {
  void _getPersonalizedPlan() async {
    await tryLoad(context, () => context.read<PlanViewModel>().getPersonalizedPlan()) ?? false;
  }

  void _testAPI() async {
    await FoodRepository().searchInstant('Eggs');

    // if (response.status == ResponseStatus.COMPLETE) {
    //   debugPrint('API Response: ${response.data}');
    // } else {
    //   debugPrint('API Error: ${response.error}');
    // }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ProgressPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ProgressPageState {}

// * ----------------------------- Styles ----------------------------
// abstract class _Styles {}
