import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:green_go/components/styles/app_style.dart';

class CustomProgressWidget extends StatefulWidget {
  final double w;
  final double h;
  final Color color;
  CustomProgressWidget({this.h, this.w, this.color});

  @override
  _CustomProgressWidgetState createState() => _CustomProgressWidgetState();
}

class _CustomProgressWidgetState extends State<CustomProgressWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.w,
      height: widget.h,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            painter: ProgressPainter(controller, widget.color),
          );
        },
      ),
    );
  }
}

class ProgressPainter extends CustomPainter {
  double startAngle;
  double sweepAngle;
  Color color;
  final AnimationController controller;

  ProgressPainter(this.controller, this.color) {
    startAngle = Tween(begin: math.pi * 1.5, end: math.pi * 3.5)
        .chain(CurveTween(curve: Interval(0.5, 1.0)))
        .evaluate(controller);
    sweepAngle = math.sin(controller.value * math.pi) * math.pi;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    Paint paint = Paint()
      ..color = color == null ? AppStyle.colorPurple : color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
      Offset.zero & Size(side, side),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(ProgressPainter other) {
    return startAngle != other.startAngle || sweepAngle != other.sweepAngle;
  }
}
