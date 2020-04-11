import 'package:flutter/material.dart';

void main() {
  runApp(InOutLandScaping());
}

class InOutLandScaping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de Horas',
      home: Login(),
      theme: ThemeData(
          primaryColor: Colors.greenAccent[700], accentColor: Colors.black),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final txtUsername = TextField(
      decoration: InputDecoration(labelText: 'Nombre de Usuario'),
    );

    final txtPassword = TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Contraseña',
      ),
    );

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.53,
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.minimize,
                    color: Colors.white,
                    size: 65,
                  ),
                  margin: EdgeInsets.only(left: 0, bottom: 15),
                ),
                Container(
                  child: Text(
                    'Bienvenido',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  margin: EdgeInsets.only(left: 15, bottom: 20),
                ),
                Container(
                  child: Text(
                    'Epic Landscaping',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  margin: EdgeInsets.only(left: 15, bottom: 50),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              /* mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, */
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.person_outline,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: txtUsername,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.lock_outline,
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: txtPassword,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.orangeAccent.withOpacity(0.8),
                          blurRadius: 7,
                          offset: Offset(0, 8)),
                    ]),
                    child: ButtonTheme(
                      minWidth: 300,
                      child: RaisedButton(
                        child: Text(
                          'Acceder',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        onPressed: () {},
                        color: Colors.orangeAccent,
                        elevation: 0,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),

      /* Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
            ), */
    );
  }
}
