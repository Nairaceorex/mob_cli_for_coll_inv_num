import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';

class Companies_List extends StatefulWidget{
  Companies_List({Key? key}) : super(key: key);
  InvApi api = InvApi();

  @override
  _Companies_ListState createState() => new _Companies_ListState(api.get_companies());

}
class _Companies_ListState extends State<Companies_List> {

  //InvApi api = InvApi();
  dynamic data;
  List<Company> _comp = [];
  String? comp_value;
  _Companies_ListState(this.data){
    this.data = data;
}


  @override
  Widget build(BuildContext context) {
    print('qwerty');
    print(data);
    //final json = JsonDecoder().convert(this.data);
    _comp = (data).map<Company>((item) => Company.fromJson(item)).toList();
    //_comp = (data as List).map((it) => Company.fromJson(it).toList());
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: DropdownButton(
                isExpanded:true,
                value: comp_value,
                isDense: true,
                onChanged: (String? newValue){
                  setState((){
                    comp_value = newValue;
                  });
                },
                hint: Text("Select company"),
                items: _comp.map((Company map){
                  return new DropdownMenuItem<String>(
                      value: map.id as String?,
                      child: new Text(map.name as String));
                }).toList(),

              ),
            )
          ],
        ),
      ),
    );
  }
}