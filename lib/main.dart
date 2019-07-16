import 'package:camera_app/input_label.dart';
import 'package:camera_app/whatsapp_home.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  cameras = await availableCameras();
  await runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "cameraApp",
      theme: new ThemeData(
          primaryColor: new Color(0xff075E54),
          accentColor: new Color(0xff25D366)),
      home: new InputLabel(cameras),
    );
  }
}
