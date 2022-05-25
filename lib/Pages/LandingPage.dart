import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/MainPage.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/Reg_Auth.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';
import 'package:provider/provider.dart';
import 'package:mob_cli_for_coll_inv_num/screnns/globals.dart' as globals;



class LandindPage extends StatelessWidget{

  //const LandindPage({Key? key}) : super(key: key);
  LandindPage(this.isLoggedIn);
  final bool isLoggedIn;


  @override
  Widget build(BuildContext context) {

    //final Users? user = Provider.of<Users?>(context);
    //final InvApi? api_auth = Provider.of<InvApi?>(context);

    //final bool check = globals.isLoggedIn != null;
    //print(check);

    return isLoggedIn ? MainPage() : RegPage();
  }
}