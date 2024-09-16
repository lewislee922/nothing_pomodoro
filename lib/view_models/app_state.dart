import 'package:flutter/material.dart';
import 'package:nothing_pomodoro/local_data_sources/pref_data_source.dart';
import 'package:nothing_pomodoro/models/preference/preference.dart';

class AppState extends ChangeNotifier {
  Preference _pref;
  final PrefDataSource _dataSource;

  Preference get pref => _pref;

  AppState(PrefDataSource dataSource)
      : _pref = dataSource.getPref(),
        _dataSource = dataSource;

  Future<void> setPref(Preference pref) async{
    _pref = pref;
    await _dataSource.savePref(pref);

    notifyListeners();
  }
}
