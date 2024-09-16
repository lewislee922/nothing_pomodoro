import 'package:flutter/material.dart';

class AddBlockButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AddBlockButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onTap,
        child: SizedBox(
            width: double.infinity,
            child: Center(
                child: Text(
              "+",
              style: TextStyle(fontSize: 24),
            ))),
      ),
    );
  }
}
