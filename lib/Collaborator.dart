import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:groovin_widgets/groovin_widgets.dart';

/* class Collaborator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collaborators',
      home: CollaboratorView(),
      theme: ThemeData(
        primaryColor: Colors.green[800],
        accentColor: Colors.black,
      ),
    );
  }
} */

class CollaboratorView extends StatefulWidget {
  @override
  _CollaboratorViewState createState() => _CollaboratorViewState();
}

class _CollaboratorViewState extends State<CollaboratorView> {
  List<Color> _headerColor = [Colors.black, Colors.teal[800]];
  final nameController = TextEditingController();
  final lasNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  bool _valid = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          //Inicio Header
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: _headerColor,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 30, bottom: 15),
              alignment: Alignment.bottomLeft,
              child: Text(
                'Editar Colaborador',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          //Fin del Header
          //Inicio Check
          /* Container(
            alignment: Alignment.centerRight,
            child: IconButton(
                icon: Icon(
              Icons.check,
              size: 30,
              color: Colors.teal,
            )),
          ), */
          //Fin Check
          //Inicio TextFields
          Container(
            margin: EdgeInsets.fromLTRB(40, 17, 40, 15),
            child: Column(
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombres',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (v) {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: lasNameController,
                    decoration: InputDecoration(
                      labelText: 'Apellidos',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (v) {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'E-mail',
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        errorText:
                            !_valid ? 'Formato de E-mail Incorrecto' : null),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (v) {
                      FocusScope.of(context).nextFocus();
                    },
                    onChanged: (value) {
                      bool isvalid =
                          EmailValidator.validate(emailController.text);
                      setState(() {
                        _valid = isvalid;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onSubmitted: (v) {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                (34==35?Text('34'):SizedBox()),
                Container(
                  child: OutlineDropdownButton(
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                    ),
                    items: [],
                    hint: Text('Categoría'),
                  ),
                ),
              ],
            ),
          ),
          //Fin de los TextFileds
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
                        Text('Abril'),
                      ),
                      DataCell(Text('8AM')),
                      DataCell(Text('5PM')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(
                        Text('Mayo'),
                      ),
                      DataCell(Text('7AM')),
                      DataCell(Text('4PM')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(
                        Text('Junio'),
                      ),
                      DataCell(Text('6AM')),
                      DataCell(Text('3PM')),
                    ]),
                  ].toList()),
            ),
          ),
        ],
      ),
    );
  }
}
