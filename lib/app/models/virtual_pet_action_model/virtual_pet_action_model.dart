import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VirtualPetActionModel {
  final String label;
  final int exp;
  final IconData icon;
  final int energy;

  VirtualPetActionModel({
    required this.label,
    required this.exp,
    required this.icon,
    required this.energy,
  });
}

final List<VirtualPetActionModel> virtualPetActions = [
  VirtualPetActionModel(
    label: 'Feed',
    exp: 10,
    icon: FontAwesomeIcons.apple,
    energy: 5,
  ),
  VirtualPetActionModel(
    label: 'Play',
    exp: 15,
    icon: FontAwesomeIcons.baseball,
    energy: 10,
  ),
  VirtualPetActionModel(
    label: 'Groom',
    exp: 20,
    icon: FontAwesomeIcons.scissors,
    energy: 15,
  ),
];
