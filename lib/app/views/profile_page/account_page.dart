import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class AccountPage extends BaseStatefulPage {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends BaseStatefulState<AccountPage> {
  @override
  Widget body() {
    return const Center(
      child: Text('AccountPage body'),
    );
  }
}
