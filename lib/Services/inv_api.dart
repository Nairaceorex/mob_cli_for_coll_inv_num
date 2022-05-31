import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:flutter_session/flutter_session.dart';

class InvApi {
  String nickname = '';
  String password = '';
  bool debug = false;

  String url_api = 'http://192.168.1.53:5000/api/';
  String url_server = 'http://192.168.1.65:5000/';

//https://inventory-mp41-18.herokuapp.com/api/get_companies

  Future<int> reg(String email, String nickname, String password,
      int company_id) async {
    int result = 0;
    Uri url = Uri.parse(url_api + 'reg');
    var response = await http.post(
      url,
      body: json
          .encode({
        'fullname': nickname,
        'password': password,
        'email': email,
        'company': company_id
      }),
    );
    var result_json = json.decode(response.body);
    if (response.statusCode == 200) {
      result = result_json['code'];
      if (result == 0) {
        this.nickname = nickname;
        this.password = password;
      }
    } else {
      result = -1;
    }
    return result;
  }

  Future<int> login(String email, String password) async {
    int result = 0;
    Uri url = Uri.parse(url_api + 'auth');
    var response = await http.post(
      url,
      body: json.encode({'email': email, 'password': password}),
    );
    var result_json = json.decode(response.body);
    if (response.statusCode == 200) {
      result = result_json['code'];
      if (result == 0) {
        await FlutterSession().set("email", email);
        await FlutterSession().set("password", password);
      }
    } else {
      result = -1;
    }
    return result;
  }

  Future<List<Company>> get_companies() async {
    List<Company> result = [];
    Uri url = Uri.parse(url_api + 'get_companies');
    var response = await http.get(url);
    var result_json = json.decode(response.body);
    if (response.statusCode == 200) {
      int code = result_json['code'];
      //print(result_json['data']);
      if (code == 0) {
        var data = result_json['data'];
        for(var comp in data){
          result.add(Company(id: comp['id'], name: comp['name']));
        }
      }
    }

    return result;
  }

  Future<User> get_user() async {
    var result;
    Uri url = Uri.parse(url_api + 'get_user');
    var response = await http.post(url, body: json
        .encode({
      'password': await FlutterSession().get("password"),
      'email': await FlutterSession().get("email")
    }),
    );
    if (response.statusCode == 200) {
      var result_json = json.decode(response.body);
      int code = result_json['code'];
      if (code == 0) {
        //print(result_json);
        result = User.fromJson(result_json['data']);
      }
    } else {
      throw Exception('fail');
    }
    return result;
  }

  Future<String> uploadPhotos(String path) async {
    Uri uri = Uri.parse(url_api + 'get_inv');
    http.MultipartRequest request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('files', path));

    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    /*print('\n\n');
    print('RESPONSE WITH HTTP');
    print(responseString);
    print('\n\n');*/
    if(response.statusCode == 200){
      print('Image uploaded!');
    } else{
      print('Image not uploaded');
    }
    return responseString;
  }
}