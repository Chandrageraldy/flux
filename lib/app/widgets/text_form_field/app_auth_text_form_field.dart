import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

class AppAuthTextFormField extends StatelessWidget {
  const AppAuthTextFormField(
      {required this.field, required this.placeholder, required this.validator, this.height, super.key});

  final FormFields field;
  final String placeholder;
  final String? Function(String? value)? validator;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: field.name,
      decoration: InputDecoration(
        hintText: placeholder,
        filled: true,
        fillColor: context.theme.colorScheme.onPrimary,
        border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: AppStyles.kRad10),
        contentPadding: AppStyles.kPaddSV20H16,
      ),
      obscureText: field == FormFields.password ? true : false,
      validator: validator,
      style: Quicksand.regular.withSize(FontSizes.medium),
    );
  }
}
