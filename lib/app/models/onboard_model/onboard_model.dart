import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class Onboard {
  final String onboardTitle, onboardImage, onboardDesc;
  const Onboard({required this.onboardTitle, required this.onboardImage, required this.onboardDesc});
}

final List<Onboard> onboardData = [
  Onboard(
    onboardTitle: S.current.onboardingTitle1,
    onboardImage: ImageConstant.onboarding1,
    onboardDesc: S.current.onboardingDesc1,
  ),
  Onboard(
    onboardTitle: S.current.onboardingTitle2,
    onboardImage: ImageConstant.onboarding2,
    onboardDesc: S.current.onboardingDesc2,
  ),
  Onboard(
    onboardTitle: S.current.onboardingTitle3,
    onboardImage: ImageConstant.onboarding3,
    onboardDesc: S.current.onboardingDesc3,
  ),
];
