import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  const RoundedIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 24.0,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(width: iconSize, height: iconSize),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(iconSize*0.2)),
      fillColor: Theme.of(context).colorScheme.background,
      child: Icon(icon, size: iconSize * 0.8),
    );
  }
}