import 'package:be_fitness_app/core/service/interfaces/enum_interface.dart';

enum Level { beginner, intermediate, advanced }

class LevelService implements EnumService<Level> {
  @override
  String convertEnumToString(Level enumType) {
    switch (enumType) {
      case Level.beginner:
        return 'beginner';
      case Level.intermediate:
        return 'intermediate';
      case Level.advanced:
        return 'advanced';
    }
  }

  @override
  Level convertStringToEnum(String enumName) {
    switch (enumName) {
      case 'beginner':
        return Level.beginner;
      case 'intermediate':
        return Level.intermediate;
      case 'advanced':
        return Level.advanced;
      default:
        return Level.beginner;
    }
  }
}
