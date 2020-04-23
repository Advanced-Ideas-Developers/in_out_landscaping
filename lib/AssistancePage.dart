import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AssistanceView extends StatefulWidget {
  @override
  _AssistanceViewState createState() => _AssistanceViewState();
}

class _AssistanceViewState extends State<AssistanceView> {
  DateTime _dateTime;
  String _time = "Entrada";
  String _timeTwo = "Salida";
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    List<Color> _coloresHeader = [Colors.black, Colors.teal[800]];
    //String _dropdownValue = '-'; //Variable a utilizar en el dropdown
    // Inico de construccion de TextFields
    final txtBusqueda = TextField(
      controller: searchController,
      decoration: InputDecoration(
        labelText: 'Buscar por Nombre',
        contentPadding: EdgeInsets.all(8.0),
      ),
    );
    //Fin de construccion de Textfields
    return Scaffold(
      body: ListView(
        children: <Widget>[
          //Cabezera de la Page Assistance
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: _coloresHeader,
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
                  margin: EdgeInsets.only(left: 0),
                ),
                Container(
                  child: Text(
                    'Asistencias',
                    style: TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  margin: EdgeInsets.only(top: 20,left: 18, bottom: 15),
                ),
              ],
            ),
          ),
          //Fin de la Cabezera de la Page Assistance
          //Inicio de la Pantalla Media
          Container(
            child: Column(
              children: <Widget>[
                /* Container(
                  margin: EdgeInsets.only(bottom: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.person_add,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ), */
                //Segunda parte de la Pantalla Media
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 27),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.date_range),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2222),
                            ).then((date) {
                              setState(() {
                                _dateTime = date;
                                print(DateTime.now());
                              });
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(10, 5, 10, 7),
                          child: txtBusqueda,
                        ),
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
                // Pantalla final
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(15.0),
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
                  height: 300,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                            columns: <DataColumn>[
                              /* DataColumn(
                                label: Text('Profile'),
                              ), */
                              DataColumn(
                                label: Text('Nombre'),
                              ),
                              DataColumn(
                                label: Text('Hora Entrada'),
                              ),
                              DataColumn(
                                label: Text('Hora Salida'),
                              ),
                              DataColumn(
                                label: Text('Confirmar'),
                              ),
                            ],
                            rows: [
                              DataRow(cells: <DataCell>[
                                /* DataCell(
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.photo),
                                      onPressed: () {},
                                    ),
                                  ),
                                ), */
                                DataCell(Text('Hamilton García')),
                                DataCell(
                                  FlatButton(
                                    color: Colors.greenAccent[700],
                                    textColor: Colors.white,
                                    child: Text(
                                      '$_time',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        print('confirm $time');
                                        _time =
                                            '${time.hour} : ${time.minute} ';
                                        setState(() {});
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                DataCell(
                                  FlatButton(
                                    child: Text(
                                      '$_timeTwo',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    color: Colors.redAccent[700],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        print('confirm $time');
                                        _timeTwo =
                                            '${time.hour} : ${time.minute}';
                                        setState(() {});
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green[400],
                                    ),
                                    onPressed: () {
                                      // Mensaje indicando que se ha agregado correctamente las horas
                                      showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          title: Text(
                                              '¡Hora de Entrada Registrada!'),
                                          children: <Widget>[
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.check_circle,
                                                  size: 50,
                                                ),
                                                color: Colors.green[800],
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                              DataRow(cells: <DataCell>[
                                /* DataCell(
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.photo),
                                      onPressed: () {},
                                    ),
                                  ),
                                ), */
                                DataCell(Text('Wiz')),
                                DataCell(
                                  FlatButton(
                                    color: Colors.greenAccent[700],
                                    textColor: Colors.white,
                                    child: Text(
                                      '$_time',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        print('confirm $time');
                                        _time =
                                            '${time.hour} : ${time.minute} ';
                                        setState(() {});
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                DataCell(
                                  FlatButton(
                                    color: Colors.redAccent[700],
                                    textColor: Colors.white,
                                    child: Text(
                                      '$_timeTwo',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        print('confirm $time');
                                        _timeTwo =
                                            '${time.hour} : ${time.minute}';
                                        setState(() {});
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green[400],
                                    ),
                                    onPressed: () {
                                      // Mensaje indicando que se ha agregado correctamente las horas
                                      showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          title: Text(
                                              '¡Hora de Entrada Registrada!'),
                                          children: <Widget>[
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.check_circle,
                                                  size: 50,
                                                ),
                                                color: Colors.green[800],
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                              DataRow(cells: <DataCell>[
                                /* DataCell(
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.photo),
                                      onPressed: () {},
                                    ),
                                  ),
                                ), */
                                DataCell(Text('Edwin')),
                                DataCell(
                                  FlatButton(
                                    color: Colors.greenAccent[700],
                                    textColor: Colors.white,
                                    child: Text(
                                      '$_time',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        print('confirm $time');
                                        _time =
                                            '${time.hour} : ${time.minute} ';
                                        setState(() {});
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                DataCell(
                                  FlatButton(
                                    color: Colors.redAccent[700],
                                    textColor: Colors.white,
                                    child: Text(
                                      '$_timeTwo',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          onConfirm: (time) {
                                        print('confirm $time');
                                        _timeTwo =
                                            '${time.hour} : ${time.minute}';
                                        setState(() {});
                                      },
                                          currentTime: DateTime.now(),
                                          locale: LocaleType.es);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                DataCell(
                                  IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green[400],
                                    ),
                                    onPressed: () {
                                      // Mensaje indicando que se ha agregado correctamente las horas
                                      showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          title: Text(
                                              '¡Hora de Entrada Registrada!'),
                                          children: <Widget>[
                                            Container(
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.check_circle,
                                                  size: 50,
                                                ),
                                                color: Colors.green[800],
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                            ].toList()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
