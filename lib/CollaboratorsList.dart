import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:email_validator/email_validator.dart';

class CollaboratorsList extends StatefulWidget {
  @override
  _CollaboratorsListState createState() => _CollaboratorsListState();
}

class _CollaboratorsListState extends State<CollaboratorsList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collaborators List',
      home: CollaboratorsListView(),
      theme: ThemeData(
        primaryColor: Colors.green[800],
        accentColor: Colors.black,
      ),
    );
  }
}

class CollaboratorsListView extends StatefulWidget {
  @override
  _CollaboratorsListViewState createState() => _CollaboratorsListViewState();
}

class _CollaboratorsListViewState extends State<CollaboratorsListView> {
  String _date = "Inicio";
  String _date2 = "Final";
  bool _valid = true;
  // Textfields Controller
  final nameController = TextEditingController();
  final lasNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final payHoursController = TextEditingController();
  final daysController = TextEditingController();
  final hoursController = TextEditingController();
  final payTotalController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //Colores del Header
    List<Color> _headerColores = [Colors.black, Colors.teal[800]];
    return Scaffold(
      body: ListView(
        children: <Widget>[
          //Header
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: _headerColores,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 30, bottom: 15),
              alignment: Alignment.bottomLeft,
              child: Text(
                '@NombredeColaborador',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          //Fin del Header
          //Inicio Primera parte del cuerpo de la pantalla
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  /* image: DecorationImage(
                      //image: AssetImage(""),
                      fit: BoxFit.cover,
                    ), */
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ),
              ),
            ],
          ),
          //Fin Primera parte del cuerpo de la pantalla
          //Inicio de la segunda parte de la pantalla Creacion de Textfield
          Container(
            margin: EdgeInsets.fromLTRB(40, 5, 40, 15),
            child: Column(
              children: <Widget>[
                Container(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: lasNameController,
                    decoration: InputDecoration(
                      labelText: 'Apellido',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        errorText:
                            !_valid ? 'Formato de Email Incorrecto' : null),
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
                      labelText: 'Telefono',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: payHoursController,
                    decoration: InputDecoration(
                      labelText: 'Pago por Hora',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: daysController,
                    decoration: InputDecoration(
                      labelText: 'Total de dias Trabajados',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: hoursController,
                    decoration: InputDecoration(
                      labelText: 'Total de Horas Trabajadas',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: payTotalController,
                    decoration: InputDecoration(
                      labelText: 'Total de Pago por Horas',
                      contentPadding: EdgeInsets.fromLTRB(20, 15, 0, 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Final de la segunda parte de la pantalla Creacion de Textfield
          //Inicio de la Tercera parte de la Pantalla Contenedores de Fecha
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 8),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    'Seleccionar un rango de fechas',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2003, 1, 1),
                            maxTime: DateTime(2222, 12, 31), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                          _date = '${date.day}/${date.month}/${date.year}';
                          setState(() {});
                        }, currentTime: DateTime.now(), locale: LocaleType.es);
                      },
                      child: Text(
                        '$_date',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2003, 1, 1),
                            maxTime: DateTime(2222, 12, 31), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                          _date2 = '${date.day}/${date.month}/${date.year}';
                          setState(() {});
                        }, currentTime: DateTime.now(), locale: LocaleType.es);
                      },
                      child: Text(
                        '$_date2',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.fromLTRB(40, 0, 40, 15),
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15.0,
                        ),
                      ]),
                  child: RaisedButton(
                    color: Colors.orange,
                    padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Georgia',
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          //Fin de la Tercera parte de la Pantalla Contenedores de Fecha
          //Inicio de la Ultima parte de la Pantalla DataTable con scroll
          //Fin de la Ultima parte de la Pantalla DataTable con scroll
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
