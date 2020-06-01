import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'HTTP/API.dart';
import 'package:intl/intl.dart';
import 'Classes/Globals.dart' as globals;

class AssistanceView extends StatefulWidget {
  @override
  _AssistanceViewState createState() => _AssistanceViewState();
}

class _AssistanceViewState extends State<AssistanceView> {
  /* DateTime _dateTime; */
  var now = DateTime.now();
  /* String _time = "Entrada";
  String _timeTwo = "Salida"; */
  List employee;
  List assistance;
  final searchController = TextEditingController();

  @override
  void initState() {
    API.getEmployees().then((response) {
      if (!mounted) return;
      setState(() {
        employee = response;
      });
    });
    _chargeAssistance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      /* Container(
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
                      ), */
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
                        margin: EdgeInsets.only(right: 15),
                        child: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            if (searchController.text.trim().isEmpty) {
                              _chargeAssistance();
                            } else {
                              _chargeAssistanceSearch(searchController.text);
                            }
                          },
                        ),
                      ),
                      /* Container(
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
                      ), */
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 10, left: 20),
                  child: Text('Fecha: ${now.day}/${now.month}/${now.year}', style: TextStyle(fontSize: 15)),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      () {
                        if (globals.role == '0') {
                          return FlatButton(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.schedule),
                                ),
                                Text('Inicio de Jornada')
                              ],
                            ),
                            textColor: Colors.white,
                            color: Colors.greenAccent[700],
                            onPressed: (assistance?.isEmpty ?? false)
                                ? () async {
                                    setState(() {
                                      assistance = null;
                                    });
                                    var inout = {};

                                    for (int i = 0; i < employee.length; i++) {
                                      if (employee[i]['state'] == 1) {
                                        inout['employees_id'] =
                                            employee[i]['id'];
                                        inout['created_at'] = 
                                            now.toIso8601String();
                                        await API
                                            .addAssistance(inout)
                                            .then((response) {});
                                      }
                                    }
                                    _chargeAssistance();
                                    //inout['state'] = true;
                                  }
                                : null,
                            disabledColor: Colors.greenAccent[100],
                          );
                        }else{
                          return Container();
                        }
                      }()
                      /* FlatButton(
                        child: Text('Fin de Jornada'),
                        color: Colors.redAccent[700],
                        textColor: Colors.white,
                        onPressed: () {},
                      ), */
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
                            if (assistance == null) {
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
                                            DataCell(() {
                                              if (assis['employee'] == null) {
                                                return Text('');
                                              }
                                              return Text(
                                                  assis['employee']['names']);
                                            }()),
                                            DataCell(
                                              FlatButton(
                                                color: Colors.greenAccent[700],
                                                textColor: Colors.white,
                                                child: Text(
                                                  () {
                                                    if (assis[
                                                            'check_in_time'] ==
                                                        null) {
                                                      return 'Entrada';
                                                    } else {
                                                      var time = DateFormat(
                                                              'h:mm a')
                                                          .format(DateTime
                                                              .parse(assis[
                                                                  'check_in_time']));
                                                      return '$time';
                                                    }
                                                  }(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                onPressed:
                                                    assis['check_in_time'] ==
                                                            null
                                                        ? () async {
                                                            TimeOfDay time =
                                                            await showTimePicker(
                                                              context: context,
                                                              initialTime: TimeOfDay.now(),
                                                            );

                                                            DateTime dateS = DateTime(now.year, now.month, now.day, time.hour, time.minute);

                                                            var inout = {
                                                              'id': assis['id'],
                                                              'employees_id': assis[
                                                                  'employees_id'],
                                                              'check_in_time': dateS
                                                                  .toIso8601String()
                                                            };

                                                            await API
                                                                .updateAssistance(
                                                                    inout)
                                                                .then(
                                                                    (response) {
                                                              if (response) {
                                                                setState(() {
                                                                  _chargeAssistance();
                                                                });
                                                              }
                                                            });
                                                            /* DatePicker.showDatePicker(
                                                      context,
                                                      showTitleActions: true,
                                                      onConfirm: (time) {
                                                    print('confirm $time');
                                                    _time =
                                                        '${time.hour} : ${time.minute} ';
                                                    setState(() {});
                                                  },
                                                      currentTime:
                                                          DateTime.now(),
                                                      locale: LocaleType.es); */
                                                            /* setState(() {
                                                    if (assis[
                                                            'check_in_time'] ==
                                                        null) {
                                                      return _time = 'Entrada';
                                                    }
                                                    return assis[
                                                        'check_in_time'];
                                                  }); */
                                                          }
                                                        : null,
                                              ),
                                            ),
                                            DataCell(
                                              FlatButton(
                                                color: Colors.redAccent[700],
                                                textColor: Colors.white,
                                                child: Text(
                                                  () {
                                                    if (assis[
                                                            'departure_time'] ==
                                                        null) {
                                                      return 'Salida';
                                                    } else {
                                                      var time = DateFormat(
                                                              'h:mm a')
                                                          .format(DateTime
                                                              .parse(assis[
                                                                  'departure_time']));
                                                      return '$time';
                                                    }
                                                  }(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                onPressed: assis[
                                                            'departure_time'] ==
                                                        null
                                                    ? () async {
                                                        if (assis[
                                                                'check_in_time'] ==
                                                            null) {
                                                          _dialog(
                                                              'Primero debe registrar la hora de entrada');
                                                          return;
                                                        }

                                                        TimeOfDay time =
                                                            await showTimePicker(
                                                              context: context,
                                                              initialTime: TimeOfDay.now(),
                                                            );

                                                            DateTime dateS = DateTime(now.year, now.month, now.day, time.hour, time.minute);

                                                        var inout = {
                                                          'id': assis['id'],
                                                          'employees_id': assis[
                                                              'employees_id'],
                                                          'departure_time': dateS
                                                              .toIso8601String()
                                                        };

                                                        await API
                                                            .createOut(inout)
                                                            .then((response) {
                                                          if (response) {
                                                            setState(() {
                                                              _chargeAssistance();
                                                            });
                                                          }
                                                        });
                                                        /* DatePicker.showDatePicker(
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
                                                  setState(() {}); */
                                                      }
                                                    : null,
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

  void _chargeAssistance() {
    API.getAssistance().then((response) {
      if (!mounted) return;
      setState(() {
        assistance = response
            .where((assis) => () {
                  String formattedNow = DateFormat('yyyy-MM-dd').format(now);
                  String formattedAssis = DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(assis['created_at']));
                  //print(formattedNow + ' ' + formattedAssis);
                  if (formattedAssis == formattedNow) {
                    if(globals.role == '0'){
                      return true;
                    }else if(globals.category == assis['employee']['categories_id']){
                      return true;
                    }else{
                      return false;
                    }
                  } else {
                    return false;
                  }
                }())
            .toList();
      });
    });
  }

  void _chargeAssistanceSearch(String nombre) {
    API.getAssistanceSearch(nombre).then((response) {
      if (!mounted) return;
      setState(() {
        assistance = response
            .where((assis) => () {
                  String formattedNow = DateFormat('yyyy-MM-dd').format(now);
                  String formattedAssis = DateFormat('yyyy-MM-dd')
                      .format(DateTime.parse(assis['created_at']));
                  //print(formattedNow + ' ' + formattedAssis);
                  if (formattedAssis == formattedNow && globals.role == '0') {
                    if(globals.role == '0'){
                      return true;
                    }else if(globals.category == assis['employee']['categories_id']){
                      return true;
                    }else{
                      return false;
                    }
                  } else {
                    return false;
                  }
                }())
            .toList();
      });
    });
  }

  void _dialog(String message) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              title: Center(
                child: Text(
                  '¡Información!',
                ),
              ),
              content: Container(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '$message',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.info,
                      color: Colors.blue[300],
                      size: 35,
                    )
                  ],
                ),
              ));
        });
  }
}
