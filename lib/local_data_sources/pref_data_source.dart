import 'dart:convert';

import 'package:nothing_pomodoro/models/pomodoro/pomodoro_timer.dart';
import 'package:nothing_pomodoro/models/preference/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefDataSource {
  final _mainPath = 'settings';
  final SharedPreferences _prefs;

  PrefDataSource(SharedPreferences pref) : _prefs = pref;

  Preference getPref() {
    const colorPath = 'colorMode';
    const timerPath = 'customTimer';

    final mode =
        ColorMode.fromRawValue(_prefs.getInt("$_mainPath/$colorPath") ?? 2);
    final data = _prefs.getStringList("$_mainPath/$timerPath");
    
    List<PomodoroTimer> timer = [PomodoroTimer.classic()];
    if (data != null) {
      timer = <PomodoroTimer>[];
      for (final item in data) {
        final json = jsonDecode(item);
        timer.add(PomodoroTimer.fromJson(json));
      }
    }
    return Preference(mode, timer);
  }

  Future<void> savePref(Preference pref) async {
    const colorPath = 'colorMode';
    const timerPath = 'customTimer';

    final mode = pref.colorMode.rawValue;
    final timers = pref.customTimers.map((e) => e.toJson()).toList();

    await _prefs.setInt("$_mainPath/$colorPath", mode);
    await _prefs.setStringList("$_mainPath/$timerPath", timers);
  }

}
