import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';

class CustomFieldDialog extends StatelessWidget {
  const CustomFieldDialog({
    required this.context,
    required this.label,
    required this.desc,
    required this.formField,
    required this.initialValue,
    super.key,
  });

  final BuildContext context;
  final String label;
  final String? desc;
  final FormFields formField;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.theme.colorScheme.onPrimary,
      shape: _Styles.getDialogShape(),
      insetPadding: AppStyles.kPaddSH36,
      child: Padding(
        padding: AppStyles.kPaddOL15R15T16B8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac4,
          children: [
            getTopRow(),
            getDescLabel(),
            AppStyles.kSizedBoxH4,
            getTextField(),
            AppStyles.kSizedBoxH4,
            getButton(),
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on CustomFieldDialog {
  // Top Row
  Widget getTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: _Styles.getLabelTextStyle(context)),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.close, size: AppStyles.kSize20, color: context.theme.colorScheme.onTertiaryContainer),
        )
      ],
    );
  }

  // Desc Label
  Widget getDescLabel() {
    return Text(
      desc ?? '',
      style: _Styles.getDescLabelTextStyle(context),
      textAlign: TextAlign.justify,
    );
  }

  // Text Field
  Widget getTextField() {
    return Container();
  }

  // Button
  Widget getButton() {
    return AppDefaultButton(
      label: S.current.confirmLabel,
      onPressed: () {
        Navigator.of(context).pop();
      },
      padding: AppStyles.kPaddSV8,
      borderRadius: AppStyles.kRad6,
      labelStyle: _Styles.getButtonLabelTextStyle(context),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Dialog Shape
  static ShapeBorder getDialogShape() {
    return RoundedRectangleBorder(borderRadius: AppStyles.kRad10);
  }

  // Button Label Text Style
  static TextStyle getButtonLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.large);
  }

  // Desc Label Text Style
  static TextStyle getDescLabelTextStyle(BuildContext context) {
    return Quicksand.light.withSize(FontSizes.extraSmall);
  }
}
