import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'HTTP/API.dart';
import 'Classes/Globals.dart' as globals;

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  //Variable para manejar el scroll de la página
  final scrollController = ScrollController();

  bool isEditing = false;
  String selectedEmployee;
  String selectedUserType;
  int selectedUser;
  List users;
  List employees;

  //Validaciones
  bool usernamevalid = true;
  bool passwordvalid = true;
  bool rolevalid = true;
  bool employeevalid = true;

  //Controllers Form
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //final emailController = TextEditingController();

  @override
  void initState() {
    API.getUsers().then((response) {
      setState(() {
        users = response;
      });
    });

    API.getEmployees().then((response) {
      setState(() {
        employees = response;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          controller: scrollController,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.teal[800]]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(4, 15, 0, 10),
                    child: FlatButton(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          Container(
                            child: Text(
                              'Atrás',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, bottom: 20),
                    child: Text(
                      'Hola ' + globals.userLog,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 40, 20, 30),
              padding: EdgeInsets.fromLTRB(15, 0, 5, 7),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Buscar',
                          contentPadding: EdgeInsets.zero,
                          labelStyle: TextStyle(height: 2),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  /* Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: DropdownButton(
                      hint: Text(
                        'Filtro',
                        style: TextStyle(height: 0),
                      ),
                      icon: Icon(Icons.menu),
                      iconSize: 30,
                      //underline: Container(),

                      items: [
                        DropdownMenuItem(
                          value: 'user',
                          child: Text('Usuario'),
                        ),
                        DropdownMenuItem(
                          value: 'userType',
                          child: Text('Tipo de Usuario'),
                        ),
                      ],
                      onChanged: (value) {
                        print("value: $value");
                      },
                    ),
                  ), */
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'user',
                          child: Text('Usuario'),
                        ),
                        PopupMenuItem(
                          value: 'userType',
                          child: Text('Tipo de Usuario'),
                        ),
                      ],
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                      tooltip: 'Filtro',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: ButtonTheme(
                      minWidth: 20,
                      child: FlatButton(
                        //padding: EdgeInsets.all(10),
                        child: Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 270,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: () {
                        if (users == null) {
                          return Center(
                            heightFactor: 7,
                            widthFactor: 10,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(Colors.teal[800]),
                            ),
                          );
                        }
                        {
                          return DataTable(
                              columns: [
                                DataColumn(
                                    label: Text(
                                  'Usuario',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Contraseña',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                                DataColumn(
                                    label: Text(
                                  'Tipo de Usuario',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )),
                              ],
                              rows: users
                                  .map(((element) => DataRow(
                                        cells: [
                                          DataCell(Text(element['username']),
                                              onTap: () {
                                            isEditing = true;
                                            selectedUser = element['id'];

                                            usernameController.text =
                                                element['username'];
                                            passwordController.text =
                                                element['password'];

                                            setState(() {
                                              selectedUserType =
                                                  element['role'];
                                              selectedEmployee =
                                                  element['employee']['id']
                                                          .toString() +
                                                      ' - ' +
                                                      element['employee']
                                                          ['names'] +
                                                      ' ' +
                                                      element['employee']
                                                          ['last_names'];
                                            });
                                            scrollController.jumpTo(430);
                                          }),
                                          DataCell(Text(element['password']),
                                              onTap: () {
                                            isEditing = true;
                                            selectedUser = element['id'];

                                            usernameController.text =
                                                element['username'];
                                            passwordController.text =
                                                element['password'];
                                            setState(() {
                                              selectedUserType =
                                                  element['role'];
                                              selectedEmployee =
                                                  element['employee']['id']
                                                          .toString() +
                                                      ' - ' +
                                                      element['employee']
                                                          ['names'] +
                                                      ' ' +
                                                      element['employee']
                                                          ['last_names'];
                                            });
                                            scrollController.jumpTo(430);
                                          }),
                                          DataCell(Text(() {
                                            if (element['role'] == "0") {
                                              return 'Administrador';
                                            } else if (element['role'] == "1") {
                                              return 'Contador';
                                            } else {
                                              return 'Digitador';
                                            }
                                          }()), onTap: () {
                                            isEditing = true;
                                            selectedUser = element['id'];

                                            usernameController.text =
                                                element['username'];
                                            passwordController.text =
                                                element['password'];
                                            setState(() {
                                              selectedUserType =
                                                  element['role'];
                                              selectedEmployee =
                                                  element['employee']['id']
                                                          .toString() +
                                                      ' - ' +
                                                      element['employee']
                                                          ['names'] +
                                                      ' ' +
                                                      element['employee']
                                                          ['last_names'];
                                            });
                                            scrollController.jumpTo(430);
                                          }),
                                        ],
                                      )))
                                  .toList());
                        }
                      }()),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Hero(
                tag: 'usuario',
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 70,
                  child: SvgPicture.asset('assets/images/account.svg'),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      //scrollPadding: EdgeInsets.all(10) ,
                      controller: usernameController,
                      decoration: InputDecoration(
                          labelText: 'Nombre de Usuario',
                          errorText: usernamevalid
                              ? null
                              : '¡Debe rellenar este campo!',
                          contentPadding: EdgeInsets.only(left: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (v) {
                        //print(v);
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      //scrollPadding: EdgeInsets.only(bottom: 1000),
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: 'Contraseña',
                          errorText: passwordvalid
                              ? null
                              : '¡Debe rellenar este campo!',
                          contentPadding: EdgeInsets.only(left: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  /* Container(
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: 'E-mail',
                          contentPadding: EdgeInsets.only(left: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          errorText:
                              !_valid ? 'Formato de E-mail Incorrecto' : null),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (v) {
                        //print(v);
                        FocusScope.of(context).nextFocus();
                      },
                      onChanged: (value) {
                        bool isValid =
                            EmailValidator.validate(emailController.text);
                        setState(() {
                          _valid = isValid;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ), */
                  /* Container(
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: 'Teléfono',
                          contentPadding: EdgeInsets.only(left: 15),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)))),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                    ),
                  ), */
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    child: OutlineDropdownButton(
                      value: selectedUserType,
                      inputDecoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          contentPadding: EdgeInsets.only(left: 15)),
                      items: [
                        DropdownMenuItem(
                          value: '2',
                          child: Text('Digitador'),
                        ),
                        DropdownMenuItem(
                          value: '0',
                          child: Text('Administrador'),
                        ),
                        DropdownMenuItem(
                          value: '1',
                          child: Text('Contador'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedUserType = value;
                        });
                      },
                      hint: Text('Tipo de Usuario'),
                      iconSize: 30,
                    ),
                  ),
                  () {
                    if (!rolevalid) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '¡Debe selecciona un Tipo de Usuario!',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return Container();
                  }(),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: () {
                        if (employees == null) {
                          return Container();
                        } else {
                          return SearchableDropdown.single(
                            icon: Icon(Icons.more_vert),
                            hint: 'Seleccionar Empleado',
                            searchHint: 'Empleados - Selecciona uno:',
                            value: selectedEmployee,
                            items: employees
                                .map(((employee) => DropdownMenuItem(
                                      value: employee['id'].toString() +
                                          ' - ' +
                                          employee['names'] +
                                          ' ' +
                                          employee['last_names'],
                                      child: Text(employee['names'] +
                                          ' ' +
                                          employee['last_names']),
                                    )))
                                .toList(),
                            underline: Container(),
                            onChanged: (value) {
                              setState(() {
                                selectedEmployee = value;
                              });
                            },
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          );
                        }
                      }()),
                  () {
                    if (!employeevalid) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '¡Debe selecciona un Tipo de Usuario!',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return Container();
                  }(),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 40),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.check,
                                      size: 40,
                                      color: Colors.green[300],
                                    ),
                                    Text('Aceptar')
                                  ],
                                ),
                                onPressed: () {
                                  _createOrEditUser();
                                }),
                            FlatButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.warning,
                                      size: 40,
                                      color: Colors.orange,
                                    ),
                                    Text('Deshabilitar')
                                  ],
                                ),
                                onPressed: () {
                                  if (isEditing) {
                                    API.updateUser({
                                      'id': selectedUser,
                                      'state': false
                                    }).then((response) {
                                      if (response) {
                                        _changeStateDialog();
                                        usernameController.clear();
                                        passwordController.clear();
                                        isEditing = false;
                                        setState(() {
                                          selectedUserType = null;
                                          selectedEmployee = null;
                                        });
                                      } else {
                                        _errorDialog();
                                      }
                                    });
                                  }
                                }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Icon(
                                    Icons.close,
                                    size: 40,
                                    color: Colors.redAccent,
                                  ),
                                  Text('Cancelar')
                                ],
                              ),
                              onPressed: () {
                                usernameController.clear();
                                passwordController.clear();
                                setState(() {
                                  selectedUserType = null;
                                  selectedEmployee = null;
                                });
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _successDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
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
                      'Usuario Agregado Correctamente',
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

  void _changeStateDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
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
                      'Se deshabilitó al usuario correctamente',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      Icons.info,
                      color: Colors.blueAccent[200],
                      size: 35,
                    )
                  ],
                ),
              ));
        });
  }

  void _createOrEditUser() async {
    var user = {};
    if (usernameController.text.length == 0) {
      setState(() {
        usernamevalid = false;
      });
      return;
    } else {
      setState(() {
        usernamevalid = true;
      });
      user['username'] = usernameController.text;
    }

    if (passwordController.text.length == 0) {
      setState(() {
        passwordvalid = false;
        return;
      });
    } else {
      setState(() {
        passwordvalid = true;
      });
      user['password'] = passwordController.text;
    }

    if (selectedUserType == null) {
      setState(() {
        rolevalid = false;
        return;
      });
    } else {
      setState(() {
        rolevalid = true;
      });
      user['role'] = selectedUserType;
    }

    if (selectedEmployee == null) {
      setState(() {
        employeevalid = false;
        return;
      });
    } else {
      setState(() {
        employeevalid = true;
      });
      var employeeId = selectedEmployee.split('-');
      user['employees_id'] = int.parse(employeeId[0].trim());
    }

    user["state"] = true;

    if (isEditing) {
      user['id'] = selectedUser;
      await API.updateUser(user).then((response) {
        if (response) {
          _successDialog();
          usernameController.clear();
          passwordController.clear();
          isEditing = false;
          setState(() {
            selectedUserType = null;
            selectedEmployee = null;
          });
        } else {
          _errorDialog();
        }
      });
    } else {
      await API.addUser(user).then((response) {
        if (response) {
          _successDialog();
          usernameController.clear();
          passwordController.clear();
          setState(() {
            selectedUserType = null;
            selectedEmployee = null;
          });
        } else {
          _errorDialog();
        }
      });
    }
    await API.getUsers().then((response) {
      setState(() {
        users = response;
      });
    });
  }
}
