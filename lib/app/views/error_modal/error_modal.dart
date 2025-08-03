import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class ErrorModal extends BaseStatefulPage {
  const ErrorModal({
    this.icon,
    this.iconBackgroundColor,
    required this.label,
    required this.description,
    this.actions,
    super.key,
  });

  final IconData? icon;
  final Color? iconBackgroundColor;
  final String label;
  final String description;
  final List<Widget>? actions;

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
            AppStyles.kSizedBoxH16,
            getLabel(),
            AppStyles.kSizedBoxH4,
            getDescriptionLabel(),
            AppStyles.kSizedBoxH20,
            ...?widget.actions
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ErrorModalState {
  // Icon
  Widget getIcon() {
    return Container(
      padding: AppStyles.kPadd8,
      decoration: _Styles.iconOuterContainerDecoration(context, widget.iconBackgroundColor),
      child: Container(
        padding: AppStyles.kPadd12,
        decoration: _Styles.iconInnerContainerDecoration(context, widget.iconBackgroundColor),
        child: Icon(widget.icon ?? Icons.error, size: AppStyles.kSize30, color: context.theme.colorScheme.onPrimary),
      ),
    );
  }

  // Label
  Widget getLabel() {
    return Text(
      widget.label,
      style: _Styles.labelTextStyle(context),
    );
  }

  // Description Label
  Widget getDescriptionLabel() {
    return Text(
      widget.description,
      textAlign: TextAlign.center,
      style: _Styles.descriptionTextStyle(context),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Icon Outer Container Decoration
  static BoxDecoration iconOuterContainerDecoration(BuildContext context, Color? iconBackgroundColor) {
    return BoxDecoration(
      color: iconBackgroundColor?.withAlpha(40) ?? context.theme.colorScheme.primary.withAlpha(40),
      borderRadius: AppStyles.kRad100,
    );
  }

  // Icon Inner Container Decoration
  static BoxDecoration iconInnerContainerDecoration(BuildContext context, Color? iconBackgroundColor) {
    return BoxDecoration(
      color: iconBackgroundColor ?? context.theme.colorScheme.primary,
      borderRadius: AppStyles.kRad100,
    );
  }

  // Label Text Style
  static TextStyle labelTextStyle(BuildContext context) {
    return AltmannGrotesk.bold.withSize(FontSizes.large);
  }

  // Description Text Style
  static TextStyle descriptionTextStyle(BuildContext context) {
    return AltmannGrotesk.regular
        .withSize(FontSizes.small)
        .copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
