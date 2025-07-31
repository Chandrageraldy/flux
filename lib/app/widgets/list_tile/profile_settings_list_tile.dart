import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSettingsListTile extends StatelessWidget {
  const ProfileSettingsListTile({required this.icon, required this.label, this.desc, super.key});

  final FaIcon icon;
  final String label;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Text(label),
        Spacer(),
        FaIcon(FontAwesomeIcons.chevronRight),
      ],
    );
  }
}
