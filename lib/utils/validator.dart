class Validators {
  static String? validateNotEmpty(String? value, String fieldName) {
    return value?.isNotEmpty == true ? null : "$fieldName must not be empty";
  }

  static String? validateIsNumber(String? value, String fieldName) {
    return value?.isNotEmpty == true ? null : "$fieldName must not be empty";
  }
}
