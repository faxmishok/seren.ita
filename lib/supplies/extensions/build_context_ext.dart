import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension CustomBuildContextExtension on BuildContext {
  double get bottomPadding {
    return mediaQuery.padding.bottom;
  }

  ThemeData get theme {
    return Theme.of(this);
  }

  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  TextTheme get primaryTextTheme {
    return Theme.of(this).primaryTextTheme;
  }

  MediaQueryData get mediaQuery {
    return MediaQuery.of(this);
  }

  double get height {
    return mediaQuery.size.height;
  }

  double get width {
    return mediaQuery.size.width;
  }

  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }

  Future<T?> push<T>(Widget screen) {
    return Navigator.of(this).push<T?>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screen;
        },
      ),
    );
  }

  Future<T?> openAsGeneralDialog<T>(Widget screen) {
    return showGeneralDialog<T?>(
      context: this,
      pageBuilder: (_, __, ___) => screen,
    );
  }

  Future<T?> pushUp<T>(Widget screen) {
    return showCupertinoModalPopup(
      context: this,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: screen,
        );
      },
    );
  }

  Future<T?> pushReplacement<T>(Widget screen) {
    pop();
    return Navigator.of(this).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screen;
        },
      ),
    );
  }

  Future<T?> pushAndRemoveUntil<T>(Widget screen) {
    pop();
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screen;
        },
      ),
      (_) => false,
    );
  }

  void pop<T>([T? value]) {
    Navigator.of(this).pop<T>(value);
  }
}
