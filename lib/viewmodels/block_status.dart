import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nothing_pomodoro/models/pomodoro/pomodoro_timer.dart';

enum TimerStatus { start, stop, pause }

class PomodoroStatus extends ChangeNotifier {
  int _currentIndex = 0;
  int _remainTime = 0;
  TimerStatus timerStatus = TimerStatus.stop;
  PomodoroTimer pomodoroTimer;
  Timer? _timer;

  int get remainTime => _remainTime;
  PomodoroTimeBlock get currentBlock => pomodoroTimer.blocks[_currentIndex];

  start(
      {Function(PomodoroTimeBlock)? onStart,
      VoidCallback? onBlockEnd,
      VoidCallback? onTick,
      VoidCallback? onEnd}) async {
    timerStatus = TimerStatus.start;
    notifyListeners();
    while (_currentIndex < pomodoroTimer.blocks.length) {
      await _startBlock(
          block: pomodoroTimer.blocks[_currentIndex],
          onStart: onStart,
          onEnd: onBlockEnd,
          onTick: onTick);
      _currentIndex++;
    }
    _reset();
    onEnd?.call();
    notifyListeners();
  }

  PomodoroStatus(this.pomodoroTimer);

  changeTimer({required PomodoroTimer timer}) {
    pomodoroTimer = timer;
    _currentIndex = 0;
    _remainTime = 0;
    _reset();
    notifyListeners();
  }

  _reset() {
    int _currentIndex = 0;
    int _remainTime = 0;
    timerStatus = TimerStatus.stop;
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    notifyListeners();
  }

  stop() => _reset();

  pause({VoidCallback? onPause}) {
    if (_timer?.isActive ?? false) {
      timerStatus = TimerStatus.pause;
      _timer?.cancel();
      _timer = null;
      onPause?.call();
      notifyListeners();
    }
  }

  _startBlock(
      {required PomodoroTimeBlock block,
      VoidCallback? onEnd,
      Function(PomodoroTimeBlock block)? onStart,
      VoidCallback? onTick}) async {
    final Completer completer = Completer();
    onStart?.call(block);
    
    _remainTime = block.timeInMilliseconds ~/ 1000;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remainValue = block.timeInMilliseconds ~/ 1000 - timer.tick;
      
      _remainTime = remainValue;
      onTick?.call();
      notifyListeners();
      if (_remainTime == 0) {
        onEnd?.call();
        completer.complete();
        timer.cancel();
      }
    });
    await completer.future;
  }
}
