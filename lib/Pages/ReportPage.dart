import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';

class ReportPage extends StatefulWidget{
  ReportPage({Key? key}) : super (key: key);
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>{
  InvApi api_rep = InvApi();
  late Future<List<Report>> futureReport;
  InvApi user_confirm = InvApi();
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureReport = api_rep.get_objects();
    futureUser = user_confirm.get_user();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return (snapshot.data!.is_confirm==1
                      ? FutureBuilder<List<Report>>( //Вывод данныхо всех предметах компании в виде строк таблицы
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
                      return const CircularProgressIndicator();
                    },
                  )
                      : Text('Необходимо подтверждение!', style: TextStyle(
                    color: Colors.red,fontSize: 25
                  ),));
                } else if (snapshot.hasError) {
                  return Text(
                      '${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
    );
  }
}

