import 'package:flutter/material.dart';

import 'pages/camera_screen.dart';

class CameraAppHome extends StatefulWidget {
  final cameras;
  CameraAppHome(this.cameras);

  @override
  _CameraAppHomeState createState() => _CameraAppHomeState();
}

class _CameraAppHomeState extends State<CameraAppHome>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("cameraApp"),
        elevation: 0.7,
      ),
      body: new CameraScreen(widget.cameras),
    );
  }
}
