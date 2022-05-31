import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';

class Companies_List extends StatefulWidget{

  Companies_List({Key? key}) : super(key: key);

  @override
  _Companies_ListState createState() => new _Companies_ListState();

}
class _Companies_ListState extends State<Companies_List> {


  String? _selectComp;

  InvApi api_comp = InvApi();
  late Future<List<Company>> futureCompany;



  var _holder;



  @override
  void initState() {
    super.initState();
    futureCompany = api_comp.get_companies();
    //print(futureCompany);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 50,
      width: 161,
      child: FutureBuilder<List<Company>>(
        future: futureCompany,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            //print(snapshot.data);
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {


            print(_selectComp);
            //print(snapshot.data);
            return DropdownButton<String>(
              hint: Text('Acc'),
              value: _selectComp,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              items: snapshot.data!.map((item)=>
                 DropdownMenuItem<String>(
                  child: Text(item.name),
                  value: item.id.toString(),
                )).toList(),
              //onChanged: widget.onChanged as void Function(String?),
              onChanged: (val){
                setState(() {
                  _selectComp=val;
                });
              });
          } else if (snapshot.hasError) {
            return Text(
                '${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}