import 'package:flutter/material.dart';

class EditNameDialog extends StatefulWidget {
  final Function(String)? onConfirm;
  final String? initialValue;

  const EditNameDialog({super.key, this.onConfirm, this.initialValue});

  @override
  State<EditNameDialog> createState() => _EditNameDialogState();
}

class _EditNameDialogState extends State<EditNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Edit Name"),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            SimpleDialogOption(
              child: Text("Confirm"),
              onPressed: () {
                widget.onConfirm?.call(_controller.text);
              },
            )
          ],
        )
      ],
    );
  }
}
