import 'package:be_fitness_app/core/service/interfaces/enum_interface.dart';

enum TargetMuscles {
  abductors,
  abs,
  adductors,
  biceps,
  calves,
  cardiovascularSystem,
  delts,
  forearms,
  glutes,
  hamstrings,
  lats,
  levatorScapulae,
  pectorals,
  quads,
  serratusAnterior,
  spine,
  traps,
  triceps,
  upperBack
}

class TargetMusclesService implements EnumService<TargetMuscles> {
  @override
  String convertEnumToString(TargetMuscles enumType) {
    switch (enumType) {
      case TargetMuscles.abductors:
        return 'abductors';
      case TargetMuscles.abs:
        return 'abs';
      case TargetMuscles.adductors:
        return 'adductors';
      case TargetMuscles.biceps:
        return 'biceps';
      case TargetMuscles.calves:
        return 'calves';
      case TargetMuscles.cardiovascularSystem:
        return 'cardiovascular system';
      case TargetMuscles.delts:
        return 'delts';
      case TargetMuscles.forearms:
        return 'forearms';
      case TargetMuscles.glutes:
        return 'glutes';
      case TargetMuscles.hamstrings:
        return 'hamstrings';
      case TargetMuscles.lats:
        return 'lats';
      case TargetMuscles.levatorScapulae:
        return 'levator scapulae';
      case TargetMuscles.pectorals:
        return 'pectorals';
      case TargetMuscles.quads:
        return 'quads';
      case TargetMuscles.serratusAnterior:
        return 'serratus anterior';
      case TargetMuscles.spine:
        return 'spine';
      case TargetMuscles.traps:
        return 'traps';
      case TargetMuscles.triceps:
        return 'triceps';
      case TargetMuscles.upperBack:
        return 'upper back';
    }
  }

  @override
  TargetMuscles convertStringToEnum(String enumName) {
    switch (enumName) {
      case 'abductors':
        return TargetMuscles.abductors;
      case 'abs':
        return TargetMuscles.abs;
      case 'adductors':
        return TargetMuscles.adductors;
      case 'biceps':
        return TargetMuscles.biceps;
      case 'calves':
        return TargetMuscles.calves;
      case 'cardiovascular system':
        return TargetMuscles.cardiovascularSystem;
      case 'delts':
        return TargetMuscles.delts;
      case 'forearms':
        return TargetMuscles.forearms;
      case 'glutes':
        return TargetMuscles.glutes;
      case 'hamstrings':
        return TargetMuscles.hamstrings;
      case 'lats':
        return TargetMuscles.lats;
      case 'levator scapulae':
        return TargetMuscles.levatorScapulae;
      case 'pectorals':
        return TargetMuscles.pectorals;
      case 'quads':
        return TargetMuscles.quads;
      case 'serratus anterior':
        return TargetMuscles.serratusAnterior;
      case 'spine':
        return TargetMuscles.spine;
      case 'traps':
        return TargetMuscles.traps;
      case 'triceps':
        return TargetMuscles.triceps;
      case 'upper back':
        return TargetMuscles.upperBack;
      default:
        return TargetMuscles.abductors;
    }
  }
}
