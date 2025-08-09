import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class IngredientDetailsPage extends BaseStatefulPage {
  const IngredientDetailsPage({super.key});

  @override
  State<IngredientDetailsPage> createState() => _IngredientDetailsPageState();
}

class _IngredientDetailsPageState extends BaseStatefulState<IngredientDetailsPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('IngredientDetailsPage body'),
    );
  }
}
