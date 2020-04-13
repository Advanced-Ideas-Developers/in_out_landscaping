import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.green]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(4, 50, 0, 10),
                    child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Atrás',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, bottom: 20),
                    child: Text(
                      'Hola @nombreDeUsuario',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Buscar',
                        contentPadding: EdgeInsets.zero,
                        labelStyle: TextStyle(height: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  /* Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: DropdownButton(
                      hint: Text(
                        'Filtro',
                        style: TextStyle(height: 0),
                      ),
                      icon: Icon(Icons.menu),
                      iconSize: 30,
                      //underline: Container(),

                      items: [
                        DropdownMenuItem(
                          value: 'user',
                          child: Text('Usuario'),
                        ),
                        DropdownMenuItem(
                          value: 'userType',
                          child: Text('Tipo de Usuario'),
                        ),
                      ],
                      onChanged: (value) {
                        print("value: $value");
                      },
                    ),
                  ), */
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'user',
                          child: Text('Usuario'),
                        ),
                        PopupMenuItem(
                          value: 'userType',
                          child: Text('Tipo de Usuario'),
                        ),
                      ],
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                      tooltip: 'Filtro',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: FlatButton(
                      //padding: EdgeInsets.all(10),
                      child: Icon(Icons.search),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 250,
              child: ListView(
                shrinkWrap: true,

                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Usuario', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                        DataColumn(label: Text('Contraseña', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                        DataColumn(label: Text('Tipo de Usuario', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('hamiltong98')),
                          DataCell(Text('1234567')),
                          DataCell(Text('admin')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('marlons67')),
                          DataCell(Text('abcdef')),
                          DataCell(Text('admin')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('edwinv78')),
                          DataCell(Text('sape.com')),
                          DataCell(Text('digitador')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('franciscos87')),
                          DataCell(Text('xyfsa.98')),
                          DataCell(Text('contador')),
                        ]),
                      ],

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
