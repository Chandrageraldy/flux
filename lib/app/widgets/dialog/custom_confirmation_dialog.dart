import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog({
    super.key,
    required this.label,
    required this.desc,
    required this.onConfirm,
    required this.confirmLabel,
    required this.color,
  });

  final String label;
  final String desc;
  final VoidCallback? onConfirm;
  final String confirmLabel;
  final Color color;

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
          children: [
            getTopRow(context),
            AppStyles.kSizedBoxH8,
            Text(desc, style: _Styles.getDescLabelTextStyle(context), textAlign: TextAlign.start),
            AppStyles.kSizedBoxH20,
            getActionsRow(context),
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on CustomConfirmationDialog {
  // Top Row
  Widget getTopRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: _Styles.getLabelTextStyle(context), textAlign: TextAlign.start),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.close, size: AppStyles.kSize20, color: context.theme.colorScheme.onTertiaryContainer),
        )
      ],
    );
  }

  // Actions Row
  Widget getActionsRow(BuildContext context) {
    return Row(
      spacing: AppStyles.kSpac8,
      children: [
        Expanded(
          child: AppDefaultButton(
            label: S.current.cancelLabel,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            padding: AppStyles.kPaddSV12,
            backgroundColor: context.theme.colorScheme.tertiaryContainer,
            labelStyle:
                Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiary),
          ),
        ),
        Expanded(
          child: AppDefaultButton(
            label: confirmLabel,
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              onConfirm?.call();
            },
            padding: AppStyles.kPaddSV12,
            backgroundColor: color,
            labelStyle: Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Dialog Shape
  static ShapeBorder getDialogShape() {
    return RoundedRectangleBorder(borderRadius: AppStyles.kRad10);
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.mediumPlus);
  }

  // Desc Label Text Style
  static TextStyle getDescLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
