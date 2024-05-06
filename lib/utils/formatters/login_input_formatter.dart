import 'package:flutter/services.dart';

class LoginInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'[^\d.a-zA-Z_-]', unicode: true);
    final value = newValue.text.replaceAll(regExp, '');

    return TextEditingValue(text: value);
  }
}
