import 'package:camera_app/pages/camera_screen.dart';
import 'package:flutter/material.dart';

class CallsScreen extends StatefulWidget {
  @override
  _CallsScreenState createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  double margin;
  int count = 0;
  double x1, y1, x2, y2;
  double left, right, top, bottom;
  Widget boundingbox;

  void tapped(BuildContext context, TapDownDetails details) {
    if (this.count == 0) {
      this.count += 1;
      setState(
          () => {this.boundingbox = new Container(color: Colors.transparent)});
    } else if (this.count == 1) {
      this.count += 1;
      //print('${details.globalPosition}');
      x1 = details.globalPosition.dx;
      y1 = details.globalPosition.dy;
      print("x1,y1:$x1, $y1");
    } else if (this.count == 2) {
      this.count = 0;
      //print('${details.globalPosition}');
      x2 = details.globalPosition.dx;
      y2 = details.globalPosition.dy;
      left = (x1 <= x2) ? x1 : x2;
      right = (x1 <= x2) ? x2 : x1;
      top = (y1 <= y2) ? y1 - 130 : y2 - 130;
      bottom = (y1 <= y2) ? y2 - 130 : y1 - 130;

      print("x2,y2:$x2, $y2");
      setState(() => {
            this.boundingbox = new CustomPaint(
              foregroundPainter: new MyPainter(
                  lineColor: Colors.amber,
                  left: left,
                  top: top,
                  right: right,
                  bottom: bottom),
            ),
            print("reset state")
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) => {tapped(context, details)},
        child: boundingbox
        // child: new Stack(children: [
        //   boundingbox,
        // new Align(
        //     alignment: Alignment.bottomRight,
        //     child: new Container(
        //         margin: EdgeInsets.all(20.0),
        //         child: new FloatingActionButton(
        //           backgroundColor: Theme.of(context).accentColor,
        //           child: new Icon(Icons.check_box_outline_blank),
        //           onPressed: () => print("take photo"),
        //         ))),
        // ]),
        );
  }
}

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
