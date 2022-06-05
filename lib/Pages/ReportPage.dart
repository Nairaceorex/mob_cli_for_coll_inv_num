
import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';
import 'package:mob_cli_for_coll_inv_num/Widgets/Companies_List.dart';

class ReportPage extends StatefulWidget{
  ReportPage({Key? key}) : super (key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>{
  InvApi api_rep = InvApi();
  late Future<List<Report>> futureReport;

  @override
  void initState() {
    super.initState();
    futureReport = api_rep.get_objects();
    print(futureReport);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder<List<Report>>(
        future: futureReport,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List<Report>? data = snapshot.data;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                sortColumnIndex: 0,
                showCheckboxColumn: false,
                columns: [
                  DataColumn(
                      label: Text("Номер"),
                  ),
                  DataColumn(
                    label: Text("Название"),
                  ),
                  DataColumn(
                    label: Text("Дата"),
                  ),
                ],
                rows: data!
                    .map(
                      (item) => DataRow(
                      onSelectChanged: (b) {
                        print(item.inv_num);
                      },
                      cells: [
                        DataCell(
                            Text(item.inv_num)
                        ),
                        DataCell(
                          Text(item.name),
                        ),
                        DataCell(
                          Text(item.datetime_inv),
                        ),
                      ]),
                )
                    .toList(),
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
    );
  }
  DataRow buildList(data, g, snapshot) {
    var docs = snapshot.data.docs;
    final acc = docs[g].data()!;
    /*List<String> wasd = <String>[];
    for(int i=0; i < wasd.length; i++){
      wasd.insert(i, acc['summary'].toString());

    }*/
    //print(wasd.runtimeType);
    //print("${acc['name'].runtimeType}");
    //wasd.clear();

    //wasd.insert(wasd.length, acc['summary'].toString());
    /*print(wasd.length);
    print(wasd);*/
    /*for(int i=0; i < wasd.length; i++){
      print(wasd[i]);
    }*/
    return DataRow(cells: [

      DataCell(Text(acc['name'])),
      DataCell(Text(acc['name'])),
      DataCell(Text(acc['name'])),


    ]);
    /*if (acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid){
      return DataRow(cells: [

      DataCell(Text(acc['name'])),
      DataCell(Text("${acc['summary']}")),

    ]);
    }
    else{
      print('error');
    }
*/
    /*return DataRow(
        cells: [
          DataCell(
            Container(
              width: 25,
            )
          ),
          DataCell(
              Container(
                width: 25,
              )
          )
        ]);*/

    /*return DataRow(cells: [

      DataCell(Text(
          acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid
              ? acc['name']: null)
      ),
      DataCell(Text(
          acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid
              ? "${acc['summary']}" : "")
      ),

    ]);*/
    /*return DataRow(cells: [

      DataCell(Text(
          acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid
              ? acc['name']: "")
      ),
      DataCell(Text(
          acc['user_uid'] == FirebaseAuth.instance.currentUser!.uid
              ? "${acc['summary']}" : "")
      ),

    ]);*/
    /*return DataRow(cells: [

      DataCell(Text(data.docs[i]['name'])),
      DataCell(Text("${data.docs[i]['summary']}")),

    ]);*/
  }
}