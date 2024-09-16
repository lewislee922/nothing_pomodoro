import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_data_sources/pref_data_source.dart';
import 'models/pomodoro/pomodoro_timer.dart';
import 'pages/main_page.dart';
import 'providers/pref_provider.dart';
import 'providers/status_provider.dart';
import 'view_models/app_state.dart';
import 'viewmodels/block_status.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [
        appStateProvider
            .overrideWith((ref) => AppState(PrefDataSource(sharedPreferences))),
      ],
      child: const NothingPomodoroApp(),
    ),
  );
}

class NothingPomodoroApp extends ConsumerWidget {
  const NothingPomodoroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness =
        ref.watch(appStateProvider).pref.colorMode.toBrightness();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: brightness ?? MediaQuery.of(context).platformBrightness,
        colorScheme: (brightness ??
                    MediaQuery.of(context).platformBrightness) ==
                Brightness.light
            ? ColorScheme.light(primary: Colors.black, secondary: Colors.grey)
            : ColorScheme.dark(primary: Colors.white, secondary: Colors.grey),
        fontFamily: "Ndot55",
        useMaterial3: true,
      ),
      home: ProviderScope(overrides: [
        statusProvider.overrideWith((ref) {
          final timers = ref.read(appStateProvider).pref.customTimers;
          return timers.isEmpty
              ? PomodoroStatus(PomodoroTimer.classic())
              : PomodoroStatus(timers.first);
        })
      ], child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}
