
import 'package:flutter/material.dart';

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}