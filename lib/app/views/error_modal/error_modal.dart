import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';

@RoutePage()
class ErrorModal extends BaseStatefulPage {
  const ErrorModal({super.key});

  @override
  State<ErrorModal> createState() => _ErrorModalState();
}

class _ErrorModalState extends BaseStatefulState<ErrorModal> {
  @override
  Color backgroundColor() => context.theme.colorScheme.onPrimary;

  @override
  bool useGradientBackground() => false;

  @override
  bool isModal() => true;

  @override
  Widget body() {
    return Padding(
      padding: AppStyles.kPaddSV15,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            getIcon(),
            AppStyles.kSizedBoxH12,
            getLabel(),
            AppStyles.kSizedBoxH4,
            getDescriptionLabel(),
            AppDefaultButton(
              label: 'Try Again',
              onPressed: () {},
              padding: AppStyles.kPaddSV8,
            ),
          ],
        ),
      ),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ErrorModalState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ErrorModalState {
  // Icon
  Widget getIcon() {
    return Container(
      padding: AppStyles.kPadd8,
      decoration: _Styles.iconOuterContainerDecoration(context),
      child: Container(
        padding: AppStyles.kPadd12,
        decoration: _Styles.iconInnerContainerDecoration(context),
        child: Icon(Icons.error_outline_outlined, size: AppStyles.kSize30, color: context.theme.colorScheme.onPrimary),
      ),
    );
  }

  // Label
  Widget getLabel() {
    return Text(
      S.current.barcodeNotRecognizedLabel,
      style: _Styles.labelTextStyle(context),
    );
  }

  // Description Label
  Widget getDescriptionLabel() {
    return Text(
      S.current.bacrodeNotRecognizedDesc,
      textAlign: TextAlign.center,
      style: _Styles.descriptionTextStyle(context),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Icon Outer Container Decoration
  static BoxDecoration iconOuterContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Colors.red.withAlpha(40),
      borderRadius: AppStyles.kRad100,
    );
  }

  // Icon Inner Container Decoration
  static BoxDecoration iconInnerContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: Colors.red,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Label Text Style
  static TextStyle labelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraLarge);
  }

  // Description Text Style
  static TextStyle descriptionTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
