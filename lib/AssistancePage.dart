import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'HTTP/API.dart';
/* 
class AssistancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assistance',
      home: AssistanceView(), //Vista de Asistencias
      theme: ThemeData(
        primaryColor: Colors.green[800],
        accentColor: Colors.black,
      ),
    );
  }
} */

class AssistanceView extends StatefulWidget {
  @override
  _AssistanceViewState createState() => _AssistanceViewState();
}

class _AssistanceViewState extends State<AssistanceView> {
  DateTime _dateTime;
  String _time = "Entrada";
  String _timeTwo = "Salida";
  List employee;
  List assistance;
  @override
  void initState() {
    API.getEmployees().then((response) {
      setState(() {
        employee = response;
      });
    });
    API.getAssistance().then((response){
      setState(() {
        assistance = response;
        print(assistance);
      });
    });
    super.initState();
  }

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
                  margin: EdgeInsets.only(top: 20, left: 18, bottom: 15),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text('Inicio de Jornada'),
                        textColor: Colors.white,
                        color: Colors.greenAccent[700],
                        onPressed: () async{
                          var inout = {};
                          for (int i = 0;i<employee.length;i++) {
                             inout['employees_id'] = employee[i]['id'];
                          }
                          //inout['state'] = true;
                          await API.addAssistance(inout).then((response){});
                        },
                      ),
                      FlatButton(
                        child: Text('Fin de Jornada'),
                        color: Colors.redAccent[700],
                        textColor: Colors.white,
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                ),
                // Pantalla final
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 15),
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
                          child: () {
                            if (employee == null) {
                              return Center(
                                widthFactor: 10,
                                heightFactor: 8,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.teal[800]),
                                ),
                              );
                            } else {
                              return DataTable(
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
                                  /* DataColumn(
                                label: Text('Confirmar'),
                              ), */
                                ],
                                rows: assistance
                                    .map(
                                      ((assis) => DataRow(cells: [
                                            DataCell( () {
                                              if(assis['employee'] == null){
                                                return Text('');
                                              }
                                              return Text(assis['employee']['names']);
                                              
                                            }()),
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
                                                  DatePicker.showDatePicker(
                                                      context,
                                                      showTitleActions: true,
                                                      onConfirm: (time) {
                                                    print('confirm $time');
                                                    _time = '${time.hour} : ${time.minute} ';
                                                    setState(() {});
                                                  },
                                                      currentTime:
                                                          DateTime.now(),
                                                      locale: LocaleType.es);
                                                  setState(() {
                                                    if(assis['check_in_time'] == null){
                                                        return _time = 'Entrada';
                                                      }
                                                      return assis['check_in_time'];
                                                  });
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
                                                  DatePicker.showDatePicker(
                                                      context,
                                                      showTitleActions: true,
                                                      onConfirm: (time) {
                                                    print('confirm $time');
                                                    _timeTwo =
                                                        '${time.hour} : ${time.minute}';
                                                    setState(() {});
                                                  },
                                                      currentTime:
                                                          DateTime.now(),
                                                      locale: LocaleType.es);
                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ])),
                                    )
                                    .toList(),
                              );
                            }
                          }()),
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
