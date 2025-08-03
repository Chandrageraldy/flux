import 'package:flutter/cupertino.dart';
import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:flux/app/widgets/button/app_default_button.dart';

class PickerDialog extends StatefulWidget {
  const PickerDialog({
    required this.context,
    required this.items,
    this.unit = '',
    this.initialItem = 0,
    required this.label,
    required this.desc,
    required this.onItemSelected,
    super.key,
  });

  final BuildContext context;
  final List<String> items;
  final String? unit;
  final int initialItem;
  final String label;
  final String? desc;
  final Function(int index) onItemSelected;

  @override
  State<PickerDialog> createState() => _PickerDialogState();
}

class _PickerDialogState extends State<PickerDialog> {
  @override
  Widget build(BuildContext context) {
    int selectedItem = widget.initialItem;
    return Dialog(
      backgroundColor: context.theme.colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: AppStyles.kRad10),
      insetPadding: AppStyles.kPaddSH36,
      child: Padding(
        padding: AppStyles.kPaddOL12R12T16B8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppStyles.kSpac4,
          children: [
            Center(child: Text(widget.label, style: AltmannGrotesk.bold.withSize(FontSizes.large))),
            SizedBox(
              height: AppStyles.kSize100,
              child: CupertinoPicker(
                itemExtent: AppStyles.kSize30,
                scrollController: FixedExtentScrollController(initialItem: widget.initialItem),
                onSelectedItemChanged: (int value) {
                  selectedItem = value;
                },
                children: widget.items
                    .map(
                      (item) => SizedBox(
                        height: AppStyles.kSize30,
                        child: Center(
                          child: Text(
                            '$item ${widget.unit}',
                            style: AltmannGrotesk.medium.withSize(FontSizes.medium),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Text(
              widget.desc ?? '',
              style: AltmannGrotesk.thin.withSize(FontSizes.extraSmall),
              textAlign: TextAlign.justify,
            ),
            Row(
              spacing: AppStyles.kSpac8,
              children: [
                Expanded(
                  child: AppDefaultButton(
                    label: S.current.cancelLabel,
                    onPressed: () => Navigator.of(context).pop(selectedItem),
                    padding: AppStyles.kPaddSV8,
                    borderRadius: AppStyles.kRad6,
                    labelStyle: AltmannGrotesk.medium.withSize(FontSizes.small).copyWith(
                          color: context.theme.colorScheme.primary,
                        ),
                    backgroundColor: context.theme.colorScheme.tertiaryFixedDim,
                  ),
                ),
                Expanded(
                  child: AppDefaultButton(
                    label: S.current.confirmLabel,
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onItemSelected(selectedItem);
                    },
                    padding: AppStyles.kPaddSV8,
                    borderRadius: AppStyles.kRad6,
                    labelStyle: AltmannGrotesk.medium
                        .withSize(FontSizes.small)
                        .copyWith(color: context.theme.colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
