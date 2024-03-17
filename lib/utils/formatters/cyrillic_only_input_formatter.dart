import 'package:cubik_club/utils/extensions/string_casing_extension.dart';
import 'package:flutter/services.dart';

class CyrillicOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regExp = RegExp(r'[^ЁёА-я]', unicode: true);
    final value = newValue.text.replaceAll(regExp, '').toCapitalized();

    return TextEditingValue(text: value);
  }
}
