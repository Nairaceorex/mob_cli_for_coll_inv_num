
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
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
    final ImageCropper _cropper = ImageCropper();

    var image = await _picker.pickImage(source: source);

    AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      toolbarColor: Colors.blue,
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.original,
      lockAspectRatio: false,
    );

    File? croppedFile = await _cropper.cropImage(
      sourcePath: image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: androidUiSettingsLocked(),
    );



    /*File? result = await FlutterImageCompress.compressAndGetFile(
      croppedFile!.path,
      croppedFile.path,
      quality: 50,
      //rotate: 180,
    );*/

    setState((){
      _image = File(croppedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: _image == null
            ? Text('Image')
            : Image.file(
          _image!,
          height: 300,
          width: 300,
        ),
      ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
                onPressed: () => _openCamera(ImageSource.camera),
                heroTag: UniqueKey(),
                label: Text('Camera'),
                icon: Icon(Icons.camera),

            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton.extended(
              onPressed: () => _openCamera(ImageSource.gallery),
              heroTag: UniqueKey(),
              label: Text('Gallery'),
              icon: Icon(Icons.image),

            ),


          ],
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => _openCamera(ImageSource.camera),
                child: Text('Camera')),
          ],
        ),*/
      );


  }
}