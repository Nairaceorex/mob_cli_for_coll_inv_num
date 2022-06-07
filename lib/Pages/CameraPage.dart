
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/ObjectPage.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';
import 'package:mob_cli_for_coll_inv_num/Widgets/EditButton.dart';

class CameraPage extends StatefulWidget{
  CameraPage({Key? key}) : super (key: key);
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>{
  final _formKey = GlobalKey<FormState>();

  var _accountname;
  var _accountsummary;

  InvApi user_confirm = InvApi();
  late Future<User> futureUser;

  InvApi api_item = InvApi();
  late Future<Report> futureItem;


  late TextEditingController _numController = TextEditingController();
  var _invnum;

  bool _btnEnabled = false;

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
                                //errorText: _currenterror? "Введите правильные данные":null,
                                hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
                                //hintText: hint,
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

                    // By default, show a loading spinner.
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
                    //print(_invnum);


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



  }
 /* Widget editForm(){

    _invnum = _numController.text;


    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 250,
          child: TextField(

            controller: _numController,

            //cursorColor: Colors.white,

            style: TextStyle(fontSize: 20,),
            decoration: InputDecoration(
              //errorText: _currenterror? "Введите правильные данные":null,
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
              //hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide( width: 1)
              ),
              /*prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 10, right: 30),
                        child: IconTheme(
                          data: IconThemeData(color: Colors.white,),
                          child: icon,
                        ),

                      )*/
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),

        buildUpgradeButton(_invnum),



      ],
    );
  }
  Widget buildUpgradeButton(var _invnum) => ButtonWidget(
    text: 'Добавить счёт',

    onClicked: () {
      print(_invnum);
      Navigator.push(context, MaterialPageRoute(builder: (context) => new ObjectPage(inv_num: _invnum,)));
    },
  );

  Widget _redAcc(var _invnum) {
    futureItem=api_item.get_object(_invnum);

    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
          title: Text(
            "Добавить счёт",
            style: TextStyle(color: Colors.white, fontFamily: 'Overpass', fontSize: 20),
          ),
          elevation: 0.0,

        ),
        backgroundColor: Colors.white.withOpacity(0.90),
        body: Center(
          child: ListView(
            children: [
              //AccountForm()
              //_form("Добавить",_buttonAction),
              FutureBuilder<Report>(
                future: futureItem,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData) {

                    return Container(
                      child: Column(
                        children: [
                          Text(
                            snapshot.data!.inv_num,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 35),
                          ),
                          Text(
                            snapshot.data!.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 35),
                          ),
                          Text(
                            snapshot.data!.datetime_inv,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 35),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                        '${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        )
    );

  }
  Widget _button(String text, var name, var sum){
    //CollectionReference _account = FirebaseFirestore.instance.collection('Account');

    return ElevatedButton(
      onPressed: (){
        // Переходим к новому маршруту
        if(_formKey.currentState!.validate()){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Счёт успешно добавлен'),
                backgroundColor: Colors.green,
              )
          );
          print(name);
          print(sum);
          //_account.add({'name': name, 'summary': sum, 'user_uid':FirebaseAuth.instance.currentUser!.uid });

        }
        Navigator.pop(context);
      },
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.pinkAccent, // background
        onPrimary: Colors.white, // foreground
      ),
    );
  }*/
}