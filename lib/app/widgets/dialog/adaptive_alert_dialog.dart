import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AdaptiveAlertDialog extends StatelessWidget {
  const AdaptiveAlertDialog({required this.errorMessage, required this.actionBuilders, super.key});

  final String errorMessage;
  final List<Widget> actionBuilders;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppStyles.kSizedBoxH4,
          Container(
            padding: AppStyles.kPadd8,
            decoration: _Styles.iconOuterContainerDecoration(context),
            child: Container(
              padding: AppStyles.kPadd12,
              decoration: _Styles.iconInnerContainerDecoration(context),
              child: Icon(Icons.error, size: AppStyles.kSize30, color: context.theme.colorScheme.onPrimary),
            ),
          ),
          AppStyles.kSizedBoxH16,
          Text(S.current.somethingWentWrong, style: _Styles.titleLabelTextStyle3(context), textAlign: TextAlign.center),
          AppStyles.kSizedBoxH8,
          Text(errorMessage, style: _Styles.descLabelTextStyle(context), textAlign: TextAlign.center),
          AppStyles.kSizedBoxH12,
          ...actionBuilders
        ],
      ),
      contentPadding: AppStyles.kPaddSV8H12,
      shape: RoundedRectangleBorder(borderRadius: AppStyles.kRad10),
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on AdaptiveAlertDialog {}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on AdaptiveAlertDialog {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on AdaptiveAlertDialog {}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Icon Outer Container Decoration
  static BoxDecoration iconOuterContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: AppColors.redColor.withAlpha(40),
      borderRadius: AppStyles.kRad100,
    );
  }

  // Icon Inner Container Decoration
  static BoxDecoration iconInnerContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: AppColors.redColor,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Title Label Text Style3
  static TextStyle titleLabelTextStyle3(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.medium);
  }

  // Desc Label Text Style3
  static TextStyle descLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
