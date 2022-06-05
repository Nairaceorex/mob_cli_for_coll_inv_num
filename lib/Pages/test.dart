import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController fname = TextEditingController();
  bool texterror = false;

  @override
  void initState() {
    fname.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text("TextField Validation"),
          backgroundColor: Colors.indigoAccent,
        ),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(children: [
              TextField(
                  controller: fname,
                  decoration: InputDecoration(
                    labelText: "Your Name",
                    errorText: texterror?"Enter Correct Name":null,
                  )
              ),

              ElevatedButton(
                  onPressed: (){
                    if(fname.text.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(fname.text)){
                      setState(() {
                        texterror = true;
                      });
                    }else{
                      setState(() {
                        texterror = false;
                      });
                    }
                  },
                  child: Text("Submit Data")
              )

            ],
            )
        )
    );
  }
}