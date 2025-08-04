import 'package:flutter/cupertino.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';

class CustomPickerDialog extends StatefulWidget {
  const CustomPickerDialog({
    required this.context,
    required this.items,
    required this.label,
    required this.desc,
    this.unit = '',
    this.initialItem = 0,
    required this.onItemSelected,
    super.key,
  });

  final BuildContext context;
  final List<String> items;
  final String label;
  final String? desc;
  final String? unit;
  final int initialItem;
  final Function(int index) onItemSelected;

  @override
  State<CustomPickerDialog> createState() => _CustomPickerDialogState();
}

class _CustomPickerDialogState extends State<CustomPickerDialog> {
  late int selectedItem;

  @override
  Widget build(BuildContext context) {
    selectedItem = widget.initialItem;
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
            getPicker(),
            AppStyles.kSizedBoxH4,
            getConfirmButton(),
          ],
        ),
      ),
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _CustomPickerDialogState {
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

  // Picker
  Widget getPicker() {
    return SizedBox(
      height: AppStyles.kSize100,
      child: CupertinoPicker(
        itemExtent: AppStyles.kSize30,
        scrollController: FixedExtentScrollController(initialItem: widget.initialItem),
        onSelectedItemChanged: (int value) {
          selectedItem = value;
        },
        children: widget.items.map((item) => getPickerItem(item)).toList(),
      ),
    );
  }

  // Picker Item
  Widget getPickerItem(String item) {
    return SizedBox(
      height: AppStyles.kSize30,
      child: Center(
        child: Text(
          '$item ${widget.unit}',
          style: _Styles.getPickerItemLabelTextStyle(context),
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
        widget.onItemSelected(selectedItem);
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
    return AltmannGrotesk.medium.withSize(FontSizes.medium);
  }

  // Confirm Button Label Text Style
  static TextStyle getConfirmButtonLabelTextStyle(BuildContext context) {
    return AltmannGrotesk.medium.withSize(FontSizes.small).copyWith(color: context.theme.colorScheme.onPrimary);
  }

  // Label Text Style
  static TextStyle getLabelTextStyle(BuildContext context) {
    return AltmannGrotesk.bold.withSize(FontSizes.large);
  }

  // Desc Label Text Style
  static TextStyle getDescLabelTextStyle(BuildContext context) {
    return AltmannGrotesk.thin.withSize(FontSizes.extraSmall);
  }
}
