import 'package:flutter/material.dart';

abstract class PomodoroDialog<T> extends StatefulWidget {
  final String title;
  final List<Widget>? children;
  final Function(T?)? onConform;
  final VoidCallback? onCancel;
  final T? initialValue;

  PomodoroDialog(
      {required this.title,
      this.onConform,
      this.onCancel,
      this.initialValue,
      this.children});

  // @override
  // State<PomodoroDialog<T>> createState() => PomodoroDialogState();
}

abstract class PomodoroDialogState<T> extends State<PomodoroDialog<T>> {
  late T? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(widget.title),
      children: [
        ...widget.children ?? [],
        Row(
          children: [
            TextButton(
                onPressed: () {
                  widget.onCancel?.call();
                  Navigator.of(context).pop();
                },
                child: const Text("cancel")),
            TextButton(
                onPressed: () {
                  widget.onConform?.call(value);
                  Navigator.of(context).pop();
                },
                child: const Text("confirm"))
          ],
        )
      ],
    );
  }
}
