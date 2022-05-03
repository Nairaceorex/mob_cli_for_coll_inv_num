import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/CameraPage.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/HomePage.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/ReportPage.dart';
import 'package:mob_cli_for_coll_inv_num/Widgets/CustomButtomNavigation.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }

}

class MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  Widget _myContacts = HomePage();
  Widget _myEmails = CameraPage();
  Widget _myProfile = ReportPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INV"),
        actions: <Widget>[
          IconButton(
              onPressed: (){

              },
              icon: Icon(
                Icons.exit_to_app,
              ))
        ],
      ),
      body:  this.getBody(),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: selectedIndex,
        callback: (newIndex) => setState(
              () => this.selectedIndex = newIndex,
        ),
      ),

    );
  }

  Widget getBody( )  {
    if(this.selectedIndex == 0) {
      return this._myContacts;
    } else if(this.selectedIndex==1) {
      return this._myEmails;
    } else {
      return this._myProfile;
    }
  }


}