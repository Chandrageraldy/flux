import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/button/app_text_span_button.dart';
import 'package:flux/app/widgets/text_form_field/app_auth_text_form_field.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';

@RoutePage()
class SignUpPage extends BaseStatefulPage {
  const SignUpPage({required this.bodyMetrics, super.key});

  final Map<String, String> bodyMetrics;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends BaseStatefulState<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  PreferredSizeWidget? appbar() => DefaultAppBar();

  @override
  void initState() => super.initState();

  @override
  void dispose() => super.dispose();

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
              AppStyles.kSizedBoxH4,
              getAppTitleLabel(),
              getSignUpDescriptionLabel(),
              AppStyles.kSizedBoxH16,
              Expanded(child: getFormBuilder()),
            ],
          ),
        ),
      ],
    );
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _SignUpPageState {
  void _onSignUpPressed() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final username = _formKey.currentState!.fields[FormFields.username.name]!.value as String;
      final email = _formKey.currentState!.fields[FormFields.email.name]!.value as String;
      final password = _formKey.currentState!.fields[FormFields.password.name]!.value as String;

      FocusScope.of(context).unfocus();

      final response = await tryLoad(
            context,
            () => context.read<UserViewModel>().signUpWithEmailAndPassword(
                email: email.trim(), password: password.trim(), username: username, bodyMetrics: widget.bodyMetrics),
          ) ??
          false;

      if (response && mounted) {
        context.router.replaceAll([PersonalizingPlanLoadingRoute()]);
      }
    }
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _SignUpPageState {
  // App Title Label
  Widget getAppTitleLabel() {
    return Text(
      S.current.signUpScreenTitle,
      style: _Styles.getAppTitleLabelTextStyle(context),
    );
  }

  // Sign Up Description Label
  Widget getSignUpDescriptionLabel() {
    return Text(
      S.current.signUpScreenDesc,
      style: _Styles.getSignUpDescriptionLabelTextStyle(context),
    );
  }

  // Form Builder
  Widget getFormBuilder() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        children: [
          getUsernameTextField(),
          AppStyles.kSizedBoxH16,
          getEmailTextField(),
          AppStyles.kSizedBoxH16,
          getPasswordTextField(),
          AppStyles.kSizedBoxH32,
          getSignUpButton(),
          Spacer(),
          getLogInCTAButton(),
          AppStyles.kSizedBoxH24,
        ],
      ),
    );
  }

  Widget getUsernameTextField() {
    return AppAuthTextFormField(
      field: FormFields.username,
      placeholder: S.current.usernameLabel,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
      ]),
    );
  }

  // Email Text Field
  Widget getEmailTextField() {
    return AppAuthTextFormField(
      field: FormFields.email,
      placeholder: S.current.emailLabel,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
      ]),
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
    );
  }

  // Sign Up Button
  Widget getSignUpButton() {
    return AppDefaultButton(label: S.current.signUpLabel, onPressed: _onSignUpPressed);
  }

  // Log In Button
  Widget getLogInCTAButton() {
    return AppTextSpanButton(
      primaryText: S.current.loginPrimarySpanText,
      secondaryText: S.current.loginSecondarySpanText,
      onPressed: () {},
    );
  }
}

// * ---------------------------- Styles -----------------------------
class _Styles {
  // App Title Text Style
  static getAppTitleLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.extraHuge).copyWith(color: context.theme.colorScheme.primary, height: 1);
  }

  // Sign Up Description Text Style
  static getSignUpDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.light.withSize(FontSizes.medium).copyWith(color: context.theme.colorScheme.onTertiary);
  }
}
