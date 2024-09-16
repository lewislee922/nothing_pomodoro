import 'package:flutter/material.dart';
import 'package:nothing_pomodoro/components/rounded_icon_button.dart';

class CustomStepper extends StatefulWidget {
  final int upperLimit;
  final int lowerLimit;
  final int step;
  final double iconSize;
  final int initialValue;
  final void Function(int newValue)? onChanged;

  const CustomStepper({
    Key? key,
    required this.upperLimit,
    required this.lowerLimit,
    this.step = 1,
    this.iconSize = 24.0,
    required this.initialValue,
    this.onChanged,
  })  : assert(initialValue >= lowerLimit && initialValue <= upperLimit,
            'initialValue must be between $lowerLimit and $upperLimit'),
        super(key: key);

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundedIconButton(
            icon: Icons.remove,
            iconSize: widget.iconSize,
            onPressed: () {
              if (_value - widget.step > widget.lowerLimit) {
                setState(() => _value -= widget.step);
                widget.onChanged?.call(_value);
              }
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            _value.toString(),
            style: TextStyle(fontSize: widget.iconSize * 0.8),
            textAlign: TextAlign.center,
          ),
        ),
        RoundedIconButton(
            icon: Icons.add,
            iconSize: widget.iconSize,
            onPressed: () {
              if (_value + widget.step < widget.upperLimit) {
                setState(() => _value += widget.step);
                widget.onChanged?.call(_value);
              }
            }),
      ],
    );
  }
}
