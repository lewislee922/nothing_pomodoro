import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nothing_pomodoro/models/pomodoro/pomodoro_timer.dart';

import '../providers/pref_provider.dart';
import '../providers/status_provider.dart';
import '../ui_compoents/shape/dot_setting.dart';
import '../ui_compoents/shape/dot_timer_painter.dart';
import '../viewmodels/block_status.dart';
import 'setting_page.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  bool _showCircle = false;
  bool _showRedDot = false;
  int _selectedIndex = 0;
  static const String _channel = 'nothingpomodoro.glyph.notification';
  // ValueNotifier<TimerStatus> _currentStatus =
  //     ValueNotifier<TimerStatus>(TimerStatus.stop);
  // ValueNotifier<int> _remainTime = ValueNotifier(0);
  // Timer? _timer;
  // late GlyphChannel _channel;
  late AppLifecycleListener _lifecycleListener;
  late final MethodChannel _methodChannel;

  @override
  void initState() {
    super.initState();
    _methodChannel = const MethodChannel(_channel);
    _lifecycleListener = AppLifecycleListener(
        onDetach: () async =>
            await _methodChannel.invokeMethod("forceEndTimer"));
    WidgetsBinding.instance.addObserver(_lifecycleListener);
    const MethodChannel("glyph.status").setMethodCallHandler((call) async {
      if (call.method == "remainMillsecounds") {
        print(call.arguments);
      }
      if (call.method == "timerFinish") {
        print("the timer is finished");
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleListener);
    _lifecycleListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formatter = DateFormat('HH:mm:ss');
    final status = ref.watch(statusProvider);
    final pref = ref.watch(appStateProvider).pref;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Nothing Pomodoro",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const SettingPage())),
            child: CustomPaint(
              size: const Size(24, 24),
              painter: DotSettingPainter(
                  dotColor: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            DropdownMenu<int>(
              menuStyle:
                  MenuStyle(padding: MaterialStatePropertyAll(EdgeInsets.zero)),
              inputDecorationTheme: InputDecorationTheme(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(2.0)),
              initialSelection: _selectedIndex,
              enabled: status.timerStatus != TimerStatus.start,
              onSelected: (value) {
                _selectedIndex = value ?? 0;
                ref.read(statusProvider).changeTimer(timer: pref.customTimers[_selectedIndex]);
              },
              enableSearch: false,
              dropdownMenuEntries: [
                for (var i = 0; i < pref.customTimers.length; i++)
                  DropdownMenuEntry(value: i, label: pref.customTimers[i].name),
              ],
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 200,
              child: ListView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  ...status.pomodoroTimer.blocks
                      .map(
                        (e) => SizedBox(
                          width: size.width / 2,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "${e.mode.toString()} \n${(e.timeInMilliseconds / (1000 * 60)).toInt()}:00",
                                  style: const TextStyle(
                                      fontFamily: "Ndot55", fontSize: 30)),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  // SizedBox(
                  //   width: size.width / 2,
                  //   child: Card(
                  //     surfaceTintColor: Colors.transparent,
                  //     color: Colors.transparent,
                  //     elevation: 0.0,
                  //     shadowColor: Colors.transparent,
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AnimatedContainer(
                onEnd: () => setState(() => _showCircle = !_showCircle),
                alignment: Alignment.center,
                curve: Curves.easeInOut,
                height: status.timerStatus != TimerStatus.stop
                    ? size.height / 3
                    : 0,
                duration: const Duration(milliseconds: 500),
                child: (status.timerStatus == TimerStatus.start && _showCircle)
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(200, 200),
                            painter: DotTimerPainter(
                                showRedDot: _showRedDot,
                                angle: status.remainTime *
                                    1000 /
                                    status.currentBlock.timeInMilliseconds *
                                    360,
                                dotRadius: 4.0,
                                dotColor:
                                    Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            formatter.format(
                                DateTime(0, 0, 0, 0, 0, status.remainTime)),
                            style: TextStyle(fontSize: 24),
                          )
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
            TextButton(
                onPressed: status.pomodoroTimer.blocks.isNotEmpty ? () async {
                  if (status.timerStatus == TimerStatus.stop) {
                    await status.start(
                      onStart: (block) {
                        _methodChannel.invokeMethod(PomodoroMode.shortBreak.invokeMethod, {"time": block.timeInMilliseconds});
                        // _methodChannel.invokeMethod(block.mode.invokeMethod, {"time": block.timeInMilliseconds});
                      },
                      onTick: () => _showRedDot = !_showRedDot,
                      // onEnd: () async {
                      //   await MethodChannel("glyph")
                      //       .invokeMethod("forceEndTimer");
                      // },
                    );
                  }
                } : null,
                child: Text(
                    status.timerStatus == TimerStatus.stop ? "start" : "pause",
                    style:
                        const TextStyle(fontFamily: "Ndot55", fontSize: 30))),
            TextButton(
                onPressed: status.pomodoroTimer.blocks.isNotEmpty ? () async {
                  _methodChannel.invokeMethod("forceEndTimer");
                  status.stop();

                }: null,
                child: const Text("stop glyph",
                    style: TextStyle(fontFamily: "Ndot55", fontSize: 30))),
          ],
        ),
      ),
    );
  }
}
