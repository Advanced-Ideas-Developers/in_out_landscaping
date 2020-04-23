import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'HTTP/API.dart';

class RegisterCollaboratorView extends StatefulWidget {
  @override
  _RegisterCollaboratorViewState createState() =>
      _RegisterCollaboratorViewState();
}

class _RegisterCollaboratorViewState extends State<RegisterCollaboratorView> {
  bool _isChecked = false; // Variable a utilizar en el checkbox de la Pantalla
  bool _valid = true;
  List categories;
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final payHoursController = TextEditingController();
  //Variales booleanas de los textfield
  bool employeenamevalid;
  bool employeelastnamevalid;
  bool employeemailvalid;
  bool employeephonevalid;
  bool employeepayvalid;
  bool employeecategory;
  String selectCategory;
  @override
  void initState() {
    API.getCategories().then((response) {
      setState(() {
        categories = response;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> _headerColor = [
      Colors.black,
      Colors.teal[800]
    ]; //Lista Colores de la Cabezera

    return Scaffold(
      body: ListView(
        children: <Widget>[
          //Cabezera de la Vista
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
                'Registrar Colaborador',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          //Fin de la cabezera
          //Inicio de la primera parte de la pantalla (Foto y dropdown options)
          Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 0),
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
              child: Hero(
                tag: 'worker',
                child: CircleAvatar(
                  child: SvgPicture.asset("assets/images/team.svg"),
                  radius: 80,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(40, 5, 40, 15),
                child: () {
                  if (categories == null) {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.teal[800]),
                    );
                  } else {
                    return OutlineDropdownButton(
                      inputDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        contentPadding: EdgeInsets.only(left: 20),
                      ),
                      items: categories
                          .map(((category) => DropdownMenuItem(
                                value: category['id'].toString(),
                                child: Text(category['category_name']),
                              )))
                          .toList(),
                      //underline: Container(),
                      onChanged: (value) {
                        setState(() {
                          selectCategory = value;
                        });
                      },
                      hint: Text('Seleccionar Categoría'),
                      iconSize: 40,
                    );
                  }
                }()),
          ]),
          //Fin de la primera parte de la pantalla (Foto y dropdown options)
          //Inicio de la Segunda Parte de la pantalla (Textfields)
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
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Apellido',
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
                    keyboardType: TextInputType.emailAddress,
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    controller: payHoursController,
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
              ],
            ),
          ),
          //Fin de la Segunda Parte de la pantalla (Textfields)
          //Inicio de la Tercera Parte de la Pantalla (checkbox y PopupButton)
          /* Container(
            margin: EdgeInsets.fromLTRB(40, 5, 40, 15),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              border: Border.all(width: 2, color: Colors.black54),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(2),
                  child: Checkbox(
                    value: _isChecked,
                    activeColor: Colors.green[800],
                    onChanged: (bool newvalue) {
                      setState(() {
                        _isChecked = newvalue;
                      });
                    },
                  ),
                ),
                /* Container(
                  child: () {
                    if (categories == null) {
                      return Container();
                    } else {
                      return SearchableDropdown(
                          icon: Icon(Icons.menu),
                          iconSize: 25,
                          hint: 'Tipo de Usuario',
                          searchHint: 'Usuario - Selecciona uno: ',
                          value: selectCategory,

                          items: categories.map(((category) => DropdownMenuItem(
                            value: category['id'].toString(),
                            child: Text(category['category_name']),
                          ))).toList(),
                          underline: Container(),
                          onChanged: (value) {
                            setState(() {
                              selectCategory = value;
                            });
                          },
                      );
                    }
                  }(),
                ), */
              ],
            ),
          ), */
          // Fin de la Tercera Parte de la Pantalla (checkbox y PopupButton)
          //Inicio de la Cuarta Parte  de la Pantalla (Boton Registrar)
          Container(
            //width: 30,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(40, 15, 40, 25),
            //height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              /*  boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15.0,
                  ),
                ] */
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  //color: Colors.orange,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 40,
                      ),
                      Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    var employee = {};
                    if (int.parse(selectCategory) == 1) {
                      setState(() {
                        employeecategory = true;
                      });
                      employee['categories_id'] = int.parse(selectCategory);
                    } else {
                      if (int.parse(selectCategory) == 2) {
                        setState(() {
                          employeecategory = true;
                        });
                        employee['categories_id'] = int.parse(selectCategory);
                      }
                    }
                    if (nameController.text.length == 0) {
                      setState(() {
                        employeenamevalid = false;
                      });
                      return;
                    } else {
                      setState(() {
                        employeenamevalid = true;
                      });
                      employee['names'] = nameController.text;
                    }

                    if (lastNameController.text.length == 0) {
                      setState(() {
                        employeelastnamevalid = false;
                      });
                      return;
                    } else {
                      setState(() {
                        employeelastnamevalid = true;
                      });
                      employee['last_names'] = lastNameController.text;
                    }

                    if (emailController.text.length == 0) {
                      setState(() {
                        employeemailvalid = false;
                      });
                      return;
                    } else {
                      setState(() {
                        employeemailvalid = true;
                      });
                      employee['email'] = emailController.text;
                    }

                    if (phoneController.text.length == 0) {
                      setState(() {
                        employeephonevalid = false;
                      });
                      return;
                    } else {
                      setState(() {
                        employeephonevalid = true;
                      });
                      employee['phone'] = phoneController.text;
                    }

                    if (payHoursController.text.length == 0) {
                      setState(() {
                        employeepayvalid = false;
                      });
                      return;
                    } else {
                      setState(() {
                        employeepayvalid = true;
                      });
                      employee['pay_per_hour'] =
                          int.parse(payHoursController.text);
                    }

                    employee['state'] = true;

                    await API.addEmployee(employee).then((response) {
                      if (response) {
                        _showDialogRegister();
                        nameController.clear();
                        lastNameController.clear();
                        emailController.clear();
                        phoneController.clear();
                        payHoursController.clear();
                      } else {
                        _showDialogErrorRegister();
                      }
                    });
                    //Comienzo Anuncio
                    //Fin Anuncio
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogRegister() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              title: Center(
                child: Text(
                  '¡Èxito!',
                ),
              ),
              content: Container(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Colaborador Agregado',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _showDialogErrorRegister() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              title: Center(
                child: Text(
                  '¡Error!',
                ),
              ),
              content: Container(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Colaborador no Agregado',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ));
        });
  }
}
