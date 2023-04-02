import 'package:be_fitness_app/core/service/interfaces/enum_interface.dart';

enum Gender { male, female }

class GenderService implements EnumService<Gender> {
  @override
  String convertEnumToString(Gender enumType) {
    switch (enumType) {
      case Gender.male:
        return 'male';
      case Gender.female:
        return 'female';
    }
  }

  @override
  Gender convertStringToEnum(String enumName) {
    switch (enumName) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.male;
    }
  }
}
