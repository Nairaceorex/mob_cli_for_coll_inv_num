
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget{
  CameraPage({Key? key}) : super (key: key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>{

  File? _image;

  Future _openCamera(ImageSource source) async{
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(source: source);
    setState((){
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(
              child: _image == null
                  ? Text('Image')
                  : Image.file(
                      _image!,
                      height: 400,
                      width: 400,
              ),
            ),
            ElevatedButton(
                onPressed: () => _openCamera(ImageSource.camera),
                child: Text('Camera'))
          ],
        ),
      ),

    );
  }
}