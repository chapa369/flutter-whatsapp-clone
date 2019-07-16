import 'package:camera/camera.dart';
import 'package:camera_app/whatsapp_home.dart';
import 'package:flutter/material.dart';

class InputLabel extends StatefulWidget {
  List<CameraDescription> cameras;
  InputLabel(this.cameras);
  @override
  _InputLabelState createState() => _InputLabelState();
}

class _InputLabelState extends State<InputLabel> {
  String _label;

  _InputLabelState();

  final formKey = new GlobalKey<FormState>();

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'label name'),
        validator: (value) =>
            value.isEmpty ? 'label name should not be empty' : null,
        onSaved: (value) => _label = value,
      ),
      new RaisedButton(
        child: new Text('Enter', style: new TextStyle(fontSize: 20.0)),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute<Null>(
              settings: const RouteSettings(name: "/camera"),
              builder: (BuildContext context) =>
                  WhatsAppHome(_label, widget.cameras),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: new AppBar(
          title: new Text("Annotation box camera"),
        ),
        body: new Align(
            alignment: Alignment.center,
            child: new Center(
              // padding: EdgeInsets.all(20.0),
              child: new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs(),
                ),
              ),
            )));
  }
}
