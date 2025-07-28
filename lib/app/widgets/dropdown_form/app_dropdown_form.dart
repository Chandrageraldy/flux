import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AppDropdownForm extends StatelessWidget {
  const AppDropdownForm({
    required this.field,
    required this.validator,
    required this.items,
    this.initialValue,
    this.topLabel,
    this.onChanged,
    this.height,
    super.key,
  });

  final FormFields field;
  final String? Function(String? value)? validator;
  final List<DropdownMenuItem<String>> items;
  final String? initialValue;
  final String? topLabel;
  final ValueChanged<String?>? onChanged;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topLabel != null) Text(topLabel!, style: _Styles.getTopLabelTextStyle(context)),
        if (topLabel != null) AppStyles.kSizedBoxH4,
        Container(
          padding: AppStyles.kPaddSH20,
          height: height ?? AppStyles.kSize48,
          decoration: _Styles.getContainerDecoration(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [getDropdownField(context)],
          ),
        ),
      ],
    );
  }
}

extension _WidgetFactories on AppDropdownForm {
  Widget getDropdownField(BuildContext context) {
    return Expanded(
      child: FormBuilderDropdown<String>(
        initialValue: initialValue,
        name: field.name,
        items: items,
        validator: validator,
        decoration: _Styles.getDropdownDecoration(context),
        style: _Styles.getTextFormFieldTextStyle(context),
        onChanged: onChanged,
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context) {
    return BoxDecoration(color: context.theme.colorScheme.tertiaryFixedDim, borderRadius: AppStyles.kRad10);
  }

  // Dropdown Input Decoration
  static InputDecoration getDropdownDecoration(BuildContext context) {
    return InputDecoration(
      isDense: true,
      border: InputBorder.none,
      hintStyle: Quicksand.regular.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.primary),
    );
  }

  // Text Form Field Text Style
  static TextStyle getTextFormFieldTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.primary);
  }

  // Top Label Text Style
  static TextStyle getTopLabelTextStyle(BuildContext context) {
    return Quicksand.semiBold.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.tertiaryFixed);
  }
}
