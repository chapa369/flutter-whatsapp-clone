import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  Color lineColor;
  double left, top, right, bottom;

  MyPainter({this.lineColor, this.left, this.top, this.right, this.bottom});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    var rect = Rect.fromLTRB(left, top, right, bottom);
    canvas.drawRect(rect, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RestrictArea extends CustomPainter {
  Color lineColor;
  double left, top, right, bottom;

  RestrictArea({this.lineColor, this.left, this.top, this.right, this.bottom});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    var rect = Rect.fromLTRB(left, top, right, bottom);
    canvas.drawRect(rect, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
