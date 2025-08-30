import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AppAuthTextFormField extends StatelessWidget {
  const AppAuthTextFormField({
    required this.field,
    required this.placeholder,
    required this.validator,
    this.height,
    this.icon,
    this.borderRadius,
    this.onChanged,
    this.isCenter = false,
    this.padding,
    this.keyboardType,
    super.key,
  });

  final FormFields field;
  final String placeholder;
  final String? Function(String? value)? validator;
  final double? height;
  final IconData? icon;
  final BorderRadiusGeometry? borderRadius;
  final void Function(String? value)? onChanged;
  final bool? isCenter;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.colorScheme.secondary.withAlpha(30),
        borderRadius: borderRadius ?? AppStyles.kRad10,
      ),
      padding: padding ?? AppStyles.kPaddSH20,
      height: height ?? AppStyles.kSize56,
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: AppStyles.kSize20, color: context.theme.colorScheme.secondary),
          if (icon != null) AppStyles.kSizedBoxW8,
          Expanded(
            child: FormBuilderTextField(
              name: field.name,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: placeholder,
                contentPadding: EdgeInsets.zero,
              ),
              textAlign: isCenter == true ? TextAlign.center : TextAlign.start,
              obscureText: field == FormFields.password || field == FormFields.confirmPassword,
              validator: validator,
              style: Quicksand.light.withSize(FontSizes.medium),
              onChanged: onChanged,
              keyboardType: keyboardType ?? TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}
