import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

void selectionClickWithSoundFeedback() {
  if (Platform.isIOS) {
    HapticFeedback.selectionClick();
    SystemSound.play(SystemSoundType.click);
  }
}

void selectionClickFeedback() {
  if (Platform.isIOS) {
    HapticFeedback.selectionClick();
  }
}

void lightImpactFeedback() {
  if (Platform.isIOS) {
    HapticFeedback.lightImpact();
  }
}

void mediumImpactFeedback() {
  if (Platform.isIOS) {
    HapticFeedback.mediumImpact();
  }
}

void heavyImpactFeedback() {
  if (Platform.isIOS) {
    HapticFeedback.heavyImpact();
  }
}

void successImpact() {
  HapticFeedback.lightImpact();
  AudioPlayer().play(AssetSource('sounds/success.mp3'));
}
