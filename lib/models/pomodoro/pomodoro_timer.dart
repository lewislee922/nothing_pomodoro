import 'dart:convert';

enum PomodoroMode {
  focus(0, "startFocus"),
  shortBreak(1, "startBreak"),
  longBreak(2, "startBreak");

  const PomodoroMode(this.rawValue, this.invokeMethod);

  final int rawValue;
  final String invokeMethod;

  @override
  String toString() {
    switch (this) {
      case PomodoroMode.focus:
        return "Focus";
      case PomodoroMode.shortBreak:
        return "Short Break";
      case PomodoroMode.longBreak:
        return "Long Break";
    }
  }

  static PomodoroMode fromRawValue(int value) {
    switch (value) {
      case 0:
        return PomodoroMode.focus;
      case 1:
        return PomodoroMode.shortBreak;
      default:
        return PomodoroMode.longBreak;
    }
  }
}

class PomodoroTimeBlock {
  final PomodoroMode mode;
  final int timeInMilliseconds;
  final int blockIntervalInMilliseconds;

  PomodoroTimeBlock(this.mode, this.timeInMilliseconds,
      {this.blockIntervalInMilliseconds = 5000});

  Map<String, dynamic> toMap() => {
        "mode": mode.rawValue,
        "time": timeInMilliseconds,
        "interval": blockIntervalInMilliseconds
      };

  PomodoroTimeBlock.fromJson(Map<String, dynamic> json)
      : mode = PomodoroMode.fromRawValue(json['mode']),
        timeInMilliseconds = json['time'],
        blockIntervalInMilliseconds = json['interval'];

  PomodoroTimeBlock copyWith(
      {PomodoroMode? mode,
      int? timeInMilliseconds,
      int? blockIntervalInMilliseconds}) {
    return PomodoroTimeBlock(
        mode ?? this.mode, timeInMilliseconds ?? this.timeInMilliseconds,
        blockIntervalInMilliseconds:
            blockIntervalInMilliseconds ?? this.blockIntervalInMilliseconds);
  }
}

class PomodoroTimer {
  final String name;
  final List<PomodoroTimeBlock> blocks;

  PomodoroTimer(this.name, this.blocks);

  static PomodoroTimer classic() => PomodoroTimer("classic", [
        PomodoroTimeBlock(PomodoroMode.focus, 25 * 60 * 1000),
        PomodoroTimeBlock(PomodoroMode.shortBreak, 5 * 60 * 1000),
        PomodoroTimeBlock(PomodoroMode.focus, 25 * 60 * 1000),
        PomodoroTimeBlock(PomodoroMode.shortBreak, 5 * 60 * 1000),
        PomodoroTimeBlock(PomodoroMode.focus, 25 * 60 * 1000),
        PomodoroTimeBlock(PomodoroMode.shortBreak, 5 * 60 * 1000),
        PomodoroTimeBlock(PomodoroMode.focus, 25 * 60 * 1000),
        PomodoroTimeBlock(PomodoroMode.longBreak, 15 * 60 * 1000),
      ]);

  static PomodoroTimer custom(
      int focus, int shortBreak, int longBreak, int cycles, String name) {
    final blocks = <PomodoroTimeBlock>[];
    for (var i = 0; i < cycles; i++) {
      blocks.add(PomodoroTimeBlock(PomodoroMode.focus, focus * 60 * 1000));
      blocks.add(
          PomodoroTimeBlock(PomodoroMode.shortBreak, shortBreak * 60 * 1000));
    }
    blocks
        .add(PomodoroTimeBlock(PomodoroMode.longBreak, longBreak * 60 * 1000));
    return PomodoroTimer(name, blocks);
  }

  String toJson() {
    final Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = name;
    map['timerBlocks'] = blocks.map((e) => jsonEncode(e.toMap())).toList();
    return jsonEncode(map);
  }

  PomodoroTimer.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        blocks = List<String>.from(json['timerBlocks'])
            .map((e) => PomodoroTimeBlock.fromJson(jsonDecode(e)))
            .toList();

  PomodoroTimer copyWith({String? name, List<PomodoroTimeBlock>? blocks}) =>
      PomodoroTimer(name ?? this.name, blocks ?? this.blocks);
}
