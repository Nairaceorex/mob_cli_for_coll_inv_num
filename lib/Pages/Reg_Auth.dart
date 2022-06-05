import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mob_cli_for_coll_inv_num/Classes/Classes.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/LandingPage.dart';
import 'package:mob_cli_for_coll_inv_num/Pages/MainPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';
import 'package:mob_cli_for_coll_inv_num/Widgets/Companies_List.dart';

class RegPage extends StatefulWidget {
  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final _emailController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _companyController = TextEditingController();

  String? _email;
  String? _password;
  String? _nickname;
  String? _company;

  bool _emailerror = false;
  bool _passworderror = false;
  bool _nicknameerror = false;
  bool _companyerror = false;

  InvApi api_comp = InvApi();
  late Future<List<Company>> futureCompany;

  @override
  void initState() {
    _emailController.text="";
    _nicknameController.text="";
    _passwordController.text="";
    super.initState();
    futureCompany = api_comp.get_companies();
  }

  bool showLogin = false;

  @override
  Widget build(BuildContext context) {

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure, bool _currenterror){
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(

          controller: controller,
          obscureText: obscure,
          cursorColor: Colors.white,

          /*inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'[/\\]')),
          ],*/

          style: TextStyle(fontSize: 20,color: Colors.white),
          decoration: InputDecoration(
              errorText: _currenterror? "Введите правильные данные":null,
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 30),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white,),
                  child: icon,
                ),

              )
          ),
        ),
      );
    }

    Widget _button(String text, void func()){
      return ElevatedButton(
        onPressed: (){
          if(_emailController.text.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)){
            setState(() {
              _emailerror=true;
            });
          }else{
            setState(() {
              _emailerror=false;
            });
          }
          if(_nicknameController.text.isEmpty || !RegExp(r'^[а-я  А-Я]+$').hasMatch(_nicknameController.text)){
            setState(() {
              _nicknameerror=true;
            });
          }else{
            setState(() {
              _nicknameerror=false;
            });
          }
          if(_passwordController.text.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(_passwordController.text)){
            setState(() {
              _passworderror=true;
            });
          }else{
            setState(() {
              _passworderror=false;
            });
          }
          if(_company!.isEmpty){
            Fluttertoast.showToast(
                msg: "Выберите компанию",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          print(_passworderror);
          print(_nicknameerror);
          print(_emailerror);
          print(_company);
          //_nicknameController.text.isEmpty || !RegExp(r'^[а-я А-Я]+$').hasMatch(_nicknameController.text) ||
             // _passwordController.text.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(_nicknameController.text)
          if(_passworderror == false && _nicknameerror == false && _emailerror == false && _company!.isNotEmpty){
            func();
          }

        },
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: Colors.pinkAccent, // background
          onPrimary: Colors.white, // foreground
        ),
      );
    }

    Widget _form(String label, void func()){
      return Container(
        child: Column(
          children: <Widget>[
            (
                showLogin ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, top: 10),
                      child: _input(Icon(Icons.email),"Почта", _emailController,false,_emailerror),

                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.lock),"Пароль", _passwordController,true,_passworderror),

                    ),

                    SizedBox(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20
                      ),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: _button(label,func),
                      ),
                    )
                  ],
                )
                : Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, top: 10),
                      child: _input(Icon(Icons.email),"Почта", _emailController,false,_emailerror),

                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.lock),"Пароль", _passwordController,true,_passworderror),

                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.account_circle),"Имя", _nicknameController,false,_nicknameerror),

                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 50,
                        width: 181,
                        child: FutureBuilder<List<Company>>(
                          future: futureCompany,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              //print(snapshot.data);
                              return Text("Потеряно соединение",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.red
                              ),);
                            } else if (snapshot.hasData) {

                              return DropdownButton<String>(
                                  hint: Text('Компания',style: TextStyle(color: Colors.white,fontSize: 21),),
                                  value: _company,
                                  elevation: 16,
                                  //style: TextStyle(color: Colors.bl,),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.red,
                                  ),
                                  items: snapshot.data!.map((item)=>
                                      DropdownMenuItem<String>(
                                        child: Text(item.name),
                                        value: item.id.toString(),
                                      )).toList(),
                                  //onChanged: widget.onChanged as void Function(String?),
                                  onChanged: (val){
                                    setState(() {
                                      _company=val;
                                    });
                                  });
                            } else if (snapshot.hasError) {
                              return Text(
                                  '${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                      //child: _input(Icon(Icons.account_balance_sharp),"Company", _companyController,false),

                    ),

                    SizedBox(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20
                      ),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: _button(label,func),
                      ),
                    )
                  ],
                )
            ),

          ],
        ),
      );
    }

    void switchLanding(BuildContext ctx) {
      Navigator.pushAndRemoveUntil(ctx,
          MaterialPageRoute(builder: (_) => LandingPage(isLoggedIn: true)),(route)=>false);

    }

    void _registerButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;
      _nickname = _nicknameController.text;




      if (_email!.isEmpty || _password!.isEmpty || _company!.isEmpty || _nickname!.isEmpty) return;


      InvApi api = InvApi();
      int res = await api.reg(_email!, _nickname!, _password!, int.parse(_company!));

      if (res == 0) {

        InvApi api_auth = InvApi();
        int res_auth = await api_auth.login(_email!, _password!);

        if (res_auth == 0){
          //print('Поздравляем Вы успешно прошли авторизацию');
          Fluttertoast.showToast(
              msg: "Вы успешно прошли регистрацию",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          switchLanding(context);
        }
      }
      if (res == 2 || res == 3 || res == 4) {
        Fluttertoast.showToast(
            msg: "Пользователь с такими данными уже существует",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else{
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _loginButtonAction() async{
      _password = _passwordController.text;
      _email = _emailController.text;

      if (_email!.isEmpty || _password!.isEmpty) return;


      InvApi api_auth = InvApi();
      int res_auth = await api_auth.login(_email!, _password!);

      if (res_auth == 0){
        //print('Поздравляем Вы успешно прошли авторизацию');
        Fluttertoast.showToast(
            msg: "Вы успешно прошли авторизацию",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        switchLanding(context);
      }
      if (res_auth == 1) {
        Fluttertoast.showToast(
            msg: "Такого пользователя не существует",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    }

    Widget _logo(){
      return Padding(
        padding: EdgeInsets.only(top:100),
        child: Container(
          child: Align(
            child: Text(
                "INV",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight:FontWeight.bold,
                    color: Colors.white
                )
            ),
          ),
        ),

      );
    }


    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              _logo(),
              (
                  showLogin ? Column(
                      children: <Widget>[
                        _form("Войти",_loginButtonAction),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Text("Регистрация", style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onTap:(){
                              setState((){
                                showLogin = false;

                              });
                            },
                          ),
                        )
                      ]
                  )
                      : Column(
                      children: <Widget>[
                        _form("Зарегистрироваться",_registerButtonAction),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Text("Войти", style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onTap:(){
                              setState((){
                                showLogin = true;
                              });
                            },
                          ),
                        )
                      ]
                  )
              ),


            ],
          ),
        ],
      ),

    );
  }
}
