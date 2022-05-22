
import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Widgets/Companies_List.dart';

class ReportPage extends StatefulWidget{
  ReportPage({Key? key}) : super (key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: <Widget>[
                  Text('Отчет'),
                  Companies_List()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}