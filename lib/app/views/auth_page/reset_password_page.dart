import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/utils/utils/utils.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/text_form_field/app_auth_text_form_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

@RoutePage()
class ResetPasswordPage extends BaseStatefulPage {
  const ResetPasswordPage({super.key, required this.email});

  final String email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends BaseStatefulState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  bool resizeToAvoidBottomInset() => true;

  @override
  PreferredSizeWidget? appbar() => DefaultAppBar();

  @override
  Widget body() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppStyles.kSpac16,
            children: [
              getTitleLabel(),
              getResetPasswordDescriptionLabel(),
              AppStyles.kSizedBoxH4,
              Expanded(child: getFormBuilder()),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _ResetPasswordPageState {
  Future<void> _onResetPasswordPressed() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final password = _formKey.currentState!.fields[FormFields.password.name]?.value as String? ?? '';
      final confirmPassword = _formKey.currentState!.fields[FormFields.confirmPassword.name]?.value as String? ?? '';

      if (password != confirmPassword) {
        WidgetUtils.showSnackBar(context, S.current.passwordsDoNotMatchError);
        return;
      }

      final response = await tryLoad(context, () => context.read<UserViewModel>().resetPassword(password: password));
      if (response == true && mounted) {
        context.router.replaceAll([RootRoute()]);
      }
    }
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _ResetPasswordPageState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _ResetPasswordPageState {
  // Title Label
  Widget getTitleLabel() {
    return Text(
      S.current.resetYourPasswordLabel,
      style: _Styles.getTitleLabelTextStyle(context),
    );
  }

  // Reset Password Description Label
  Widget getResetPasswordDescriptionLabel() {
    return Text(
      S.current.resetPasswordDesc,
      style: _Styles.getResetPasswordDescriptionLabelTextStyle(context),
    );
  }

  // Form Builder
  Widget getFormBuilder() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        spacing: AppStyles.kSpac16,
        children: [
          getPasswordTextField(),
          getConfirmPasswordTextField(),
          Spacer(),
          getResetPasswordButton(),
          AppStyles.kSizedBoxH4,
        ],
      ),
    );
  }

  // Password Text Field
  Widget getPasswordTextField() {
    return AppAuthTextFormField(
      field: FormFields.password,
      placeholder: S.current.passwordLabel,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(8),
      ]),
      icon: Icons.lock_outline,
      height: AppStyles.kSize50,
    );
  }

  // Confirm Password Text Field
  Widget getConfirmPasswordTextField() {
    return AppAuthTextFormField(
      field: FormFields.confirmPassword,
      placeholder: S.current.confirmPasswordLabel,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(8),
      ]),
      icon: Icons.lock_outline,
      height: AppStyles.kSize50,
    );
  }

  // Reset Password Button
  Widget getResetPasswordButton() {
    return AppDefaultButton(
      label: S.current.resetPasswordLabel,
      onPressed: _onResetPasswordPressed,
      padding: AppStyles.kPaddSV15,
      borderRadius: AppStyles.kRad10,
      labelStyle: Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary),
      backgroundColor: context.theme.colorScheme.primary,
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Title Text Style
  static getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary, height: 1);
  }

  // Reset Password Description Text Style
  static getResetPasswordDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }
}
