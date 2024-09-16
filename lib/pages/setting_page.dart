import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nothing_pomodoro/models/preference/preference.dart';
import 'package:nothing_pomodoro/pages/custom_timer_page.dart';

import '../providers/pref_provider.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Preference pref = ref.watch(appStateProvider).pref;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Theme Mode",
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButton<ColorMode>(
                  value: pref.colorMode,
                  items: const [
                    DropdownMenuItem(
                      child: Text("Light"),
                      value: ColorMode.light,
                    ),
                    DropdownMenuItem(
                      child: Text("Dark"),
                      value: ColorMode.dark,
                    ),
                    DropdownMenuItem(
                      child: Text("System"),
                      value: ColorMode.systemDefault,
                    ),
                  ],
                  onChanged: (value) async {
                    if (value != pref.colorMode) {
                      pref = pref.copyWith(mode: value!);
                      await ref.read(appStateProvider).setPref(pref);
                    }
                    ;
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Custom Timer", style: TextStyle(fontSize: 20)),
                TextButton(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(2.0),
                        backgroundColor:
                            MediaQuery.platformBrightnessOf(context) ==
                                    Brightness.dark
                                ? Colors.white30
                                : Colors.grey.shade800),
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CustomTimerPage())),
                    child: Text(
                      "→",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
