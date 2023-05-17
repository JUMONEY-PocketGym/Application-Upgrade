class Validator {
  Validator._();

  static Map<String, bool> _isOverEightChars(String value) {
    final regexCount = RegExp(".{8}");
    return regexCount.hasMatch(value) ? {"8자 이상 o  ": true} : {"8자 이상 x  ": false};
  }

  static Map<String, bool> _hasUpperCaseLetter(String value) {
    final regexUpper = RegExp("[A-Z]");
    return regexUpper.hasMatch(value) ? {"대문자 포함 o  ": true} : {"대문자 포함 x  ": false};
  }

  static Map<String, bool> _hasLowerCaseLetter(String value) {
    final regexLower = RegExp("[a-z]");
    return regexLower.hasMatch(value) ? {"소문자 포함 o  ": true} : {"소문자 포함 x  ": false};
  }

  static Map<String, bool> _hasNumber(String value) {
    final regexNumber = RegExp("[0-9]");
    return regexNumber.hasMatch(value) ? {"숫자 포함 o  ": true} : {"숫자 포함 x  ": false};
  }

  static String? validateEmail(String value) {
    final regexEmail = RegExp(
        r'''(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])''');
    return regexEmail.hasMatch(value) ? null : '이메일 방식 아닙니다';
  }

  static Map<String, bool> validatePassword(String value) {
    return {
      ..._isOverEightChars(value),
      // ..._hasUpperCaseLetter(value),
      ..._hasLowerCaseLetter(value),
      ..._hasNumber(value)
    };
  }
}
