
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';

class CameraPage extends StatefulWidget{
  CameraPage({Key? key}) : super (key: key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>{

  InvApi user_confirm = InvApi();
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = user_confirm.get_user();
  }

  File? _image;

  Future _openCamera(ImageSource source) async{

    final ImagePicker _picker = ImagePicker();
    final ImageCropper _cropper = ImageCropper();


    var image = await _picker.getImage(source: source);

    AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
      toolbarTitle: 'Crop Image',
      toolbarColor: Colors.deepPurpleAccent,
      toolbarWidgetColor: Colors.white,
      activeControlsWidgetColor: Colors.deepPurpleAccent,
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




    setState((){
      _image = File(croppedFile!.path);
    });
  }

  Future<void> presentAlert(BuildContext context, {String title = '', String message = '', Function()? ok}) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text('$title'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text('$message'),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  // style: greenText,
                ),
                onPressed: ok != null ? ok : Navigator.of(context).pop,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final InvApi api = InvApi();
    return Scaffold(
      body: Center(
        child: _image == null
            ? Text('Изображение')
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
            label: Text('Камера'),
            icon: Icon(Icons.camera),

          ),
          SizedBox(
            width: 5,
          ),
          FloatingActionButton.extended(
            onPressed: () => _openCamera(ImageSource.gallery),
            heroTag: UniqueKey(),
            label: Text('Галерея'),
            icon: Icon(Icons.image),

          ),
          SizedBox(
            width: 5,
          ),
          FutureBuilder<User>(
            future: futureUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return (snapshot.data!.is_confirm==1 && _image != null
                    ? FloatingActionButton.extended(
                  heroTag: UniqueKey(),
                  onPressed: () async{
                    var responseDataHttp = await api.uploadPhotos(_image!.path);
                    await presentAlert(context,
                        title: 'Успешно',
                        message: responseDataHttp);

                  },
                  label: Text('ОК'),
                  icon: Icon(Icons.send),
                )
                    : Text(''));
              } else if (snapshot.hasError) {
                return Text(
                    '${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
          /*(_image != null
              ? FloatingActionButton.extended(
            heroTag: UniqueKey(),
            onPressed: () async{
              var responseDataHttp = await api.uploadPhotos(_image!.path);
              await presentAlert(context,
                  title: 'Success HTTP',
                  message: responseDataHttp);
            },
            label: Text('Send'),
            icon: Icon(Icons.send),
          )
              : Text("")
          ),*/

        ],
      ),

    );

/*FutureBuilder<User>(
      future: futureUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {

          return (snapshot.data!.is_confirm==1
              ? _widget()
              : Icon(Icons.cancel,
              color: Colors.red));
        } else if (snapshot.hasError) {
          return Text(
              '${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );*/

  }
}