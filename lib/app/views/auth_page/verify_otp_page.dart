import 'dart:async';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/viewmodels/user_vm/user_view_model.dart';
import 'package:flux/app/widgets/app_bar/default_app_bar.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';
import 'package:flux/app/widgets/text_form_field/app_auth_text_form_field.dart';

@RoutePage()
class VerifyOtpPage extends BaseStatefulPage {
  const VerifyOtpPage({super.key, required this.email});

  final String email;

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends BaseStatefulState<VerifyOtpPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _isVerifyEnabled = false;

  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppStyles.kSpac16,
            children: [
              AppStyles.kSizedBoxH100,
              getIcon(),
              AppStyles.kSizedBoxH2,
              getTitleLabel(),
              getVerifyEmailDescriptionLabel(),
              AppStyles.kSizedBoxH16,
              Expanded(child: getFormBuilder()),
            ],
          ),
        ),
      ],
    );
  }

  // Enable Set State inside Extension
  void _setState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _VerifyOtpPageState {
  Future<void> _onVerifyPressed() async {
    final otp1 = _formKey.currentState!.fields[FormFields.otp1.name]?.value as String? ?? '';
    final otp2 = _formKey.currentState!.fields[FormFields.otp2.name]?.value as String? ?? '';
    final otp3 = _formKey.currentState!.fields[FormFields.otp3.name]?.value as String? ?? '';
    final otp4 = _formKey.currentState!.fields[FormFields.otp4.name]?.value as String? ?? '';
    final otp5 = _formKey.currentState!.fields[FormFields.otp5.name]?.value as String? ?? '';
    final otp6 = _formKey.currentState!.fields[FormFields.otp6.name]?.value as String? ?? '';

    final otp = otp1 + otp2 + otp3 + otp4 + otp5 + otp6;
    final response =
        await tryLoad(context, () => context.read<UserViewModel>().verifyOtp(email: widget.email, otp: otp));

    if (response == true && mounted) {
      context.router.push(ResetPasswordRoute(email: widget.email));
    }
  }

  void _onOtpChanged(String? value, int index) {
    if (value?.length == 1 && index != 5) {
      FocusScope.of(context).nextFocus();
    } else if (value?.length == 1 && index == 5) {
      FocusScope.of(context).unfocus();
    } else if (value?.isEmpty == true && index != 0) {
      FocusScope.of(context).previousFocus();
    }

    final otp1 = _formKey.currentState!.fields[FormFields.otp1.name]?.value as String? ?? '';
    final otp2 = _formKey.currentState!.fields[FormFields.otp2.name]?.value as String? ?? '';
    final otp3 = _formKey.currentState!.fields[FormFields.otp3.name]?.value as String? ?? '';
    final otp4 = _formKey.currentState!.fields[FormFields.otp4.name]?.value as String? ?? '';
    final otp5 = _formKey.currentState!.fields[FormFields.otp5.name]?.value as String? ?? '';
    final otp6 = _formKey.currentState!.fields[FormFields.otp6.name]?.value as String? ?? '';

    if (otp1.isNotEmpty &&
        otp2.isNotEmpty &&
        otp3.isNotEmpty &&
        otp4.isNotEmpty &&
        otp5.isNotEmpty &&
        otp6.isNotEmpty) {
      _setState(() {
        _isVerifyEnabled = true;
      });
    } else {
      _setState(() {
        _isVerifyEnabled = false;
      });
    }
  }

  Future<void> _onResendPressed() async {
    await tryLoad(context, () => context.read<UserViewModel>().sendResetToken(email: widget.email));
    _startTimer();
  }
}

// * ------------------------ PrivateMethods -------------------------
extension _PrivateMethods on _VerifyOtpPageState {
  void _startTimer() {
    _setState(() {
      _secondsRemaining = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        _setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _VerifyOtpPageState {
  // Icon
  Widget getIcon() {
    return Container(
      padding: AppStyles.kPadd8,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: context.theme.colorScheme.tertiary),
        borderRadius: AppStyles.kRad10,
      ),
      child: Icon(Icons.email_outlined, size: AppStyles.kSize24, color: context.theme.colorScheme.secondary),
    );
  }

  // Title Label
  Widget getTitleLabel() {
    return Text(
      S.current.checkYourEmailLabel,
      style: _Styles.getTitleLabelTextStyle(context),
    );
  }

  // Verify Email Description Label
  Widget getVerifyEmailDescriptionLabel() {
    return Text(
      S.current.verifyEmailDesc,
      style: _Styles.getVerifyEmailDescriptionLabelTextStyle(context),
      textAlign: TextAlign.center,
    );
  }

  // Form Builder
  Widget getFormBuilder() {
    return FormBuilder(
      key: _formKey,
      child: Column(
        spacing: AppStyles.kSpac16,
        children: [
          Row(
            spacing: AppStyles.kSpac8,
            children: [
              Expanded(child: getOtp1TextField()),
              Expanded(child: getOtp2TextField()),
              Expanded(child: getOtp3TextField()),
              Expanded(child: getOtp4TextField()),
              Expanded(child: getOtp5TextField()),
              Expanded(child: getOtp6TextField()),
            ],
          ),
          getVerifyButton(),
          _secondsRemaining > 0
              ? Text(
                  'Resend code in ${_formatTime(_secondsRemaining)}',
                  style: _Styles.getResendCodeWithTimerTextStyle(context),
                )
              : GestureDetector(
                  onTap: _onResendPressed,
                  child: Text('Resend Code', style: _Styles.getResendCodeButtonTextStyle(context)),
                ),
        ],
      ),
    );
  }

  // Otp 1 Text Field
  Widget getOtp1TextField() {
    return AppAuthTextFormField(
      field: FormFields.otp1,
      placeholder: '',
      validator: null,
      height: AppStyles.kSize50,
      padding: AppStyles.kPadd0,
      onChanged: (value) => _onOtpChanged(value, 0),
      isCenter: true,
      keyboardType: TextInputType.number,
    );
  }

  // Otp 2 Text Field
  Widget getOtp2TextField() {
    return AppAuthTextFormField(
      field: FormFields.otp2,
      placeholder: '',
      validator: null,
      height: AppStyles.kSize50,
      padding: AppStyles.kPadd0,
      onChanged: (value) => _onOtpChanged(value, 1),
      isCenter: true,
      keyboardType: TextInputType.number,
    );
  }

  // Otp 3 Text Field
  Widget getOtp3TextField() {
    return AppAuthTextFormField(
      field: FormFields.otp3,
      placeholder: '',
      validator: null,
      height: AppStyles.kSize50,
      padding: AppStyles.kPadd0,
      onChanged: (value) => _onOtpChanged(value, 2),
      isCenter: true,
      keyboardType: TextInputType.number,
    );
  }

  // Otp 4 Text Field
  Widget getOtp4TextField() {
    return AppAuthTextFormField(
      field: FormFields.otp4,
      placeholder: '',
      validator: null,
      height: AppStyles.kSize50,
      padding: AppStyles.kPadd0,
      onChanged: (value) => _onOtpChanged(value, 3),
      isCenter: true,
      keyboardType: TextInputType.number,
    );
  }

  // Otp 5 Text Field
  Widget getOtp5TextField() {
    return AppAuthTextFormField(
      field: FormFields.otp5,
      placeholder: '',
      validator: null,
      height: AppStyles.kSize50,
      padding: AppStyles.kPadd0,
      onChanged: (value) => _onOtpChanged(value, 4),
      isCenter: true,
      keyboardType: TextInputType.number,
    );
  }

  // Otp 6 Text Field
  Widget getOtp6TextField() {
    return AppAuthTextFormField(
      field: FormFields.otp6,
      placeholder: '',
      validator: null,
      height: AppStyles.kSize50,
      padding: AppStyles.kPadd0,
      onChanged: (value) => _onOtpChanged(value, 5),
      isCenter: true,
      keyboardType: TextInputType.number,
    );
  }

  // Verify Button
  Widget getVerifyButton() {
    return AppDefaultButton(
      label: S.current.verifyLabel,
      onPressed: _isVerifyEnabled ? _onVerifyPressed : null,
      padding: AppStyles.kPaddSV15,
      borderRadius: AppStyles.kRad10,
      labelStyle: Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary),
      backgroundColor: context.theme.colorScheme.secondary,
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Title Text Style
  static getTitleLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.extraLarge).copyWith(color: context.theme.colorScheme.primary, height: 1);
  }

  // Verify Email Description Text Style
  static getVerifyEmailDescriptionLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Resend Code With Timer Text Style
  static getResendCodeWithTimerTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onTertiaryContainer);
  }

  // Resend Code Button Text Style
  static getResendCodeButtonTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.secondary);
  }
}
