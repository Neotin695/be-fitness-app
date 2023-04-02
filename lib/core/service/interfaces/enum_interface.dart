abstract class EnumService<T> {
  String convertEnumToString(T enumType);
  T convertStringToEnum(String enumName);
}
