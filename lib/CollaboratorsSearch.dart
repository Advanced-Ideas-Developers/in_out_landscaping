import 'package:flutter/material.dart';
import 'RegisterCollaborator.dart';
import 'Collaborator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'HTTP/API.dart';
import 'Classes/Globals.dart' as globals;

class CollaboratorSearchView extends StatefulWidget {
  @override
  _CollaboratorSearchViewState createState() => _CollaboratorSearchViewState();
}

class _CollaboratorSearchViewState extends State<CollaboratorSearchView> {
  final scrollController = ScrollController();

  //Variables para los rangos de fechas
  String _initDate = "Inicio";
  String _finalDate = "Final";
  bool _valid = true;
  String filtro = 'Nombre';
  int employeeID;

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
    _chargeEmployees();
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
                    () {
                      if (globals.role == '0') {
                        return Container(
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
                                              RegisterCollaboratorView()))
                                  .then((value) {
                                _chargeEmployees();
                              });
                            },
                          ),
                          margin: EdgeInsets.only(bottom: 9, right: 15),
                        );
                      } else {
                        return SizedBox(
                          height: 60,
                        );
                      }
                    }()
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
                      if (searchController.text.trim().isEmpty) {
                        _chargeEmployees();
                      } else if (filtro == 'Nombre') {
                        await API
                            .getEmployeesbyName(searchController.text)
                            .then((response) {
                          setState(() {
                            employees = response;
                          });
                        });
                      } else if (filtro == 'Categoría') {
                        print('entre');
                        await API
                            .getEmployeesbyCategory(searchController.text)
                            .then((response) {
                          setState(() {
                            employees = response;
                          });
                        });
                      }
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
                      // Esto lo dejo comentado por el momento ya que no se va a 
                      // buscar por categoría
                      // PopupMenuItem(
                      //   value: 'Categoría',
                      //   child: Text('Categoría'),
                      // ),
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
                                    DataCell(() {
                                      if (globals.role == '0') {
                                        return Row(
                                          children: <Widget>[
                                            IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CollaboratorView(
                                                          collaborator:
                                                              employee,
                                                        ))).then((value) {
                                              _chargeEmployees();
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete
                                          ),
                                          onPressed: (){
                                            _confirmDialog({'id':employee['id'],'state':0});
                                          },
                                        )
                                          ],
                                        );
                                      }else{
                                        return Text('');
                                      }
                                    }()),
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
                                      employeeID = employee['id'];
                                      daysController.clear();
                                      hoursController.clear();
                                      payTotalController.clear();
                                      setState(() {
                                        _initDate = 'Inicio';
                                        _finalDate = 'Final';
                                      });
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
                                      employeeID = employee['id'];
                                      daysController.clear();
                                      hoursController.clear();
                                      payTotalController.clear();
                                      setState(() {
                                        _initDate = 'Inicio';
                                        _finalDate = 'Final';
                                      });
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
                                      employeeID = employee['id'];
                                      daysController.clear();
                                      hoursController.clear();
                                      payTotalController.clear();
                                      setState(() {
                                        _initDate = 'Inicio';
                                        _finalDate = 'Final';
                                      });
                                    }),
                                    DataCell(
                                        Text(employee['category'] == null
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
                                      employeeID = employee['id'];
                                      daysController.clear();
                                      hoursController.clear();
                                      payTotalController.clear();
                                      setState(() {
                                        _initDate = 'Inicio';
                                        _finalDate = 'Final';
                                      });
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
              )
            ],
          ),
          Container(
                child:Text(
                  "(estos campos no deben ser llenados)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
                padding: EdgeInsets.only(
                    bottom:27.0
                  ),
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                    enabled: false,
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
                          _initDate = '${date.year}-${date.month}-${date.day}';
                          setState(() {});
                        }, currentTime: DateTime.now(), locale: LocaleType.es);
                      },
                      child: Text(
                        '$_initDate',
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
                          _finalDate = '${date.year}-${date.month}-${date.day}';
                          setState(() {});
                        }, currentTime: DateTime.now(), locale: LocaleType.es);
                      },
                      child: Text(
                        '$_finalDate',
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
                    onPressed: () async {
                      var employeePay;
                      var totalHours = 0;
                      var totalDays;
                      var totalPay = 0.0;

                      if(_initDate == 'Inicio'){
                        _dialog('Debe seleccionar una hora Inicial');
                        return;
                      }

                      if(_finalDate == 'Final'){
                        _dialog('Debe seleccionar una hora Final');
                        return;
                      }

                      await API.getHoursEmployee(employeeID, _initDate, _finalDate).then((response){
                        employeePay = response;
                      });

                      if(employeePay.isEmpty){
                        _dialog('No se encontraron registros para el trabajador en estas fechas');
                        return;
                      }

                      for(int i = 0; i < employeePay.length; i++){
                        totalHours += employeePay[i]['total_horas'];
                        totalPay += employeePay[i]['total_pay'];
                      }

                      //print(employeeID);
                      totalDays = Duration(hours: totalHours).inDays;

                      daysController.text = totalDays.toString();
                      hoursController.text = totalHours.toString();
                      payTotalController.text = totalPay.toString(); 
                    },
                  ),
                ),
              ],
            ),
          ),
          //Fin de la Tercera parte de la Pantalla Contenedores de Fecha
          //Inicio de la Ultima parte de la Pantalla DataTable con scroll
          //Fin de la Ultima parte de la Pantalla DataTable con scroll
          /* Container(
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
          ), */
        ],
      ),
    );
  }

  void _chargeEmployees() {
    API.getEmployees().then((response) {
      setState(() {
        employees = response.where((employee)=>(){
          if(employee['state']==1){
            return true;
          }else{
            return false;
          }
        }()).toList();
      });
    });
  }

  void _confirmDialog(Map employee){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text('Confirmar Eliminación'),
          content: Text('¿Desea eliminar a este Colaborador?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () async {
                await API.updateEmployee(employee).then((response){
                  setState(() {
                    _chargeEmployees();
                  });
                });
                Navigator.of(context).pop();
                _dialog('¡Colaborador eliminado correctamente!');
              },
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
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
