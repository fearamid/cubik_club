import 'package:flutter/services.dart';

class PasswordInputFormatter extends TextInputFormatter {
  static bool checkPasswordComplexity({
    required String password,
    required int length,
    required List<String> patternsToEscape,
    required bool caseSensitivity,
    required bool numericDigits,
  }) {
    if (password.length < length) {
      return false;
    }
    if (caseSensitivity) {
      final hasUpperCase = RegExp("[A-Z]").hasMatch(password);
      if (!hasUpperCase) {
        return false;
      }

      final hasLowerCase = RegExp("[a-z]").hasMatch(password);
      if (!hasLowerCase) {
        return false;
      }
    }
    if (numericDigits) {
      final hasNumbers = RegExp("\\d").hasMatch(password);
      if (!hasNumbers) {
        return false;
      }
    }
    if (patternsToEscape.isNotEmpty) {
      final passwordLowerCase = password.toLowerCase();

      for (int i = 0; i < patternsToEscape.length; i++) {
        final hasMatchesWithPattern =
            RegExp(patternsToEscape[i]).hasMatch(passwordLowerCase);
        if (hasMatchesWithPattern) return false;
      }
    }
    return true;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'[^a-zA-Z\d_.!()]', unicode: true);
    final clearText = newValue.text.replaceAll(regExp, '');
    final value =
        clearText.substring(0, clearText.length < 21 ? clearText.length : 21);
    // final value = checkPasswordComplexity(
    //   password: newValue.text,
    //   length: 8,
    //   patternsToEscape: ['qwe'],
    //   caseSensitivity: false,
    //   numericDigits: true,
    // );

    return TextEditingValue(text: value);
  }
}
