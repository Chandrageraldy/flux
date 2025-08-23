import 'package:flux/app/assets/exporter/exporter_app_general.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VirtualPetActionModel {
  final String label;
  final int exp;
  final IconData icon;
  final int energy;
  final Color color;

  VirtualPetActionModel({
    required this.label,
    required this.exp,
    required this.icon,
    required this.energy,
    required this.color,
  });
}

final List<VirtualPetActionModel> virtualPetActions = [
  VirtualPetActionModel(
    label: 'Feed',
    exp: 10,
    icon: FontAwesomeIcons.appleWhole,
    energy: 5,
    color: MacroNutrients.protein.color,
  ),
  VirtualPetActionModel(
    label: 'Play',
    exp: 15,
    icon: FontAwesomeIcons.baseball,
    energy: 10,
    color: MacroNutrients.carbs.color,
  ),
  VirtualPetActionModel(
    label: 'Pet',
    exp: 20,
    icon: FontAwesomeIcons.solidHeart,
    energy: 15,
    color: MacroNutrients.fat.color,
  ),
];
