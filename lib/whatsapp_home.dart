import 'package:camera_app/pages/call_screen.dart';
import 'package:camera_app/pages/chat_screen.dart';
import 'package:camera_app/pages/status_screen.dart';
import 'package:flutter/material.dart';

import 'pages/camera_screen.dart';

class WhatsAppHome extends StatefulWidget {
  String _label;
  var cameras;
  WhatsAppHome(this._label, this.cameras);

  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
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
