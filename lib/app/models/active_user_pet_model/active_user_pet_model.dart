// ignore_for_file: invalid_annotation_target

import 'package:flux/app/models/virtual_pets_model/virtual_pets_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_user_pet_model.freezed.dart';
part 'active_user_pet_model.g.dart';

@freezed
class ActiveUserPetModel with _$ActiveUserPetModel {
  factory ActiveUserPetModel({
    int? id,
    String? userId,
    int? petId,
    bool? isActive,
    int? currentExp,
    @JsonKey(name: 'virtual_pets') VirtualPetsModel? virtualPet,
  }) = _ActiveUserPetModel;

  factory ActiveUserPetModel.fromJson(Map<String, dynamic> json) => _$ActiveUserPetModelFromJson(json);
}

extension ActiveUserPetExtensions on ActiveUserPetModel {
  int getCurrentLevel() {
    final exp = currentExp ?? 0;
    final vp = virtualPet!;

    if (exp >= (vp.requiredExpLvl3 ?? 0)) {
      return 4;
    } else if (exp >= (vp.requiredExpLvl2 ?? 0)) {
      return 3;
    } else if (exp >= (vp.requiredExpLvl1 ?? 0)) {
      return 2;
    } else {
      return 1;
    }
  }

  /// For Linear Percent Indicator
  double getLevelProgress() {
    final exp = currentExp ?? 0;
    final vp = virtualPet!;

    int currentLevel = getCurrentLevel();
    int baseExp = 0;
    int nextExp = 0;

    switch (currentLevel) {
      case 1:
        baseExp = 0;
        nextExp = vp.requiredExpLvl1 ?? 0;
        break;
      case 2:
        baseExp = vp.requiredExpLvl1 ?? 0;
        nextExp = vp.requiredExpLvl2 ?? 0;
        break;
      case 3:
        baseExp = vp.requiredExpLvl2 ?? 0;
        nextExp = vp.requiredExpLvl3 ?? 0;
        break;
      case 4:
        baseExp = vp.requiredExpLvl3 ?? 0;
        nextExp = baseExp; // maxed out, no next level
        break;
    }

    final progress = (exp - baseExp) / (nextExp - baseExp);
    return progress.clamp(0.0, 1.0);
  }

  /// Exp display text, like "150 / 300 EXP"
  String getExpProgressText() {
    final exp = currentExp ?? 0;
    final vp = virtualPet!;
    final level = getCurrentLevel();

    int baseExp = 0;
    int nextExp = 0;

    switch (level) {
      case 1:
        baseExp = 0;
        nextExp = vp.requiredExpLvl1 ?? 0;
        break;
      case 2:
        baseExp = vp.requiredExpLvl1 ?? 0;
        nextExp = vp.requiredExpLvl2 ?? 0;
        break;
      case 3:
        baseExp = vp.requiredExpLvl2 ?? 0;
        nextExp = vp.requiredExpLvl3 ?? 0;
        break;
      case 4:
        baseExp = vp.requiredExpLvl3 ?? 0;
        nextExp = baseExp; // max level
        break;
    }

    if (level == 4) {
      return '$exp EXP (MAX)';
    } else {
      return '${exp - baseExp} / ${nextExp - baseExp} EXP';
    }
  }

  String getPetAnimationUrl() {
    final level = getCurrentLevel();
    final vp = virtualPet!;

    switch (level) {
      case 1:
        return vp.lvl1Url ?? '';
      case 2:
        return vp.lvl2Url ?? '';
      case 3:
        return vp.lvl3Url ?? '';
      case 4:
        return vp.lvl4Url ?? '';
      default:
        return vp.lvl1Url ?? '';
    }
  }
}
