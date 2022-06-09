import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';

class ObjectPage extends StatefulWidget {
  final String? inv_num;
  const ObjectPage({Key? key, required this.inv_num}) : super(key: key);

  @override
  ObjectPageState createState()=>ObjectPageState(
      inv_num:this.inv_num
  );
}
enum OperationList { plus, minus }
class ObjectPageState extends State<ObjectPage> {
  var inv_num;
  ObjectPageState({this.inv_num});
  InvApi api_item = InvApi();
  late Future<Report> futureItem;

  void initState() {
    super.initState();
    futureItem = api_item.get_object(this.inv_num); //Запрос на сервер данных о предмете по инвентарному номеру
    print(widget.inv_num);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            "Подтверждение",
            style: TextStyle(color: Colors.white, fontFamily: 'Overpass', fontSize: 20),
          ),
          elevation: 0.0,
        ),
        backgroundColor: Colors.white.withOpacity(0.90),
        body: Center(
          child: ListView(
            children: [
              const SizedBox(height: 24),
              //  buildName("joe"),
              const SizedBox(height: 24),
              Center(
                  child: FutureBuilder<Report>(
                    future: futureItem,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasData) {
                        InvApi api_inv = InvApi();
                        return Container(
                          child: Column(
                            children: [
                              Text(
                                snapshot.data!.inv_num,
                                style: TextStyle(
                                    //color: Colors.white,
                                    fontFamily: 'Nunito',
                                    fontSize: 35),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data!.name,
                                style: TextStyle(
                                    //color: Colors.white,
                                    fontFamily: 'Nunito',
                                    fontSize: 35),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshot.data!.datetime_inv,
                                style: TextStyle(
                                    //color: Colors.white,
                                    fontFamily: 'Nunito',
                                    fontSize: 35),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () async{
                                    if(await api_inv.apply_inv(inv_num)==0){
                                      Fluttertoast.showToast(
                                          msg: "Подтверждено",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                      Navigator.pop(context);
                                    }else{
                                      Fluttertoast.showToast(
                                          msg: "Ошибка",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  },
                                  child: Text('Подтвердить'),
                                  )
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                            '${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        )
    );
  }

}