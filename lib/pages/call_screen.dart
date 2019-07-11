import 'package:flutter/material.dart';
import 'dart:math';

class CallsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CustomPaint(
      foregroundPainter: new MyPainter(
        lineColor: Colors.amber,
        width: 8.0,
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Color lineColor;
  double width;
  MyPainter({this.lineColor, this.width});
  var rect = Rect.fromLTRB(30, 30, 400, 500);

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    canvas.drawRect(rect, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
