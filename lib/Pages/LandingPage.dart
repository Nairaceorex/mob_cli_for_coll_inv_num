import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/MainPage.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/Reg_Auth.dart';


class LandindPage extends StatelessWidget{

  const LandindPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Users? user = Provider.of<Users?>(context);
    final bool isLoggedIn = true;

    return isLoggedIn ? MainPage() : RegPage();
  }
}