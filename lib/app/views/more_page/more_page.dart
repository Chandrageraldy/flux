import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';

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
      child: ElevatedButton(onPressed: _onLogoutPressed, child: Text(S.current.logOutLabel)),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _MorePageState {
  void _onLogoutPressed() async {
    final response = await tryLoad(context, () => context.read<UserViewModel>().logout());

    if (response == true && mounted) {
      context.router.replaceAll([RootRoute()]);
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _MorePageState {}

// * ----------------------------- Styles -----------------------------
// abstract class _Styles {}
