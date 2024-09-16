import 'package:flutter/src/widgets/framework.dart';
import 'package:nothing_pomodoro/components/dialog.dart';

class PomodoroEditDialog extends PomodoroDialog<String> {
  PomodoroEditDialog({
    required super.title,
    super.initialValue,
    super.onConform,
    super.onCancel,
    super.children,
  }) : super();

  @override
  State<StatefulWidget> createState() => PomodoroEditDialogState();
}

class PomodoroEditDialogState extends PomodoroDialogState<String> {
  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return super.build(context);
  }
}
