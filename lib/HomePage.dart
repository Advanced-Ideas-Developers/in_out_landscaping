import 'package:flutter/material.dart';
import 'AddUserPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: <Widget>[
              Center(
                heightFactor: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.teal[800]]),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.minimize,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35, top: 15),
                            child: Text(
                              'Bienvenido @usuario',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35, top: 14),
                            child: Text(
                              'Epic Landscaping',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        child: Row(
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 30,
                              child: FlatButton(
                                child: Icon(
                                  Icons.person_add,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddUserPage()));
                                },
                              ),
                            ),
                            ButtonTheme(
                              minWidth: 30,
                              child: FlatButton(
                                child: Icon(
                                  Icons.exit_to_app,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                        right: 0,
                        top: 30,
                      ),
                    ],
                  ),
                ),
              ),
              ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.green]),
                    ),
                  ),
                ],
              ),
              ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.green]),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            child: TabBar(
              indicator: BoxDecoration(
                  color: Colors.black12,
                  border: Border(
                      bottom:
                          BorderSide(color: Colors.orangeAccent, width: 4))),
              tabs: <Widget>[
                Container(
                  height: 60,
                  child: Tab(
                    icon: Icon(
                      Icons.home,
                    ),
                    text: 'Inicio',
                  ),
                ),
                Container(
                  height: 60,
                  child: Tab(
                    icon: Icon(
                      Icons.date_range,
                    ),
                    text: 'Asistencias',
                  ),
                ),
                Container(
                  height: 60,
                  child: Tab(
                    icon: Icon(
                      Icons.format_list_bulleted,
                    ),
                    text: 'Colaboradores',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
