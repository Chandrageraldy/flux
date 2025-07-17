import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class MealDetailsPage extends BaseStatefulPage {
  const MealDetailsPage({required this.mealType, super.key});

  final MealType mealType;

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends BaseStatefulState<MealDetailsPage> {
  @override
  Widget body() {
    return Center(
      child: Text(widget.mealType.label),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MealDetailsPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MealDetailsPageState {}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {}
