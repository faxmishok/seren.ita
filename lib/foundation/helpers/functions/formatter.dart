import 'package:flutter/services.dart';

String? parseStringWithValue(String? string, {List<String>? val}) {
  RegExp regex = RegExp(r'%s');
  String? input = string;
  if (val != null) {
    while (input!.contains(regex)) {
      input = input.replaceFirstMapped(regex, (match) => val[0]);

      if (val.isEmpty) {
        break;
      }

      val.removeAt(0);
    }
  }

  return input;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
