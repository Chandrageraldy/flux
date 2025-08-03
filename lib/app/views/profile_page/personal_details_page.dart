import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class PersonalDetailsPage extends BaseStatefulPage {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends BaseStatefulState<PersonalDetailsPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('PersonalDetailsPage body'),
    );
  }
}
