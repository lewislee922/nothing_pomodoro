import 'package:flutter/cupertino.dart';
import 'package:nothing_pomodoro/models/pomodoro/pomodoro_timer.dart';

enum ColorMode {
  dark(0),
  light(1),
  systemDefault(2);

  const ColorMode(this.rawValue);

  final int rawValue;

  static ColorMode fromRawValue(int value) {
    switch(value) {
      case 0:
        return ColorMode.dark;
      case 1:
        return ColorMode.light;
      default:
        return ColorMode.systemDefault;
    }
  }

  Brightness? toBrightness() {
    switch(this) {
      case ColorMode.dark:
        return Brightness.dark;
      case ColorMode.light:
        return Brightness.light;
      default:
        return null;
    }
  }
}

class Preference {
  final ColorMode colorMode;
  final List<PomodoroTimer> customTimers;

  Preference(this.colorMode, this.customTimers);

  copyWith({ColorMode? mode, List<PomodoroTimer>? timers}) =>
      Preference(mode ?? colorMode, timers ?? customTimers);
}
