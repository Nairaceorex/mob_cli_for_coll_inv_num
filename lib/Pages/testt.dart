import 'package:flutter/material.dart';
import '../api/nw_api.dart';
import 'list_news.dart';
import 'alert_dialog.dart';

class RegPage extends StatefulWidget {
  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final email = TextEditingController();
  final nickname = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();

  void switchListNews(BuildContext ctx, NW_API api) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ListNewsPage(api: api);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/logo/лого.png'),
                          width: 75,
                          height: 75,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 25, right: 25, left: 25),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'NEWS',
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                'COMM',
                                style: TextStyle(color: Colors.blue, fontSize: 20),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    TextField(
                      onTap: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(labelText: 'Эл. почта'),
                      controller: email,
                    ),
                    TextField(
                      onTap: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(labelText: 'Псевдоним'),
                      controller: nickname,
                    ),
                    TextField(
                      obscureText: true,
                      onTap: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(labelText: 'Пароль'),
                      controller: password,
                    ),
                    TextField(
                      obscureText: true,
                      onTap: () => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(labelText: 'Подтвердите пароль'),
                      controller: passwordConfirm,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFCFCFCF))),
                        child: Text(
                          'Зарегистрироваться',
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        ),
                        onPressed: () async {
                          if (this.password.text == this.passwordConfirm.text) {
                            NW_API api = NW_API();
                            int result = await api.reg(this.email.text,
                                this.nickname.text, this.password.text);
                            if (result == 0) {
                              var result = showAlertDialog(context, 'Поздравляем',
                                  'Вы успешно прошли регистрацию');
                            } else {
                              String text = 'Неизвестная ошибка';
                              if (result == 3)
                                text = 'Аккаунт с таким псевдонимом уже существует';
                              if (result == 4)
                                text = 'Аккаунт с такой эл. почтой уже существует';
                              showAlertDialog(context, 'Ошибка', text);
                            }
                          } else {
                            showAlertDialog(
                              context,
                              "Ошибка",
                              "Пароли из полей 'Пароль' и 'Подтвердите пароль' не совпадают",
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
