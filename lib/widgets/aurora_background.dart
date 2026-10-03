import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AuroraBackground extends StatelessWidget {
  const AuroraBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.voidColor,
                AppColors.deepViolet,
                AppColors.midnightBlue,
              ],
            ),
          ),
          child: SizedBox.expand(),
        ),
        const _GlowOrb(
          alignment: Alignment(-1.15, -0.85),
          size: 320,
          color: AppColors.magenta,
        ),
        const _GlowOrb(
          alignment: Alignment(1.2, -0.4),
          size: 280,
          color: AppColors.orchid,
        ),
        const _GlowOrb(
          alignment: Alignment(-0.9, 0.95),
          size: 340,
          color: AppColors.aurora,
        ),
        const _GlowOrb(
          alignment: Alignment(1.1, 1.1),
          size: 220,
          color: AppColors.gold,
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: const ColoredBox(color: Color(0x12000000)),
          ),
        ),
        child,
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.alignment,
    required this.size,
    required this.color,
  });

  final Alignment alignment;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.55),
              color.withOpacity(0.0),
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingSparkles extends StatelessWidget {
  const FloatingSparkles({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _SparklePainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _SparklePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.18);
    final rng = math.Random(7);
    for (var i = 0; i < 28; i++) {
      final dx = rng.nextDouble() * size.width;
      final dy = rng.nextDouble() * size.height;
      canvas.drawCircle(Offset(dx, dy), rng.nextDouble() * 1.8 + 0.4, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
