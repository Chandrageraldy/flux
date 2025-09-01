import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class SplashScreen extends BaseStatefulPage {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseStatefulState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeSplashScreen();
    });
  }

  @override
  Widget body() {
    return Center(child: getAppLogoImage());
  }
}

// * ------------------------ WidgetFactories -----------------------
extension _WidgetFactories on _SplashScreenState {
  // App Logo
  Widget getAppLogoImage() {
    return Image.asset(
      ImagePath.fluxLogo,
      width: AppStyles.kSize100,
      height: AppStyles.kSize100,
    );
  }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on _SplashScreenState {
  Future<void> _initializeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    navigateBasedOnState();
  }

  void navigateBasedOnState() {
    if (mounted) {
      if (context.read<UserViewModel>().isLoggedIn) {
        context.router.replaceAll([const DashboardNavigatorRoute()]);
      } else {
        context.router.replaceAll([const RootRoute()]);
      }
    }
  }
}
