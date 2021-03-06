import 'package:diplomka/Request/AuthConvertJSON.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../global.dart' as global;

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Auth user;
  late int user_id;
  late String token;
  @override
  void disponse(){
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(top: 120, left: MediaQuery.of(context).size.width * 0.07, right: MediaQuery.of(context).size.width * 0.07),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Center(
                heightFactor: 1.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                    margin:const EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.height * 0.5,
                    child: TextFormField(
                      validator: (value) => _validatorEmail(value),
                      controller: email,
                      decoration:const InputDecoration(
                        focusedErrorBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 153, 0, 0),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                               BorderRadius.all(Radius.circular(90.0)),
                          borderSide:  BorderSide(
                            color:  Color(0xFF000000),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius:
                               BorderRadius.all(Radius.circular(90.0)),
                          borderSide:  BorderSide(
                            color: Color.fromARGB(255, 153, 0, 0),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                               BorderRadius.all(Radius.circular(90.0)),
                          borderSide:  BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: '??????????',
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    margin:const EdgeInsets.symmetric(vertical: 20),
                    width: MediaQuery.of(context).size.height * 0.5,
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) => _validatorPassword(value),
                      controller: password,
                      decoration: const InputDecoration(
                        focusedErrorBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 153, 0, 0),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide(
                            color:Color(0xFF000000),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 153, 0, 0),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(90.0)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        hintText: '????????????',
                      ),
                    ),
                  ),
                  ],
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
                    minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width * 0.7, 58)
                    ),
                    shadowColor: MaterialStateProperty.all(const Color.fromRGBO(1, 1, 1, 1)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      // side: BorderSide(color: Colors.red),
                    )),
                    elevation: MaterialStateProperty.all(10),
                    // padding: MaterialStateProperty.all(EdgeInsets.all(20))
                  ),
                  onPressed: (){
                    _validator();
                  },
                  child: Text(
                    '??????????',
                    style: TextStyle(color: Colors.blue[900], fontSize: 20),
                  )
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/register_page');
              },
              child: Text('???????????????????????????????? ?????????? ??????????????', style: TextStyle(fontSize: 17, color: Colors.blue[800]),),
            )
          ],
        ),
      ),
    );
  }

  void _validator() {
    if (_formKey.currentState!.validate()) {
      loadData(email.text, password.text);
    }
  }

  String? _validatorEmail(String? value){
    if(value!.isEmpty) {
      return '?????????????? ???????? ??????????';
    } else if(!email.text.contains('@')) {
      return '???????????????????? ???????????? ??????????: adres@mail.ru';
    } else{
      return null;
    }
  }

  String? _validatorPassword(String? value){
    if(value!.isEmpty) {
      return '?????????????? ?????? ????????????';
    } else if(value.length < 8) {
      return '???????????? ???????????? ???????? ???????????? ?????? ?????????? 8 ????????????????';
    } else{
      return null;
    }
  }

  Future<Auth> loadData(email,password) async {
    final response = await http.post(
        Uri.parse('http://didpisdp.beget.tech/api/login'),
        body: {
          "email": email,
          'password': password,
        },
        headers: {'Accept':'application/json'}
    );
    if (response.statusCode == 200) {
      user = Auth.fromJson(json.decode(response.body));
      global.email = email;
      global.password = password;
      global.token = user.token;
      global.user_id = user.user_id;
      global.type = user.type;
      Navigator.pushNamed(context, '/menu_page');
      return user;
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}