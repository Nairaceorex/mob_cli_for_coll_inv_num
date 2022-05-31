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

  InvApi api_comp = InvApi();
  late Future<List<Company>> futureCompany;

  @override
  void initState() {
    super.initState();
    futureCompany = api_comp.get_companies();

  }

  bool showLogin = false;

  @override
  Widget build(BuildContext context) {

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(

          controller: controller,
          obscureText: obscure,
          cursorColor: Colors.white,

          style: TextStyle(fontSize: 20,color: Colors.white),
          decoration: InputDecoration(
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
          func();
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
                      child: _input(Icon(Icons.email),"EMAIL", _emailController,false),

                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.lock),"PASSWORD", _passwordController,true),

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
                      child: _input(Icon(Icons.email),"EMAIL", _emailController,false),

                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.lock),"PASSWORD", _passwordController,true),

                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.account_circle),"Name", _nicknameController,false),

                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 200,bottom: 20),
                      child: Container(
                        height: 50,
                        width: 161,
                        child: FutureBuilder<List<Company>>(
                          future: futureCompany,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              //print(snapshot.data);
                              return CircularProgressIndicator();
                            } else if (snapshot.hasData) {

                              return DropdownButton<String>(
                                  hint: Text('Acc'),
                                  value: _company,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
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
        print('Поздравляем Вы успешно прошли регистрацию');

        InvApi api_auth = InvApi();
        int res_auth = await api_auth.login(_email!, _password!);

        if (res_auth == 0){
          print('Поздравляем Вы успешно прошли авторизацию');
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
      if (res == 1) {
        print('Неизвестная ошибка');
      }
      if (res == 2) {
        print('!!!!!!!!!!!!!!!!!!!!!!');
      }
      if (res == 3) {
        print('Аккаунт с таким псевдонимом уже существует');
      }
      if (res == 4) {
        print('Аккаунт с такой эл. почтой уже существует');
      }
      else{
        print('Ошибка');
      }
      if(res == 0){

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
        print('Поздравляем Вы успешно прошли авторизацию');
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
        print('Неизвестная ошибка');
      }
      if (res_auth == 2) {
        print('!!!!!!!!!!!!!!!!!!!!!!');
      }
      if (res_auth == 3) {
        print('Аккаунт с таким псевдонимом уже существует');
      }
      if (res_auth == 4) {
        print('Аккаунт с такой эл. почтой уже существует');
      }
      else{
        print('Ошибка');
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
                        _form("Login",_loginButtonAction),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Text("Register", style: TextStyle(fontSize: 20, color: Colors.white),
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
                        _form("Register",_registerButtonAction),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Text("Register?", style: TextStyle(fontSize: 20, color: Colors.white),
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
