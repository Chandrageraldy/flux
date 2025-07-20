import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class Onboard {
  final String onboardTitle, onboardImage, onboardDesc;
  const Onboard({required this.onboardTitle, required this.onboardImage, required this.onboardDesc});
}

final List<Onboard> onboardData = [
  Onboard(
    onboardTitle: S.current.onboardingTitle1,
    onboardImage: ImagePath.onboarding1,
    onboardDesc: S.current.onboardingDesc1,
  ),
  Onboard(
    onboardTitle: S.current.onboardingTitle2,
    onboardImage: ImagePath.onboarding2,
    onboardDesc: S.current.onboardingDesc2,
  ),
  Onboard(
    onboardTitle: S.current.onboardingTitle3,
    onboardImage: ImagePath.onboarding3,
    onboardDesc: S.current.onboardingDesc3,
  ),
];
