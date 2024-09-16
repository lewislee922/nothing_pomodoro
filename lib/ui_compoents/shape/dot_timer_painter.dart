import 'dart:math';

import 'package:flutter/material.dart';

/// a custompainter that paints dotted circle at specified angle
class DotTimerPainter extends CustomPainter {
  DotTimerPainter({
    required this.showRedDot,
    required this.angle,
    required this.dotRadius,
    required this.dotColor,
  });

  final bool showRedDot;
  final Color dotColor;
  final double dotRadius;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    final minRectSize = min(size.width, size.height);
    final center = Offset(size.width / 2, size.height / 2);

    

    // calculate how many dots in a circle
    final dotCount = 60;
    final dotRadians = (pi * 2 / dotCount);

    final maxCount = (angle / 360 * dotCount).round();
    // draw dotted circle
    for (var i = 0; i < maxCount ; i++) {
        final dotCenterX = center.dx + cos(i * dotRadians - 90/360 * 2 * pi) * minRectSize / 2;
        final dotCenterY = center.dy + sin(i * dotRadians - 90/360 * 2 * pi) * minRectSize / 2;
        Paint paint = Paint()..style = PaintingStyle.fill;
        if (showRedDot && i + 1 == maxCount) {
          paint.color = Colors.red;
        }else {
          paint.color = dotColor;
        }
        
        canvas.drawCircle(
          Offset(dotCenterX, dotCenterY),
          dotRadius,
          paint,
        );
    }
  }

  @override
  bool shouldRepaint(DotTimerPainter oldDelegate) {
    return angle != oldDelegate.angle || dotColor != oldDelegate.dotColor || showRedDot != oldDelegate.showRedDot;
  }
}
