import 'package:flutter/material.dart';
//import 'package:email_validator/email_validator.dart';

/* class CollaboratorsSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collaborators Search',
      home: CollaboratorSearchView(),
      theme: ThemeData(
        primaryColor: Colors.green[800],
        accentColor: Colors.black,
      ),
    );
  }
} */

class CollaboratorSearchView extends StatefulWidget {
  @override
  _CollaboratorSearchViewState createState() => _CollaboratorSearchViewState();
}

class _CollaboratorSearchViewState extends State<CollaboratorSearchView> {
  final nameController = TextEditingController();
  List<Color> _headerColor = [Colors.black, Colors.teal[800]];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          //Inicio Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: _headerColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            width: double.infinity,
            height: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.minimize,
                    color: Colors.white,
                    size: 65.0,
                  ),
                  margin: EdgeInsets.only(left: 10),
                ),
                Container(
                  child: Text(
                    'Listado de Colaboradores',
                    style: TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  margin: EdgeInsets.only(left: 18, bottom: 15),
                ),
              ],
            ),
          ),
          //Fin del Header
          //Inicio Busqueda
          Container(
            margin: EdgeInsets.fromLTRB(15, 30, 15, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Buscar por Nombre',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
                Container(
                  //alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 5),
                  // Agregando el DropdownButton para hacer filtros de busqueda
                  child: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'nombre',
                        child: Text('Nombre'),
                      ),
                      PopupMenuItem(
                        value: 'categoria',
                        child: Text('Categoria'),
                      ),
                    ],
                    icon: Icon(
                      Icons.more_vert,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Fin de Busqueda
          //Inicio de Table
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              border: Border.all(
                color: Colors.black26,
                width: 2,
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('Profile'),
                    ),
                    DataColumn(
                      label: Text('Nombre'),
                    ),
                    DataColumn(
                      label: Text('Fecha'),
                    ),
                    DataColumn(
                      label: Text('Hora Entrada'),
                    ),
                    DataColumn(
                      label: Text('Hora Salida'),
                    ),
                  ],
                  rows: [
                    DataRow(cells: <DataCell>[
                      DataCell(
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: IconButton(
                            icon: Icon(Icons.photo),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      DataCell(Text('Hamilton')),
                      DataCell(
                        Text('Abril'),
                      ),
                      DataCell(Text('8AM')),
                      DataCell(Text('5PM')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: IconButton(
                            icon: Icon(Icons.photo),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      DataCell(Text('Edwin')),
                      DataCell(
                        Text('Mayo'),
                      ),
                      DataCell(Text('7AM')),
                      DataCell(Text('4PM')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: IconButton(
                            icon: Icon(Icons.photo),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      DataCell(Text('Sotelo')),
                      DataCell(
                        Text('Junio'),
                      ),
                      DataCell(Text('6AM')),
                      DataCell(Text('3PM')),
                    ]),
                  ].toList()),
            ),
          ),
          //Fin de Table
        ],
      ),
    );
  }
}
