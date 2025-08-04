import 'package:flutter/cupertino.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';

class CustomDatePickerDialog extends StatefulWidget {
  const CustomDatePickerDialog({
    required this.context,
    required this.label,
    this.desc,
    required this.onDateSelected,
    required this.initialDate,
    super.key,
  });

  final BuildContext context;
  final String label;
  final String? desc;
  final Function(DateTime date) onDateSelected;
  final DateTime initialDate;

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    selectedDate = widget.initialDate;
    return Dialog(
      backgroundColor: context.theme.colorScheme.onPrimary,
      shape: _Styles.getDialogShape(),
      insetPadding: AppStyles.kPaddSH36,
      child: Padding(
        padding: AppStyles.kPaddOL15R15T16B8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac4,
          children: [
            getTopRow(),
            getDescLabel(),
            AppStyles.kSizedBoxH4,
            getDatePicker(),
            AppStyles.kSizedBoxH4,
            getConfirmButton(),
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomDatePickerDialogState {
  // Top Row
  Widget getTopRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.label, style: _Styles.getLabelTextStyle(context)),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.close, size: AppStyles.kSize20, color: context.theme.colorScheme.onTertiaryContainer),
        )
      ],
    );
  }

  // Desc Label
  Widget getDescLabel() {
    return Text(
      widget.desc ?? '',
      style: _Styles.getDescLabelTextStyle(context),
      textAlign: TextAlign.justify,
    );
  }

  // Date Picker
  Widget getDatePicker() {
    return SizedBox(
      height: AppStyles.kSize100,
      child: CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(
          textTheme: CupertinoTextThemeData(dateTimePickerTextStyle: _Styles.getPickerItemLabelTextStyle(context)),
        ),
        child: CupertinoDatePicker(
          itemExtent: AppStyles.kSize26,
          mode: CupertinoDatePickerMode.date,
          initialDateTime: widget.initialDate,
          maximumDate: DateTime.now(),
          onDateTimeChanged: (DateTime date) {
            selectedDate = date;
          },
        ),
      ),
    );
  }

  // Confirm Button
  Widget getConfirmButton() {
    return AppDefaultButton(
      label: S.current.confirmLabel,
      onPressed: () {
        Navigator.of(context).pop();
        widget.onDateSelected(selectedDate);
      },
      padding: AppStyles.kPaddSV8,
      borderRadius: AppStyles.kRad6,
      labelStyle: _Styles.getConfirmButtonLabelTextStyle(context),
    );
  }
}

// * ----------------------------- Styles ----------------------------
abstract class _Styles {
  // Dialog Shape
  static ShapeBorder getDialogShape() {
    return RoundedRectangleBorder(borderRadius: AppStyles.kRad10);
  }

  // Picker Item Label Text Style
  static TextStyle getPickerItemLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.medium);
  }

  // Confirm Button Label Text Style
  static TextStyle getConfirmButtonLabelTextStyle(BuildContext context) {
    return Quicksand.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return Quicksand.bold.withSize(FontSizes.large);
  }

  // Desc Label Text Style
  static TextStyle getDescLabelTextStyle(BuildContext context) {
    return Quicksand.light.withSize(FontSizes.extraSmall);
  }
}
