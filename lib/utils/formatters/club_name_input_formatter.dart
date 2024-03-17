import 'package:flutter/services.dart';

class ClubNameInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'[^a-zA-Z_\d]', unicode: true);
    final value = newValue.text.replaceAll(regExp, '');

    return TextEditingValue(text: value);
  }
}
