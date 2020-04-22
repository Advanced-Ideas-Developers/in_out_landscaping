import 'package:flutter/material.dart';
import 'RegisterCollaborator.dart';
import 'Collaborator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'HTTP/API.dart';

class CollaboratorSearchView extends StatefulWidget {
  @override
  _CollaboratorSearchViewState createState() => _CollaboratorSearchViewState();
}

class _CollaboratorSearchViewState extends State<CollaboratorSearchView> {
  final scrollController = ScrollController();

  //Variables para los rangos de fechas
  String _date = "Inicio";
  String _date2 = "Final";
  bool _valid = true;
  String filtro = 'Nombre';

  // Textfields Controller
  final searchController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final payHoursController = TextEditingController();
  final daysController = TextEditingController();
  final hoursController = TextEditingController();
  final payTotalController = TextEditingController();

  //Colores para el Header
  List<Color> _headerColor = [Colors.black, Colors.teal[800]];

  //Lista de Trabajadores
  List employees;
  //Lista de Categorías

  @override
  void initState() {
    API.getEmployees().then((response) {
      setState(() {
        employees = response;
        print(employees);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: scrollController,
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
                  margin: EdgeInsets.only(left: 0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Listado de Colaboradores',
                        style: TextStyle(
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      margin: EdgeInsets.only(
                        left: 18,
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                        ),
                        color: Colors.white,
                        //splashColor: Colors.green,
                        iconSize: 30,
                        tooltip: 'Añadir Colaborador',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterCollaboratorView()));
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 9, right: 15),
                    )
                  ],
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
                    controller: searchController,
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
                    onPressed: () async {
                      API
                          .getEmployeesbyName(searchController.text)
                          .then((response) {
                        setState(() {
                          employees = response;
                        });
                      });
                    },
                  ),
                ),
                Container(
                  //alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 5),
                  // Agregando el DropdownButton para hacer filtros de busqueda
                  child: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'Nombre',
                        child: Text('Nombre'),
                      ),
                      PopupMenuItem(
                        value: 'Categoría',
                        child: Text('Categoría'),
                      ),
                    ],
                    icon: Icon(
                      Icons.more_vert,
                      size: 20,
                    ),
                    onSelected: (value) {
                      setState(() {
                        filtro = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          //Fin de Busqueda
          //Inicio de Table
          Container(
            alignment: Alignment.topCenter,
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
            height: 300,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: () {
                      if (employees == null) {
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
                          columnSpacing: 25,
                          dataRowHeight: 40,
                          columns: <DataColumn>[
                            DataColumn(label: Text('')),
                            DataColumn(
                              label: Text('Nombres'),
                            ),
                            DataColumn(
                              label: Text('Apellidos'),
                            ),
                            DataColumn(
                              label: Text('E-mail'),
                            ),
                            DataColumn(
                              label: Text('Categoría'),
                            ),
                            //DataColumn(label: Text('Pago'))
                          ],
                          rows: employees
                              .map(((employee) => DataRow(cells: [
                                    DataCell(IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CollaboratorView()));
                                      },
                                    )),
                                    DataCell(Text(employee['names']),
                                        onTap: () {
                                      scrollController.animateTo(560,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn);

                                      //Ahora rellenamos los Textfields
                                      nameController.text = employee['names'];
                                      lastNameController.text =
                                          employee['last_names'];
                                      emailController.text = employee['email'];
                                      phoneController.text = employee['phone'];
                                      payHoursController.text =
                                          employee['pay_per_hour'].toString();
                                    }),
                                    DataCell(Text(employee['last_names']),
                                        onTap: () {
                                      scrollController.animateTo(560,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn);

                                      //Ahora rellenamos los Textfields
                                      nameController.text = employee['names'];
                                      lastNameController.text =
                                          employee['last_names'];
                                      emailController.text = employee['email'];
                                      phoneController.text = employee['phone'];
                                      payHoursController.text =
                                          employee['pay_per_hour'].toString();
                                    }),
                                    DataCell(Text(employee['email']),
                                        onTap: () {
                                      scrollController.animateTo(560,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn);

                                      //Ahora rellenamos los Textfields
                                      nameController.text = employee['names'];
                                      lastNameController.text =
                                          employee['last_names'];
                                      emailController.text = employee['email'];
                                      phoneController.text = employee['phone'];
                                      payHoursController.text =
                                          employee['pay_per_hour'].toString();
                                    }),
                                    DataCell(
                                        Text(employee['category'] ==
                                                null
                                            ? ""
                                            : employee['category']
                                                ['category_name']), onTap: () {
                                      scrollController.animateTo(560,
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn);

                                      //Ahora rellenamos los Textfields
                                      nameController.text = employee['names'];
                                      lastNameController.text =
                                          employee['last_names'];
                                      emailController.text = employee['email'];
                                      phoneController.text = employee['phone'];
                                      payHoursController.text =
                                          employee['pay_per_hour'].toString();
                                    }),
                                  ])))
                              .toList(),
                        );
                      }
                    }()),
              ],
            ),
          ),
          //Fin de Table
          //Inicio Primera parte del cuerpo de la pantalla
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  'Cálculo de Salario',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10, bottom: 5),
                child: Hero(
                  tag: 'Dinero',
                  child: CircleAvatar(
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.green,
                      size: 80,
                    ),
                    radius: 60,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                //width: 90,
                //height: 90,
                /* decoration: BoxDecoration(
                  image: DecorationImage(
                      //image: AssetImage(""),
                      fit: BoxFit.cover,
                    ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  border: Border.all(
                    color: Colors.black,
                    width: 3,
                  ),
                ), */
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
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Nombres',
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
                    controller: lastNameController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Apellidos',
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
                    readOnly: true,
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
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Teléfono',
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
                    readOnly: true,
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
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Total de días Trabajados',
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
                    readOnly: true,
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
                    readOnly: true,
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
