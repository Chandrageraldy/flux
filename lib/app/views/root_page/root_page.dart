import 'package:flux/app/models/onboard_model/onboard_model.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/button/app_text_span_button.dart';
import 'package:flux/app/widgets/onboard_content/onboard_content.dart';

import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class RootPage extends BaseStatefulPage {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends BaseStatefulState<RootPage> {
  late PageController _pageController;
  var pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Enable Set State inside Extension
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }

  @override
  Widget body() {
    return Column(
      children: [
        getFluxLogoImage(),
        Flexible(fit: FlexFit.loose, child: getOnboardingPageView()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [getGeneratedDotIndicator()],
        ),
        AppStyles.kSizedBoxH24,
        getGetStartedButton(),
        AppStyles.kSizedBoxH24,
        getTextSpanLoginButton(),
        AppStyles.kSizedBoxH24,
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _RootPageState {
  void _onGetStartedPressed() {
    context.router.push(const PlanSelectionRoute());
  }

  void _onLoginPressed() {
    context.router.push(const LoginRoute());
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _RootPageState {
  // Onboarding PageView Builder
  Widget getOnboardingPageView() {
    return PageView.builder(
      itemCount: onboardData.length,
      controller: _pageController,
      onPageChanged: (index) {
        _setState(() {
          pageIndex = index;
        });
      },
      itemBuilder: (context, index) => OnboardContent(
        onboardTitle: onboardData[index].onboardTitle,
        onboardImage: onboardData[index].onboardImage,
        onboardDesc: onboardData[index].onboardDesc,
      ),
    );
  }

  // Dot Indicator
  Widget getDotIndicator({bool isActive = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppStyles.kRad8,
        color: isActive ? context.theme.colorScheme.primary : context.theme.colorScheme.tertiary,
      ),
      width: isActive ? _Styles.dotIndicatorWidth * 2 : _Styles.dotIndicatorWidth,
      height: _Styles.dotIndicatorWidth,
    );
  }

  Widget getGeneratedDotIndicator() {
    return Row(
      children: List.generate(
        onboardData.length,
        (index) => Padding(padding: AppStyles.kPadd3, child: getDotIndicator(isActive: index == pageIndex)),
      ),
    );
  }

  // Get Started Button
  Widget getGetStartedButton() {
    return AppDefaultButton(label: 'Get Started', onPressed: _onGetStartedPressed);
  }

  // Text Span Login Button
  Widget getTextSpanLoginButton() {
    return AppTextSpanButton(
      primaryText: S.current.loginPrimarySpanText,
      secondaryText: S.current.loginSecondarySpanText,
      onPressed: _onLoginPressed,
    );
  }

  // Flux Logo Image
  Widget getFluxLogoImage() {
    return Image.asset(
      ImagePath.fluxLogo,
      width: _Styles.getFluxLogoImageSize(context),
      height: _Styles.getFluxLogoImageSize(context),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Dot Indicator Style
  static const dotIndicatorWidth = 12.0;

  // Flux Logo Image Style
  static double getFluxLogoImageSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.3;
  }
}
