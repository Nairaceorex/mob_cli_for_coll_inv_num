import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/ObjectPage.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';

class CameraPage extends StatefulWidget{
  CameraPage({Key? key}) : super (key: key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>{

  InvApi user_confirm = InvApi();
  late Future<User> futureUser;

  InvApi api_item = InvApi();
  late Future<Report> futureItem;


  late TextEditingController _numController = TextEditingController();
  var _invnum;

  @override
  void initState() {
    super.initState();
    futureUser = user_confirm.get_user();
  }

  File? _image;
  //Функция загрузки изображения из камеры или галереи
  Future _openCamera(ImageSource source) async{

    final ImagePicker _picker = ImagePicker();
    final ImageCropper _cropper = ImageCropper();

    var image = await _picker.getImage(source: source);

    AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
      toolbarTitle: 'Обработка изображения',
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

  @override
  Widget build(BuildContext context) {
    final InvApi api = InvApi();
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: _image == null
                ? Text('Изображение')
                : Image.file(
              _image!,
              height: 200,
              width: 250,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                //Только пользователи с подтверждением могут отправлять, редактировать номер
                FutureBuilder<User>(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      return (snapshot.data!.is_confirm==1 && _image != null
                          ? Container(
                        child: Column(
                          children: [
                            TextField(
                              controller: _numController,
                              style: TextStyle(fontSize: 20,),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide( width: 1)
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _invnum=_numController.text;
                                print(_invnum);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ObjectPage(inv_num: _invnum,)));
                              },
                              child: Text('Далее'),),
                          ],
                        ),
                      )
                          : Text(''));
                    } else if (snapshot.hasError) {
                      return Text(
                          '${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ],
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
                    _numController.text = json.decode(responseDataHttp)['data'];
                  },
                  label: Text('ОК'),
                  icon: Icon(Icons.send),
                )
                    : Text(''));
              } else if (snapshot.hasError) {
                return Text(
                    '${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}