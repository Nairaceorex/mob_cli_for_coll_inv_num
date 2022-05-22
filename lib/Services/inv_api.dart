import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';

class InvApi {
  String nickname = '';
  String password = '';
  bool debug = false;

  String url_api = 'https://inventory-mp41-18.herokuapp.com/api/';
  String url_server = 'http://192.168.1.65:5000/';
//https://inventory-mp41-18.herokuapp.com/api/get_companies

  Future<int> reg(String email, String nickname, String password, int company_id) async {
    int result = 0;
    Uri url = Uri.parse(url_api + 'reg');
    var response = await http.post(
      url,
      body: json
          .encode({'fullname': nickname, 'password': password, 'email': email, 'company': company_id}),
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

  Future<int> login(String nickname, String password) async {
    int result = 0;
    Uri url = Uri.parse(url_api + 'log');
    var response = await http.post(
      url,
      body: json.encode({'fullname': nickname, 'password': password}),
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

  Future<List<Company>?> get_companies() async{
    List<Company> result =[];
    Uri url = Uri.parse(url_api + 'get_companies');
    var response = await http.get(url);
    var result_json = json.decode(response.body);
    if (response.statusCode == 200) {
      int code = result_json['code'];
      if (code == 0) {
        var data = result_json['data'];
        for (var comp in data) {
          result.add(Company(
              id: comp['id'],
              name: comp['name']));
        }
      }
    }
    return result;
  }

}