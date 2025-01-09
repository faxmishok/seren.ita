import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:serenita/supplies/constants/theme_globals.dart';

class NotificationService {
  void notify(content) {
    showSimpleNotification(
      AutoSizeText(
        content,
        textAlign: TextAlign.center,
      ),
      background: primaryColor,
      foreground: whiteColor,
      duration: const Duration(milliseconds: 1500),
    );
  }

  void notifySuccess(content) {
    showSimpleNotification(
      AutoSizeText(
        content,
        textAlign: TextAlign.center,
      ),
      background: greenColor,
      foreground: whiteColor,
      duration: const Duration(milliseconds: 1500),
    );
  }

  void notifyError(content) {
    showSimpleNotification(
      AutoSizeText(
        content,
        textAlign: TextAlign.center,
      ),
      background: redColor,
      foreground: whiteColor,
      duration: const Duration(milliseconds: 1500),
    );
  }
}
