import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serenita/foundation/helpers/functions/formatter.dart';

class Validations {
  BuildContext? context;

  Validations({this.context});

  /// Validate email address
  /// Checks that value is not empty.
  String? validateEmail(String value, {bool strict = true}) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);

    if (value.isEmpty) {
      return context!.tr('please_enter_an_email');
    } else if (!regex.hasMatch(value) && strict) {
      return context!.tr('please_enter_a_valid_email');
    }

    return null;
  }

  /// Validate password
  /// Check that length of password is over 6
  String? validatePassword(String value, {bool strict = true}) {
    if (value.isEmpty) {
      return context!.tr('please_enter_a_password');
    }

    if (strict) {
      if (value.length < 5) {
        return context!.tr('password_must_have_at_least_5_characters');
      }
      // else if (!RegExp(r'[0-9]+').hasMatch(value)) {
      //   return context!.tr('password_must_contain_at_least_one_number');
      // } else if (!RegExp(r'[*.!@$%^&(){}\[\]:;<>,?\/~_+\-=|]+').hasMatch(value)) {
      //   return context!.tr('password_must_contain_at_least_one_symbol');
      // } else if (!RegExp(r'[a-z]+').hasMatch(value)) {
      //   return context!.tr('password_must_contain_at_least_one_lowercase_letter');
      // } else if (!RegExp(r'[A-Z]+').hasMatch(value)) {
      //   return context!.tr('password_must_contain_at_least_one_uppercase_letter');
      // }
    }

    return null;
  }

  /// Validate confirm password
  /// Check that value is identical to password and check that length of value is over 6
  String? validateConfirmPassword({String? value, String? password}) {
    if (!validationEqual(value, password)) {
      return context!.tr('password_does_not_match');
    }
    if (validatePassword(value!, strict: false) != null) {
      return validatePassword(value);
    }

    return null;
  }

  /// Validate equality
  /// Checks if current value is equal to the value being checked
  bool validationEqual(String? currentValue, String? checkValue) {
    return currentValue == checkValue;
  }

  /// Validate input field
  /// Check that input is not empty
  String? validateInputText(String value, {int minLength = 0}) {
    if (value.isEmpty) {
      return context!.tr('required');
    } else if (value.length < minLength) {
      return parseStringWithValue(context!.tr('must_be_at_least_number_characters'), val: ['$minLength']);
    }

    return null;
  }

  String? validateFormatInputText(String value, String pattern) {
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return context!.tr('required');
    } else if (!regex.hasMatch(value)) {
      return context!.tr('invalid_format');
    }

    return null;
  }

  /// Validate date
  /// Check that value matches the date format.
  String? validateDate(String value) {
    String pattern = r'^\d{4}-\d{2}-\d{2}$';
    RegExp regex = RegExp(pattern);
    DateFormat date = DateFormat('yyyy-MM-dd');

    if (value.isEmpty) {
      return context!.tr('required');
    } else if (!regex.hasMatch(value)) {
      return context!.tr('provide_a_valid_date_format');
    }

    try {
      date.parseStrict(value);
    } catch (e) {
      return context!.tr('provide_a_valid_date');
    }

    return null;
  }

  String? validateNumberInput(String value) {
    String pattern = r'[0-9]+';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return context!.tr('required');
    } else if (!regex.hasMatch(value)) {
      return context!.tr('value_must_be_digits');
    }

    return null;
  }

  String? validateConfirmPhone(String value) {
    String pattern = r'^0\d{3}-\d{3}-\d{4}$';
    RegExp regex = RegExp(pattern);

    if (value.isEmpty) {
      return context!.tr('please_enter_a_mobile_number');
    } else if (!regex.hasMatch(value)) {
      return context!.tr('please_enter_a_valid_mobile_number');
    }

    return null;
  }

  String? validateNewEmail(String value, String newEmail) {
    if (value.isEmpty) {
      return context!.tr('required');
    } else if (value == newEmail) {
      return context!.tr('email_cannot_be_the_same_as_the_current_email');
    }

    return null;
  }

  String? validateOldEmail(String value, String oldEmail) {
    if (value.isEmpty) {
      return context!.tr('required');
    } else if (value != oldEmail) {
      return context!.tr('email_needs_be_the_same_as_the_current_email');
    }

    return null;
  }
}
