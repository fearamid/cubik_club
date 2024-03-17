import 'package:flutter/services.dart';

class RuPhoneInputFormatter extends TextInputFormatter {
  String _formattedPhone = '';

  // bool _isRu = false;

  // get isRussian => _isRu;

  RuPhoneInputFormatter({
    String? initialText,
  }) {
    if (initialText != null) {
      formatEditUpdate(
        TextEditingValue.empty,
        TextEditingValue(text: initialText),
      );
    }
  }

  // --- Getters of current phone state and parameters
  // Can be deleted

  String getMaskPhone() {
    return _formattedPhone;
  }

  String getClearPhone() {
    if (_formattedPhone.isEmpty) {
      return '';
    }
    // if (!_isRu) {
    //   return _formattedPhone.replaceAll(RegExp(r'\D'), '');
    // }

    return _formattedPhone.replaceAll(RegExp(r'\D'), '').substring(
        1,
        (_formattedPhone.replaceAll(RegExp(r'\D'), '').length >= 11)
            ? 11
            : _formattedPhone.replaceAll(RegExp(r'\D'), '').length);
  }

  bool isDone() {
    // if (!_isRu) {
    //   return true;
    // }
    return (_formattedPhone.replaceAll(RegExp(r'\D'), '').length > 10);
  }

// Main formatting functions

  String _formattingPhone(String text) {
    text = text.replaceAll(RegExp(r'\D'), '');

    if (text.isNotEmpty) {
      String phone = '';

      if (text[0] != '8' && text[0] != '7') {
        text = '7$text';
      }

      // add `+` if it need
      String firstSymbols = (text[0] == '8') ? '8' : '+7';
      phone = '$firstSymbols ';

      // +7 (xxx
      if (text.length > 1) {
        phone += '(${text.substring(1, (text.length < 4) ? text.length : 4)}';
      }

      // +7 (000) xxx
      if (text.length >= 5) {
        phone += ') ${text.substring(4, (text.length < 7) ? text.length : 7)}';
      }
      // + 7 (000) 000 xx
      if (text.length >= 8) {
        phone += ' ${text.substring(7, (text.length < 9) ? text.length : 9)}';
      }
      // + 7 (000) 000 00 xx
      if (text.length >= 10) {
        phone += ' ${text.substring(9, (text.length < 11) ? text.length : 11)}';
      }

      return phone;
    }
    return '';
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');
    int selectionStart = oldValue.selection.end;

    // checking if the user erases all characters
    if (oldValue.text == '${newValue.text} ') {
      _formattedPhone = '';
      return TextEditingValue(
        text: _formattedPhone,
        selection: TextSelection(
          baseOffset: _formattedPhone.length,
          extentOffset: _formattedPhone.length,
          affinity: newValue.selection.affinity,
          isDirectional: newValue.selection.isDirectional,
        ),
      );
    }

    // checking if the user is editing the phone somewhere in the middle
    if (selectionStart != _formattedPhone.length) {
      _formattedPhone = _formattingPhone(digitsOnly);

      // if yes, then we do not transfer the cursor to the end

      return TextEditingValue(
        text: _formattedPhone,
        selection: TextSelection(
          baseOffset: newValue.selection.baseOffset,
          extentOffset: newValue.selection.extentOffset,
          affinity: newValue.selection.affinity,
          isDirectional: newValue.selection.isDirectional,
        ),
      );
    }

    _formattedPhone = _formattingPhone(digitsOnly);

    // if the user just enters the phone number,
    // then move the cursor to the end of the formatted line

    return TextEditingValue(
      text: _formattedPhone,
      selection: TextSelection(
        baseOffset: _formattedPhone.length,
        extentOffset: _formattedPhone.length,
        affinity: newValue.selection.affinity,
        isDirectional: newValue.selection.isDirectional,
      ),
    );
  }
}
