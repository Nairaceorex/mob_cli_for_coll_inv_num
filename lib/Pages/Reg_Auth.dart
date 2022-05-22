import 'package:flutter/material.dart';
import 'package:mob_cli_for_coll_inv_num/Services/inv_api.dart';

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
  var _company;



  bool showLogin = false;

  @override
  Widget build(BuildContext context) {

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
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
          // Переходим к новому маршруту
          /*Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyHomePage();
          }));*/
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
                      //child: Text("Email"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.lock),"PASSWORD", _passwordController,true),
                      //child: Text("Password"),
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
                      //child: Text("Email"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.lock),"PASSWORD", _passwordController,true),
                      //child: Text("Password"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.lock),"Name", _nicknameController,false),
                      //child: Text("Password"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: _input(Icon(Icons.lock),"Company", _companyController,false),
                      //child: Text("Password"),
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
            /*Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: _input(Icon(Icons.email),"EMAIL", _emailController,false),
              //child: Text("Email"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(Icon(Icons.lock),"PASSWORD", _passwordController,true),
              //child: Text("Password"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(Icon(Icons.lock),"Name", _nicknameController,false),
              //child: Text("Password"),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: _input(Icon(Icons.lock),"Company", _companyController,false),
              //child: Text("Password"),
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
            )*/
          ],
        ),
      );
    }

    void _registerButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;
      _nickname = _nicknameController.text;
      _company = _companyController.text;

      if (_email!.isEmpty || _password!.isEmpty || _company!.isEmpty || _nickname!.isEmpty) return;

      //Users? user = await _authService.registerWithEmailPassword(_email!.trim(), _password!.trim());
      InvApi api = InvApi();
      int res = await api.reg(_email!, _nickname!, _password!, 0);
      if (res == 0) {
        print('Поздравляем Вы успешно прошли регистрацию');
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
      /*if(user == null){
        Fluttertoast.showToast(
            msg: "Регистрация не удалась",
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
      }*/
    }

    void _loginButtonAction() async{
      _password = _passwordController.text;
      _email = _emailController.text;

      if (_email!.isEmpty || _password!.isEmpty) return;

      //Users? user = await _authService.signWithEmailPassword(_email!.trim(), _password!.trim());
      InvApi api_log = InvApi();
      int res = await api_log.login(_email!, _password!);

      /*if(user == null){
        Fluttertoast.showToast(
            msg: "Неверный логин или пароль!",
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
      }*/
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
      body: Column(
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
    );
  }
}
