
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';
import 'package:mob_cli_for_coll_inv_num/Widgets/EditButton.dart';

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
    futureItem = api_item.get_object(this.inv_num);
    print(widget.inv_num);
  }

  //Account account = Account();


  @override
  Widget build(BuildContext context) {
    //final user = UserPref.myUser;
    //CollectionReference _account = FirebaseFirestore.instance.collection('Account');

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
                              ElevatedButton(
                                  onPressed: () async{
                                    await api_inv.apply_inv(inv_num);
                                    Navigator.pop(context);
                                  },
                                  child: Text('push'),
                                  )


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
              ),
              const SizedBox(height: 24),
              //buildArea(),

            ],
          ),
        )
    );
  }
 /*Widget buildUpgradeButton() => ButtonWidget(
    text: 'Добавить счёт',
    onClicked: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => _redAcc()));
    },
  );*/

 /* Widget _redAcc() {
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
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 20, top: 10),
                          child: Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(

                              style: TextStyle(fontSize: 20,color: Colors.pink),
                              decoration: InputDecoration(
                                  hintStyle: TextStyle( fontSize: 20, color: Colors.pink),
                                  hintText: "Acc",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.pink, width: 3)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 1)
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 10, right: 30),
                                    child: IconTheme(
                                      data: IconThemeData(color: Colors.pinkAccent),
                                      child: Icon(Icons.account_balance_wallet),
                                    ),

                                  )
                              ),
                              onChanged: (value){
                                _accountname=value;
                              },
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return 'null';
                                }
                              },
                            ),
                          )//child: Text("Email"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20, top: 10),
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(

                            style: TextStyle(fontSize: 20,color: Colors.pink),
                            decoration: InputDecoration(
                                hintStyle: TextStyle( fontSize: 20, color: Colors.pink),
                                hintText: "sum",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink, width: 3)
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pinkAccent, width: 1)
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 30),
                                  child: IconTheme(
                                    data: IconThemeData(color: Colors.pinkAccent),
                                    child: Icon(Icons.account_balance_wallet),
                                  ),

                                )
                            ),
                            onChanged: (value){
                              _accountsummary=int.parse(value);
                            },
                            validator: (value){
                              if (value == null || value.isEmpty){
                                return 'null';
                              }
                            },
                          ),
                        ),
                        //child: Text("Email"),
                      ),


                      SizedBox(height: 20,),

                      Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20
                        ),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: _button("Add",_accountname,_accountsummary),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
    );

  }*/

  /*Widget _button(String text, var name, var sum){
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
  }
*/


}