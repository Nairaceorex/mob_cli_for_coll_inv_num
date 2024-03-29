import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InvApi api = InvApi();
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = api.get_user();
  }

  @override
  Widget build(BuildContext context) {
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
                    height: height * 0.4,
                    width: width * 0.95,
                    child: LayoutBuilder(
                      builder: (context, constrains) {
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
                                  height: innerHeight * 0.6,
                                  width: innerWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      FutureBuilder<User>(
                                        future: futureUser,
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.hasData) {
                                            print(snapshot.data!.fullname);
                                            return Text(
                                              snapshot.data!.fullname,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 35),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                '${snapshot.error}');
                                          }
                                          return const CircularProgressIndicator();
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'Номер',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Nunito',
                                                    fontSize: 25),
                                              ),
                                              //Виджет, который строит себя на основе последнего снимка взаимодействия с будущим.
                                              FutureBuilder<User>(
                                                future: futureUser,
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return CircularProgressIndicator();
                                                  } else if (snapshot.hasData) {
                                                    print(snapshot.data!.id.toString());
                                                    return Text(
                                                      snapshot.data!.id.toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Nunito',
                                                          fontSize: 23),
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    return Text(
                                                        '${snapshot.error}');
                                                  }
                                                  return const CircularProgressIndicator();
                                                },
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 25, vertical: 8),
                                            child: Container(
                                              height: 40,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.white38,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Подтверждение',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Nunito',
                                                    fontSize: 25),
                                              ),
                                              FutureBuilder<User>(
                                                future: futureUser,
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return CircularProgressIndicator();
                                                  } else if (snapshot.hasData) {
                                                    print(snapshot.data!.is_confirm);
                                                    return (snapshot.data!.is_confirm==1
                                                        ? Icon(
                                                      Icons.check_circle,
                                                      color: Colors.white,
                                                    )
                                                        : Icon(Icons.cancel,
                                                        color: Colors.white));
                                                  } else if (snapshot.hasError) {
                                                    return Text(
                                                        '${snapshot.error}');
                                                  }
                                                  return const CircularProgressIndicator();
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/logo/inventory.png',
                                    width: innerWidth * 0.4,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: height * 0.39,
                    width: width * 0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.deepPurpleAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Почта',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 25),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          Container(
                            height: height * 0.10,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder<User>(
                                    future: futureUser,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasData) {
                                        print(snapshot.data!.email);
                                        return Text(
                                          snapshot.data!.email,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Nunito',
                                              fontSize: 23),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            '${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Компания',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito',
                                fontSize: 25),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
                          Container(
                            height: height * 0.10,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder<User>(
                                    future: futureUser,
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasData) {
                                        print(snapshot.data!.company);
                                        return Text(
                                          snapshot.data!.company,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Nunito',
                                              fontSize: 23),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            '${snapshot.error}');
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ],
                              ),
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
