import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/MainPage.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/Reg_Auth.dart';




class LandingPage extends StatelessWidget{

  LandingPage({Key? key, required this.isLoggedIn}) : super(key: key);

  final bool isLoggedIn;


  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? MainPage() : RegPage();
  }
}