import 'dart:io';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:in_out_landscaping/HTTP/API.dart';

class CollaboratorView extends StatefulWidget {
  //Variable que alamacena los datos del colaborador recibido
  final collaborator;

  CollaboratorView({Key key, @required this.collaborator}) : super(key: key);

  @override
  _CollaboratorViewState createState() => _CollaboratorViewState();
}

class _CollaboratorViewState extends State<CollaboratorView> {
  List<Color> _headerColor = [Colors.black, Colors.teal[800]];
  final nameController = TextEditingController();
  final lasNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final pagoController = TextEditingController();
  bool _valid = true;
  int selectedCategory;

  //Lista de Categorías
  List categories;

  //Construcción inicial de la interfaz
  @override
  void initState() {
    setState(() {
      nameController.text = widget.collaborator['names'];
      lasNameController.text = widget.collaborator['last_names'];
      emailController.text = widget.collaborator['email'];
      phoneController.text = widget.collaborator['phone'];
      pagoController.text = widget.collaborator['pay_per_hour'].toString();
    });
    API.getCategories().then((response) {
      setState(() {
        categories = response;
        selectedCategory = widget.collaborator['categories_id'];
      });
    });
    super.initState();
  }

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
            margin: EdgeInsets.fromLTRB(40, 40, 40, 15),
            child: Column(
              children: <Widget>[
                Container(
                  child: TextField(
                    readOnly: true,
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
                    readOnly: true,
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
                Container(
                  child: TextField(
                    controller: pagoController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Pago por Hora',
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
                Container(child: () {
                  if (categories == null) {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.teal[800]),
                    );
                  } else {
                    return OutlineDropdownButton(
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 25),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                      items: categories
                          .map(((category) => DropdownMenuItem(
                                value: category['id'],
                                child: Text(category['category_name']),
                              )))
                          .toList(),
                      hint: Text('Categoría'),
                      value: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    );
                  }
                }()),
              ],
            ),
          ),
          //Fin de los TextFileds
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
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(15, 13, 15, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 40,
                      ),
                      Text(
                        'Guardar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    final employee = {
                      'id': widget.collaborator['id'],
                      'email': emailController.text,
                      'phone': phoneController.text,
                      'pay_per_day': int.parse(pagoController.text),
                      'categories_id': selectedCategory
                    };

                    await API.updateEmployee(employee).then((response) {
                      if (response) {
                        _successDialog();
                      }
                    });

                  },
                ),
                SizedBox(
                  width: 5,
                ),
                FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 40,
                      ),
                      Text(
                        'Cancelar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _successDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(Duration(seconds: 3), (){
            Navigator.of(context).pop(true);
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
              title: Center(
                child: Text(
                  '¡Éxito!',
                ),
              ),
              content: Container(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Se actualizó correctamente',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 35,
                    )
                  ],
                ),
              ));
        });
  }

  void _errorDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              title: Center(
                child: Text(
                  '¡Falló!',
                ),
              ),
              content: Container(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Surgió un problema, por favor intente más tarde',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 35,
                    )
                  ],
                ),
              ));
        });
  }
}
