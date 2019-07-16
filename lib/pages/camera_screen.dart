import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import './call_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class CameraScreen extends StatefulWidget {
  List<CameraDescription> cameras;
  CameraScreen(this.cameras);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  Future<void> initializeControllerFuture;
  double margin;
  int count = 0;
  double x1, y1, x2, y2;
  double left, right, top, bottom;
  Widget boundingbox;

  void tapped(BuildContext context, TapDownDetails details) {
    if (this.count == 1) {
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
      top = (y1 <= y2) ? y1 - 85 : y2 - 85;
      bottom = (y1 <= y2) ? y2 - 85 : y1 - 85;

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

  void writeBox(filePath) {
    final file = File(filePath + ".json");
    final fileNameList = filePath.split("/");
    final fileName = fileNameList[fileNameList.length - 1];
    final topInt = this.top.toInt();
    final leftInt = this.left.toInt();
    final width = (this.right - this.left).toInt();
    final height = (this.bottom - this.top).toInt();

    final box = '''{\n
      "file": "$fileName.jpg",\n
      "image_size": [{"width": 640, "height": 640, "depth": 3}],\n
      "annotations": [{"class_id": 1, "top": $topInt, "left": $leftInt, "width": $width, "height": $height}]\n
}''';

    return file.writeAsStringSync(box);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        new CameraController(widget.cameras[0], ResolutionPreset.medium);

    initializeControllerFuture = controller.initialize();
    print("camera controller initialized");
    print(controller.value.isInitialized);
  }

  @override
  void dispose() {
    controller?.dispose(); //? is checking if controller is null or not
    super.dispose();
    print("camera controller disposed");
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      print("not initialized");
      return new Container(
        child: new Text("failed"),
      );
    }

    return new Column(children: [
      new AspectRatio(
          aspectRatio: 1, //controller.value.aspectRatio,
          child: new GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (TapDownDetails details) => {tapped(context, details)},
              child: new Stack(children: [
                CameraPreview(controller),
                new Container(
                  color: Colors.transparent,
                  child: boundingbox,
                )
              ]))),
      Row(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: new Container(
                margin: EdgeInsets.all(20.0),
                child: new FloatingActionButton(
                  backgroundColor: Theme.of(context).accentColor,
                  child: new Icon(Icons.camera_alt),
                  onPressed: () async {
                    // Take the Picture in a try / catch block. If anything goes wrong,
                    // catch the error.
                    print("button pressed");
                    try {
                      // Ensure that the camera is initialized.
                      await initializeControllerFuture;

                      // パーミッションの確認・要求
                      if (Platform.isAndroid &&
                          !await SimplePermissions.checkPermission(
                              Permission.WriteExternalStorage)) {
                        SimplePermissions.requestPermission(
                            Permission.WriteExternalStorage);
                      } else if (Platform.isIOS &&
                          !await SimplePermissions.checkPermission(
                              Permission.PhotoLibrary)) {
                        SimplePermissions.requestPermission(
                            Permission.PhotoLibrary);
                      }

                      // Attempt to take a picture and log where it's been saved.
                      final Directory extDir =
                          await getExternalStorageDirectory(); // 外部領域
                      final String dirPath =
                          '${extDir.path}/Pictures/flutter_camera';
                      var now = new DateTime.now();
                      var formatter = new DateFormat("yyyyMMdd-HHmmss");
                      var formatted = formatter.format(now);
                      await Directory(dirPath).create(recursive: true);
                      final String filePath = '$dirPath/$formatted';
                      final String filePathImg = '$dirPath/$formatted.jpg';

                      if (controller.value.isTakingPicture) {
                        print("return null");
                        return null;
                      }

                      await controller.takePicture(filePathImg);
                      print("picture is taken");

                      await writeBox(filePath);
                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                    }
                  },
                ))),
        Align(
            alignment: Alignment.center,
            child: new Container(
                margin: EdgeInsets.all(20.0),
                child: new FloatingActionButton(
                  backgroundColor: Theme.of(context).accentColor,
                  child: new Icon(Icons.check_box_outline_blank),
                  onPressed: () => {
                        setState(() => {
                              boundingbox =
                                  new Container(color: Colors.transparent)
                            }),
                        this.count = 1
                      },
                ))),
      ]),
    ]);
  }
}
