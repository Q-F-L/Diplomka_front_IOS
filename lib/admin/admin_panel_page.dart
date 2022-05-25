import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/menu_page');
                        },
                        child: Image.asset('assets/arrow_back.png')),
                  ),
                  const Expanded(
                    flex: 4,
                    child: Text(
                      'Админ',
                      style: TextStyle(
                          fontSize: 36,
                          color: Color.fromRGBO(32, 86, 146, 1),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                      flex: 1, child: Image.asset('assets/logo_image.png')),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: ListView(
                  children: [
                    Button(
                        context, 'Проекты', "api", "/admin_project_list_page"),
                    Button(context, 'Пользователи', "api",
                        "/admin_user_list_page"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Button(context, text, apiRoute, navigatorRoute) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(top: 140),
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromRGBO(255, 255, 255, 1)),
            minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width * 0.7, 58)),
            shadowColor: MaterialStateProperty.all(Color.fromRGBO(1, 1, 1, 1)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              // side: BorderSide(color: Colors.red),
            )),
            elevation: MaterialStateProperty.all(10),
            // padding: MaterialStateProperty.all(EdgeInsets.all(20))
          ),
          onPressed: () {
            getLocalAdmin(apiRoute);
            Navigator.pushNamed(context, '$navigatorRoute');
          },
          child: Text(
            '$text',
            style: TextStyle(color: Colors.blue[900], fontSize: 20),
          )),
    );
  }

  getLocalAdmin(route) {}
}
