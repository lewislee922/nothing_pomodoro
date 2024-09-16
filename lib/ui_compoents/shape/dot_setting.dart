import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class DotSettingPainter extends CustomPainter {
  final Color dotColor ;
  final double dotRadius;

  DotSettingPainter({
    required this.dotColor,
    this.dotRadius = 5.0,});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // dot size & space
    final minSize = min(size.width, size.height);

    final dotRadius = 7 * minSize / 100;
    final dotSpace = 1 * minSize / 100;

    // Path number 1
    // paint dotted border with path
    paint.color = dotColor;

    path = Path();
    path.moveTo(size.width * 0.95, size.height * 0.39);
    // path.lineTo(size.width * 0.95, size.height * 0.39);
    path.cubicTo(size.width * 0.95, size.height * 0.39, size.width * 0.85,
        size.height * 0.39, size.width * 0.85, size.height * 0.39);
    path.cubicTo(size.width * 0.84, size.height * 0.39, size.width * 0.83,
        size.height * 0.38, size.width * 0.82, size.height * 0.37);
    path.cubicTo(size.width * 0.82, size.height * 0.35, size.width * 0.82,
        size.height * 0.34, size.width * 0.83, size.height / 3);
    path.cubicTo(size.width * 0.83, size.height / 3, size.width * 0.9,
        size.height * 0.26, size.width * 0.9, size.height * 0.26);
    path.cubicTo(size.width * 0.91, size.height / 4, size.width * 0.91,
        size.height * 0.24, size.width * 0.91, size.height * 0.23);
    path.cubicTo(size.width * 0.91, size.height / 5, size.width * 0.91,
        size.height / 5, size.width * 0.9, size.height * 0.19);
    path.cubicTo(size.width * 0.9, size.height * 0.19, size.width * 0.81,
        size.height * 0.1, size.width * 0.81, size.height * 0.1);
    path.cubicTo(size.width * 0.79, size.height * 0.08, size.width * 0.76,
        size.height * 0.08, size.width * 0.74, size.height * 0.1);
    path.cubicTo(size.width * 0.74, size.height * 0.1, size.width * 0.67,
        size.height * 0.17, size.width * 0.67, size.height * 0.17);
    path.cubicTo(size.width * 0.66, size.height * 0.18, size.width * 0.65,
        size.height * 0.18, size.width * 0.63, size.height * 0.18);
    path.cubicTo(size.width * 0.62, size.height * 0.17, size.width * 0.61,
        size.height * 0.16, size.width * 0.61, size.height * 0.15);
    path.cubicTo(size.width * 0.61, size.height * 0.15, size.width * 0.61,
        size.height * 0.05, size.width * 0.61, size.height * 0.05);
    path.cubicTo(size.width * 0.61, size.height * 0.02, size.width * 0.59, 0,
        size.width * 0.56, 0);
    path.cubicTo(
        size.width * 0.56, 0, size.width * 0.44, 0, size.width * 0.44, 0);
    path.cubicTo(size.width * 0.41, 0, size.width * 0.39, size.height * 0.02,
        size.width * 0.39, size.height * 0.05);
    path.cubicTo(size.width * 0.39, size.height * 0.05, size.width * 0.39,
        size.height * 0.15, size.width * 0.39, size.height * 0.15);
    path.cubicTo(size.width * 0.39, size.height * 0.16, size.width * 0.38,
        size.height * 0.17, size.width * 0.37, size.height * 0.18);
    path.cubicTo(size.width * 0.35, size.height * 0.18, size.width * 0.34,
        size.height * 0.18, size.width / 3, size.height * 0.17);
    path.cubicTo(size.width / 3, size.height * 0.17, size.width * 0.26,
        size.height * 0.1, size.width * 0.26, size.height * 0.1);
    path.cubicTo(size.width * 0.24, size.height * 0.08, size.width / 5,
        size.height * 0.08, size.width * 0.19, size.height * 0.1);
    path.cubicTo(size.width * 0.19, size.height * 0.1, size.width * 0.1,
        size.height * 0.19, size.width * 0.1, size.height * 0.19);
    path.cubicTo(size.width * 0.09, size.height / 5, size.width * 0.09,
        size.height / 5, size.width * 0.09, size.height * 0.23);
    path.cubicTo(size.width * 0.09, size.height * 0.24, size.width * 0.09,
        size.height / 4, size.width * 0.1, size.height * 0.26);
    path.cubicTo(size.width * 0.1, size.height * 0.26, size.width * 0.17,
        size.height / 3, size.width * 0.17, size.height / 3);
    path.cubicTo(size.width * 0.18, size.height * 0.34, size.width * 0.18,
        size.height * 0.35, size.width * 0.18, size.height * 0.37);
    path.cubicTo(size.width * 0.17, size.height * 0.38, size.width * 0.16,
        size.height * 0.39, size.width * 0.15, size.height * 0.39);
    path.cubicTo(size.width * 0.15, size.height * 0.39, size.width * 0.05,
        size.height * 0.39, size.width * 0.05, size.height * 0.39);
    path.cubicTo(size.width * 0.02, size.height * 0.39, 0, size.height * 0.41,
        0, size.height * 0.44);
    path.cubicTo(
        0, size.height * 0.44, 0, size.height * 0.56, 0, size.height * 0.56);
    path.cubicTo(0, size.height * 0.59, size.width * 0.02, size.height * 0.61,
        size.width * 0.05, size.height * 0.61);
    path.cubicTo(size.width * 0.05, size.height * 0.61, size.width * 0.15,
        size.height * 0.61, size.width * 0.15, size.height * 0.61);
    path.cubicTo(size.width * 0.16, size.height * 0.61, size.width * 0.17,
        size.height * 0.62, size.width * 0.18, size.height * 0.63);
    path.cubicTo(size.width * 0.18, size.height * 0.65, size.width * 0.18,
        size.height * 0.66, size.width * 0.17, size.height * 0.67);
    path.cubicTo(size.width * 0.17, size.height * 0.67, size.width * 0.1,
        size.height * 0.74, size.width * 0.1, size.height * 0.74);
    path.cubicTo(size.width * 0.09, size.height * 0.75, size.width * 0.09,
        size.height * 0.76, size.width * 0.09, size.height * 0.77);
    path.cubicTo(size.width * 0.09, size.height * 0.79, size.width * 0.09,
        size.height * 0.8, size.width * 0.1, size.height * 0.81);
    path.cubicTo(size.width * 0.1, size.height * 0.81, size.width * 0.19,
        size.height * 0.9, size.width * 0.19, size.height * 0.9);
    path.cubicTo(size.width / 5, size.height * 0.92, size.width * 0.24,
        size.height * 0.92, size.width * 0.26, size.height * 0.9);
    path.cubicTo(size.width * 0.26, size.height * 0.9, size.width / 3,
        size.height * 0.83, size.width / 3, size.height * 0.83);
    path.cubicTo(size.width * 0.34, size.height * 0.82, size.width * 0.35,
        size.height * 0.82, size.width * 0.37, size.height * 0.82);
    path.cubicTo(size.width * 0.38, size.height * 0.83, size.width * 0.39,
        size.height * 0.84, size.width * 0.39, size.height * 0.85);
    path.cubicTo(size.width * 0.39, size.height * 0.85, size.width * 0.39,
        size.height * 0.95, size.width * 0.39, size.height * 0.95);
    path.cubicTo(size.width * 0.39, size.height * 0.98, size.width * 0.41,
        size.height, size.width * 0.44, size.height);
    path.cubicTo(size.width * 0.44, size.height, size.width * 0.56, size.height,
        size.width * 0.56, size.height);
    path.cubicTo(size.width * 0.59, size.height, size.width * 0.61,
        size.height * 0.98, size.width * 0.61, size.height * 0.95);
    path.cubicTo(size.width * 0.61, size.height * 0.95, size.width * 0.61,
        size.height * 0.85, size.width * 0.61, size.height * 0.85);
    path.cubicTo(size.width * 0.61, size.height * 0.84, size.width * 0.62,
        size.height * 0.83, size.width * 0.63, size.height * 0.82);
    path.cubicTo(size.width * 0.65, size.height * 0.82, size.width * 0.66,
        size.height * 0.82, size.width * 0.67, size.height * 0.83);
    path.cubicTo(size.width * 0.67, size.height * 0.83, size.width * 0.74,
        size.height * 0.9, size.width * 0.74, size.height * 0.9);
    path.cubicTo(size.width * 0.76, size.height * 0.92, size.width * 0.79,
        size.height * 0.92, size.width * 0.81, size.height * 0.9);
    path.cubicTo(size.width * 0.81, size.height * 0.9, size.width * 0.9,
        size.height * 0.81, size.width * 0.9, size.height * 0.81);
    path.cubicTo(size.width * 0.91, size.height * 0.8, size.width * 0.91,
        size.height * 0.79, size.width * 0.91, size.height * 0.77);
    path.cubicTo(size.width * 0.91, size.height * 0.76, size.width * 0.91,
        size.height * 0.75, size.width * 0.9, size.height * 0.74);
    path.cubicTo(size.width * 0.9, size.height * 0.74, size.width * 0.83,
        size.height * 0.67, size.width * 0.83, size.height * 0.67);
    path.cubicTo(size.width * 0.82, size.height * 0.66, size.width * 0.82,
        size.height * 0.65, size.width * 0.82, size.height * 0.63);
    path.cubicTo(size.width * 0.83, size.height * 0.62, size.width * 0.84,
        size.height * 0.61, size.width * 0.85, size.height * 0.61);
    path.cubicTo(size.width * 0.85, size.height * 0.61, size.width * 0.95,
        size.height * 0.61, size.width * 0.95, size.height * 0.61);
    path.cubicTo(size.width * 0.98, size.height * 0.61, size.width,
        size.height * 0.59, size.width, size.height * 0.56);
    path.cubicTo(size.width, size.height * 0.56, size.width, size.height * 0.44,
        size.width, size.height * 0.44);
    path.cubicTo(size.width, size.height * 0.41, size.width * 0.98,
        size.height * 0.39, size.width * 0.95, size.height * 0.39);
    path.cubicTo(size.width * 0.95, size.height * 0.39, size.width * 0.95,
        size.height * 0.39, size.width * 0.95, size.height * 0.39);

    PathMetrics pathMetrics;

    pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      final length = pathMetric.length;

      for (double distance = 0;
          distance < length;
          distance += dotRadius + dotSpace) {
        final pathSegment =
            pathMetric.extractPath(distance, distance + dotRadius);
        canvas.drawCircle(pathSegment.getBounds().center, dotRadius / 2, paint);
      }
    }

    // Path number 2

    Path secondPath = Path();
    secondPath.moveTo(size.width / 2, size.height / 3);
    secondPath.cubicTo(size.width * 0.41, size.height / 3, size.width / 3,
        size.height * 0.41, size.width / 3, size.height / 2);
    secondPath.cubicTo(size.width / 3, size.height * 0.59, size.width * 0.41,
        size.height * 0.67, size.width / 2, size.height * 0.67);
    secondPath.cubicTo(size.width * 0.59, size.height * 0.67, size.width * 0.67,
        size.height * 0.59, size.width * 0.67, size.height / 2);
    secondPath.cubicTo(size.width * 0.67, size.height * 0.41, size.width * 0.59,
        size.height / 3, size.width / 2, size.height / 3);
    secondPath.cubicTo(size.width / 2, size.height / 3, size.width / 2,
        size.height / 3, size.width / 2, size.height / 3);

    pathMetrics = secondPath.computeMetrics();
    for (final pathMetric in pathMetrics) {
      final length = pathMetric.length;

      for (double distance = 0;
          distance < length;
          distance += dotRadius + dotSpace) {
        final pathSegment =
            pathMetric.extractPath(distance, distance + dotRadius);
        canvas.drawCircle(pathSegment.getBounds().center, dotRadius / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
