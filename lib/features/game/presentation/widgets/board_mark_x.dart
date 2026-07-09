import 'package:flutter/material.dart';

import 'package:tictactoe/core/theme/app_theme_context.dart';

/// Clay-style X mark painted for a board cell.
class BoardMarkX extends StatelessWidget {
  const BoardMarkX({super.key});

  static const double _markExtentFactor = 0.68;
  static const double _strokeWidthFactor = 0.14;
  static const double _outlineExtraFactor = 0.04;
  static const double _shadowOffsetFactor = 0.035;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double side = constraints.biggest.shortestSide * _markExtentFactor;
        if (!side.isFinite || side <= 0) {
          return const SizedBox.shrink();
        }

        return CustomPaint(
          size: Size.square(side),
          painter: _BoardMarkXPainter(
            color: colors.playerX,
            shadowColor: colors.playerXMarkShadow,
            highlightColor: colors.playerXMarkHighlight,
            strokeWidthFactor: _strokeWidthFactor,
            outlineExtraFactor: _outlineExtraFactor,
            shadowOffsetFactor: _shadowOffsetFactor,
          ),
        );
      },
    );
  }
}

final class _BoardMarkXPainter extends CustomPainter {
  const _BoardMarkXPainter({
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
    final Offset shadowOffset = Offset(
      size.width * shadowOffsetFactor,
      size.height * shadowOffsetFactor,
    );
    final double inset = size.width * 0.16;

    final Offset topLeft = Offset(inset, inset);
    final Offset topRight = Offset(size.width - inset, inset);
    final Offset bottomLeft = Offset(inset, size.height - inset);
    final Offset bottomRight = Offset(size.width - inset, size.height - inset);

    _drawCross(
      canvas: canvas,
      fromA: topLeft,
      toA: bottomRight,
      fromB: topRight,
      toB: bottomLeft,
      strokeWidth: strokeWidth + size.width * outlineExtraFactor,
      color: shadowColor,
      offset: shadowOffset,
    );

    _drawCross(
      canvas: canvas,
      fromA: topLeft,
      toA: bottomRight,
      fromB: topRight,
      toB: bottomLeft,
      strokeWidth: strokeWidth + size.width * outlineExtraFactor,
      color: shadowColor,
    );

    final Paint fillPaint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [highlightColor, color],
      ).createShader(Offset.zero & size);

    canvas.drawLine(topLeft, bottomRight, fillPaint);
    canvas.drawLine(topRight, bottomLeft, fillPaint);
  }

  void _drawCross({
    required Canvas canvas,
    required Offset fromA,
    required Offset toA,
    required Offset fromB,
    required Offset toB,
    required double strokeWidth,
    required Color color,
    Offset offset = Offset.zero,
  }) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(fromA + offset, toA + offset, paint);
    canvas.drawLine(fromB + offset, toB + offset, paint);
  }

  @override
  bool shouldRepaint(covariant _BoardMarkXPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.highlightColor != highlightColor;
  }
}
