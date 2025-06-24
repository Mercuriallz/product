import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final numericValue = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (numericValue.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final value = int.parse(numericValue);
    final newText = NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}