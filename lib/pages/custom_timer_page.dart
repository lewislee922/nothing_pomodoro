import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nothing_pomodoro/components/add_block_button.dart';
import 'package:nothing_pomodoro/components/custom_stepper.dart';
import 'package:nothing_pomodoro/components/edit_name_dialog.dart';
import 'package:nothing_pomodoro/models/pomodoro/pomodoro_timer.dart';

import '../providers/pref_provider.dart';

class CustomTimerPage extends ConsumerStatefulWidget {
  const CustomTimerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CustomTimerState();
}

class CustomTimerState extends ConsumerState<CustomTimerPage> {
  late List<PomodoroTimer> _timers;
  bool _edited = false;

  @override
  void initState() {
    super.initState();
    _timers = List.from(ref.read(appStateProvider).pref.customTimers);
  }

  Future<void> _save(List<PomodoroTimer> timers) async {
    final newPref = ref.read(appStateProvider).pref.copyWith(timers: _timers);
    await ref.read(appStateProvider).setPref(newPref);
    _edited = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Timer"), actions: [
        IconButton(
            onPressed: _edited
                ? () async {
                    await _save(_timers);
                    setState(() {
                      _timers = ref.read(appStateProvider).pref.customTimers;
                    });
                  }
                : null,
            icon: const Icon(Icons.save))
      ]),
      body: ListView.builder(
          itemCount: _timers.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    return EditNameDialog(initialValue: _timers[index].name, onConfirm: (value) {
                      _edited = true;
                      setState(() {
                        _timers[index] = _timers[index].copyWith(name: value);
                      });
                      Navigator.pop(context);
                    });
                  }),
              child: ExpansionTile(title: Text(_timers[index].name), children: [
                ..._timers[index].blocks.map((block) => Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _edited = true;
                      setState(() {
                        _timers[index].blocks.remove(block);
                      });
                    },
                    confirmDismiss: (direction) =>
                        _showDialog(type: 'Delete', context: context),
                    background: Container(
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        padding: const EdgeInsets.all(16),
                        child: const Icon(Icons.delete, color: Colors.white)),
                    child: ListTile(
                      onTap: () async {
                        // show a simpledialog to change focus type
                        await showDialog(
                          context: context,
                          builder: (_) => SimpleDialog(
                            title: const Text("Change Type"),
                            children: [
                              ...PomodoroMode.values.map(
                                (type) => SimpleDialogOption(
                                  child: Text(type.name),
                                  onPressed: () {
                                    _edited = true;
                                    if (type != block.mode) {
                                      final blockIndex =
                                          _timers[index].blocks.indexOf(block);
                                      final newBlock =
                                          block.copyWith(mode: type);
                                      setState(() => _timers[index]
                                          .blocks[blockIndex] = newBlock);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      title: Text(block.mode.name),
                      subtitle: Builder(builder: (context) {
                        final duration =
                            Duration(milliseconds: block.timeInMilliseconds);
                        return CustomStepper(
                          upperLimit: 60,
                          lowerLimit: 5,
                          initialValue: duration.inMinutes,
                          onChanged: (value) {
                            _edited = true;
                            final blockIndex =
                                _timers[index].blocks.indexOf(block);
                            final newBlock = block.copyWith(
                                timeInMilliseconds: value * 60 * 1000);
                            setState(() =>
                                _timers[index].blocks[blockIndex] = newBlock);
                          },
                        );
                      }),
                      trailing: const Icon(Icons.edit),
                    ))),
                AddBlockButton(
                  onTap: () {
                    _timers[index].blocks.add(
                        PomodoroTimeBlock(PomodoroMode.focus, 5 * 60 * 1000));
                    setState(() => _timers);
                  },
                )
              ]),
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _edited = true;
            setState(() => _timers.add(PomodoroTimer("newTimer", [])));
          }
              ,
          child: Icon(Icons.add)),
    );
  }

  Future<bool?> _showDialog(
      {required String type, required BuildContext context}) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(type),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop<bool>(false);
              },
              child: const Text("cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop<bool>(true);
              },
              child: const Text("confirm"))
        ],
      ),
    );
  }
}
