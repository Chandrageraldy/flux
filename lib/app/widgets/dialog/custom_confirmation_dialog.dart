import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';

class CustomConfirmationDialog extends StatelessWidget {
  const CustomConfirmationDialog({
    super.key,
    required this.label,
    required this.icon,
    required this.desc,
    required this.onConfirm,
    required this.confirmLabel,
    required this.color,
  });

  final String label;
  final IconData icon;
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
          children: [
            AppStyles.kSizedBoxH4,
            Container(
              padding: AppStyles.kPadd8,
              decoration: _Styles.iconOuterContainerDecoration(context, color),
              child: Container(
                padding: AppStyles.kPadd12,
                decoration: _Styles.iconInnerContainerDecoration(context, color),
                child: Icon(icon, size: AppStyles.kSize30, color: context.theme.colorScheme.onPrimary),
              ),
            ),
            AppStyles.kSizedBoxH16,
            Text(label, style: _Styles.getLabelTextStyle(context), textAlign: TextAlign.center),
            AppStyles.kSizedBoxH8,
            Text(desc, style: _Styles.getDescLabelTextStyle(context), textAlign: TextAlign.center),
            AppStyles.kSizedBoxH20,
            Row(
              spacing: AppStyles.kSpac8,
              children: [
                Expanded(
                  child: AppDefaultButton(
                    label: S.current.cancelLabel,
                    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                    padding: AppStyles.kPaddSV12,
                    borderColor: context.theme.colorScheme.tertiary,
                    backgroundColor: context.theme.colorScheme.onPrimary,
                    labelStyle: Quicksand.medium
                        .withSize(FontSizes.small)
                        .copyWith(color: context.theme.colorScheme.onTertiary),
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
                    labelStyle:
                        Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
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

  // Icon Outer Container Decoration
  static BoxDecoration iconOuterContainerDecoration(BuildContext context, Color color) {
    return BoxDecoration(
      color: color.withAlpha(40),
      borderRadius: AppStyles.kRad100,
    );
  }

  // Icon Inner Container Decoration
  static BoxDecoration iconInnerContainerDecoration(BuildContext context, Color color) {
    return BoxDecoration(
      color: color,
      borderRadius: AppStyles.kRad100,
    );
  }
}
