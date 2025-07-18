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
    return Center(child: getAppTitleLabel());
  }
}

// * ------------------------ WidgetFactories -----------------------
extension _WidgetFactories on _SplashScreenState {
  // App Title Label
  Widget getAppTitleLabel() {
    return Text(
      'LOGO',
      style: _Styles.getAppTitleLabelTextStyle(context),
    );
  }

  // App Logo
  // Widget getAppLogoImage() {
  //   return Image.asset(
  //     ImageConstant.fluxLogo,
  //     width: _Styles.getFluxLogoImageSize(context),
  //     height: _Styles.getFluxLogoImageSize(context),
  //   );
  // }
}

// * ------------------------ PrivateMethods ------------------------
extension _PrivateMethods on _SplashScreenState {
  Future<void> _initializeSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    navigateBasedOnState();
  }

  void navigateBasedOnState() {
    if (mounted) {
      if (SharedPreferenceHandler().getHasOnboarded() == false) {
        context.router.replaceAll([const RootRoute()]);
      } else {
        if (context.read<UserViewModel>().isLoggedIn) {
          context.router.replaceAll([const DashboardNavigatorRoute()]);
        } else {
          context.router.replaceAll([const LoginRoute()]);
        }
      }
    }
  }
}

// * ---------------------------- Styles -----------------------------
abstract class _Styles {
  // App Title Text Style
  static getAppTitleLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraMassive).copyWith(color: context.theme.colorScheme.secondary);
  }

  // Flux Logo Image Style
  // static double getFluxLogoImageSize(BuildContext context) {
  //   return MediaQuery.of(context).size.width * 0.3;
  // }
}
