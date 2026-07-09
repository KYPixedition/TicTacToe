import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';

/// Clay-style O mark painted for a board cell.
class BoardMarkO extends StatelessWidget {
  const BoardMarkO({super.key});

  static const double _markExtentFactor = 0.68;
  static const double _strokeWidthFactor = 0.14;
  static const double _outlineExtraFactor = 0.04;
  static const double _shadowOffsetFactor = 0.035;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double side =
            constraints.biggest.shortestSide * _markExtentFactor;
        if (!side.isFinite || side <= 0) {
          return const SizedBox.shrink();
        }

        return CustomPaint(
          size: Size.square(side),
          painter: _BoardMarkOPainter(
            color: colors.playerO,
            shadowColor: colors.playerOMarkShadow,
            highlightColor: colors.playerOMarkHighlight,
            strokeWidthFactor: _strokeWidthFactor,
            outlineExtraFactor: _outlineExtraFactor,
            shadowOffsetFactor: _shadowOffsetFactor,
          ),
        );
      },
    );
  }
}

final class _BoardMarkOPainter extends CustomPainter {
  const _BoardMarkOPainter({
    required this.color,
    required this.shadowColor,
    required this.highlightColor,
    required this.strokeWidthFactor,
    required this.outlineExtraFactor,
    required this.shadowOffsetFactor,
  });

  final Color color;
  final Color shadowColor;
  final Color highlightColor;
  final double strokeWidthFactor;
  final double outlineExtraFactor;
  final double shadowOffsetFactor;

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = size.width * strokeWidthFactor;
    final Offset center = size.center(Offset.zero);
    final double radius = (size.width - strokeWidth) / 2 - size.width * 0.04;
    final Offset shadowOffset = Offset(
      size.width * shadowOffsetFactor,
      size.height * shadowOffsetFactor,
    );

    _drawRing(
      canvas: canvas,
      center: center + shadowOffset,
      radius: radius,
      strokeWidth: strokeWidth + size.width * outlineExtraFactor,
      color: shadowColor,
    );

    _drawRing(
      canvas: canvas,
      center: center,
      radius: radius,
      strokeWidth: strokeWidth + size.width * outlineExtraFactor,
      color: shadowColor,
    );

    final Paint fillPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [highlightColor, color],
      ).createShader(Offset.zero & size);

    canvas.drawCircle(center, radius, fillPaint);
  }

  void _drawRing({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double strokeWidth,
    required Color color,
  }) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _BoardMarkOPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.highlightColor != highlightColor;
  }
}
