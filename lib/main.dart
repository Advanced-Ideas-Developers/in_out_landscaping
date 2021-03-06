import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'HomePage.dart';
import 'HTTP/API.dart';
import 'Classes/Globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );

  runApp(InOutLandScaping()); //Originalmente aqui  estaba InOutLandScaping()
}

class InOutLandScaping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return MaterialApp(
      title: 'In Out Landscaping',
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.teal[800],
          accentColor: Colors.black,
          tabBarTheme: TabBarTheme(
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 12),
              unselectedLabelStyle: TextStyle(fontSize: 11)),
          fontFamily: 'Montserrat'),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Construcción del Textfield de Usuario
    final txtUsername = TextField(
      autofocus: false,
      controller: usernameController,
      decoration: InputDecoration(
          labelText: 'Nombre de Usuario', contentPadding: EdgeInsets.all(8)),
      textInputAction: TextInputAction.next,
      onSubmitted: (value) {
        FocusScope.of(context).nextFocus();
      },
    );

    //Construcción del Textfield de Contraseña
    final txtPassword = TextField(
      autocorrect: false,
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Contraseña', contentPadding: EdgeInsets.all(8)),
    );

    return Scaffold(
        body: Stack(
      children: <Widget>[
        ListView(
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
                        fontWeight: FontWeight.bold,
                      ),
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
                    colors: [Colors.black, Colors.teal[800]],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft),
              ),
            ),
            Container(
              width: double.infinity,
              //height: MediaQuery.of(context).size.height * 0.47,
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
                          minWidth: 150,
                          child: Builder(
                            builder: (context) => RaisedButton(
                              child: Text(
                                'Acceder',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              onPressed: () => _login(context),
                              color: Colors.orangeAccent,
                              elevation: 0,
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          child: Text(
            'v 1.0.3',
            style: TextStyle(fontFamily: 'Roboto'),
          ),
          bottom: 10,
          right: 10,
        ),
      ],
    ));
  }

  void _login(context) async {
    //Variable del Usuario a Entrar
    var user;

    await API.getUser(usernameController.text).then((response) {
      if (response?.isEmpty ?? true) {
        user = null;
      } else {
        user = response[0];
      }
    });

    if (user != null &&
        passwordController != null &&
        passwordController.text == user['password'] &&
        user['state'] == true) {
      globals.isLoggedIn = true;
      globals.userLog = user['username'];
      globals.role = user['role'];
      globals.category = user['employee']['categories_id'];

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      usernameController.clear();
      passwordController.clear();
    } else {
      final snackBar = SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.redAccent,
            ),
            Text('Usuario y/o Contraseña incorrecta')
          ],
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
          textColor: Colors.orange,
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
