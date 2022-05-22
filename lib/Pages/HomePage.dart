
import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/proto/exemples.dart';

class HomePage extends StatefulWidget{
  HomePage({Key? key}) : super (key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
  final user = UserProf.myUser;
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: <Widget>[

                  Container(
                    height: height*0.4,
                    width: width*0.95,
                    child: LayoutBuilder(
                      builder: (context, constrains){
                        double innerHeight = constrains.maxHeight;
                        double innerWidth = constrains.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: innerHeight*0.6,
                                  width: innerWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blue,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        user.fullname,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontSize: 35
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                  'Id',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Nunito',
                                                    fontSize: 25
                                                  ),
                                              ),
                                              Text(
                                                  user.id.toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Nunito',
                                                    fontSize: 25
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 25,
                                              vertical: 8
                                            ),
                                            child: Container(
                                              height: 40,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Colors.white38,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                  'Confirm',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Nunito',
                                                    fontSize: 25
                                                ),
                                              ),
                                              (
                                                  user.confirm ?
                                                  Icon(Icons.check_circle, color: Colors.white,)
                                                  : Icon(Icons.cancel,color: Colors.white)
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                            ),

                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: height*0.5,
                    width: width*0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 25
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          Container(
                            height: height*0.15,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Company',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 25
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          Container(
                            height: height*0.15,
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}