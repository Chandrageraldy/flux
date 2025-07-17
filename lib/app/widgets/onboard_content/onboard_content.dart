import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({super.key, required this.onboardTitle, required this.onboardImage, required this.onboardDesc});

  final String onboardTitle;
  final String onboardImage;
  final String onboardDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppStyles.kSpac16,
      children: [getOnboardImage(context), getTitleLabel(context), getDescriptionLabel()],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on OnboardContent {
  // Flutter Logo Image
  Widget getOnboardImage(BuildContext context) {
    return Image.asset(
      onboardImage,
      width: _Styles.getOnboardImageSize(context),
      height: _Styles.getOnboardImageSize(context),
    );
  }

  // Title Label
  Widget getTitleLabel(BuildContext context) {
    return Text(
      onboardTitle,
      style: _Styles.getTitleLabelTextStyle(context),
      textAlign: TextAlign.center,
    );
  }

  // Description Label
  Widget getDescriptionLabel() {
    return Text(
      onboardDesc,
      style: _Styles.getDescriptionLabelTextStyle(),
      textAlign: TextAlign.center,
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Onboard Image Style
  static double getOnboardImageSize(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.9;
  }

  // Title Text Style
  static TextStyle getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.massive).copyWith(color: context.theme.colorScheme.primary);
  }

  // Description Text Style
  static TextStyle getDescriptionLabelTextStyle() {
    return Quicksand.regular.withSize(FontSizes.mediumPlus);
  }
}
