import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    required this.field,
    this.placeholder,
    required this.validator,
    this.icon,
    this.initialValue,
    this.topLabel,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.height,
    this.borderRadius,
    this.hasBorder = false,
    this.backgroundColor,
    this.padding,
    this.maxLines = 1,
    this.minLines,
    this.topLabelTextStyle,
    this.borderColor,
    super.key,
  });

  final FormFields field;
  final String? placeholder;
  final String? Function(String? value)? validator;
  final FaIcon? icon;
  final String? initialValue;
  final String? topLabel;
  final void Function(String? value)? onChanged;
  final TextInputType keyboardType;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final bool? hasBorder;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final int? maxLines;
  final int? minLines;
  final TextStyle? topLabelTextStyle;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topLabel != null) Text(topLabel!, style: _Styles.getTopLabelTextStyle(context, topLabelTextStyle)),
        if (topLabel != null) AppStyles.kSizedBoxH4,
        Container(
          padding: padding ?? AppStyles.kPaddSH20,
          height: height ?? AppStyles.kSize48,
          decoration: _Styles.getContainerDecoration(context, borderRadius, hasBorder, backgroundColor, borderColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [if (icon != null) icon!, if (icon != null) AppStyles.kSizedBoxW8, getTextFormField(context)],
          ),
        ),
      ],
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on AppTextFormField {
  // Get Text Form Field
  Widget getTextFormField(BuildContext context) {
    return Expanded(
      child: FormBuilderTextField(
        initialValue: initialValue,
        minLines: minLines,
        maxLines: maxLines,
        name: field.name,
        style: _Styles.getTextFormFieldTextStyle(),
        decoration: _Styles.getTextFormFieldInputDecoration(placeholder ?? ''),
        obscureText: field == FormFields.password,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged == null
            ? null
            : (value) {
                onChanged!(value);
              },
      ),
    );
  }
}

// * ----------------------------- Styles -----------------------------
abstract class _Styles {
  // Container Decoration
  static BoxDecoration getContainerDecoration(BuildContext context, BorderRadiusGeometry? borderRadius, bool? hasBorder,
      Color? backgroundColor, Color? borderColor) {
    return BoxDecoration(
      color: backgroundColor ?? context.theme.colorScheme.tertiaryFixedDim,
      borderRadius: borderRadius ?? AppStyles.kRad100,
      border:
          hasBorder == true ? Border.all(color: borderColor ?? context.theme.colorScheme.onTertiary, width: 0.5) : null,
    );
  }

  // Text Form Field Input Decoration
  static InputDecoration getTextFormFieldInputDecoration(String placeholder) {
    return InputDecoration(
      isDense: true,
      border: InputBorder.none,
      hintText: placeholder,
      contentPadding: EdgeInsets.zero,
    );
  }

  // Text Form Field Text Style
  static TextStyle getTextFormFieldTextStyle() {
    return Quicksand.light.withSize(FontSizes.small);
  }

  // Top Label Text Style
  static TextStyle getTopLabelTextStyle(BuildContext context, TextStyle? topLabelTextStyle) {
    return topLabelTextStyle ??
        Quicksand.medium.withSize(FontSizes.extraSmall).copyWith(color: context.theme.colorScheme.tertiaryFixed);
  }
}
