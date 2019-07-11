import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  double margin;
  int count = 0;
  double x1, y1, x2, y2;
  double left, right, top, bottom;
  Container boundingbox;

  void tapped(BuildContext context, TapDownDetails details) {
    if (this.count == 0) {
      this.count += 1;
      //print('${details.globalPosition}');
      x1 = details.globalPosition.dx;
      y1 = details.globalPosition.dy;
      print("x1,y1:$x1, $y1");
    } else {
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
            this.boundingbox = new Container(
              margin: new EdgeInsets.fromLTRB(x1, y1, x2, y2),
              decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.blueAccent)),
            )
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (TapDownDetails details) => {tapped(context, details)},
        // child: new Container(
        //   margin: const EdgeInsets.all(15.0),
        //   decoration: new BoxDecoration(
        //       border: new Border.all(color: Colors.blueAccent)),
        child: new Container(
          child: this.boundingbox,
        ),
      ),
    );
  }
}
