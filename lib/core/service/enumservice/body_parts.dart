import 'package:be_fitness_app/core/service/interfaces/enum_interface.dart';

enum BodyPart {
  back,
  cardio,
  chest,
  arms,
  legs,
  neck,
  shoulders,
  waist,
  abs,
}

class BodyPartService implements EnumService<BodyPart> {
  @override
  String convertEnumToString(BodyPart enumType) {
    switch (enumType) {
      case BodyPart.back:
        return 'back';
      case BodyPart.cardio:
        return 'cardio';
      case BodyPart.chest:
        return 'chest';
      case BodyPart.arms:
        return 'arms';
      case BodyPart.legs:
        return 'legs';
      case BodyPart.neck:
        return 'neck';
      case BodyPart.shoulders:
        return 'shoulders';
      case BodyPart.waist:
        return 'waist';
      case BodyPart.abs:
        return 'abs';
    }
  }

  @override
  BodyPart convertStringToEnum(String enumName) {
    switch (enumName) {
      case 'back':
        return BodyPart.back;
      case 'cardio':
        return BodyPart.cardio;
      case 'chest':
        return BodyPart.chest;
      case 'arms':
        return BodyPart.arms;
      case 'legs':
        return BodyPart.legs;
      case 'neck':
        return BodyPart.neck;
      case 'shoulders':
        return BodyPart.shoulders;
      case 'waist':
        return BodyPart.waist;
      case 'abs':
        return BodyPart.abs;
      default:
        return BodyPart.back;
    }
  }
}
