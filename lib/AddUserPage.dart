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

  //bool _valid = true;
  String selectedEmployee;
  String selectedUserType;
  var selectedUser;
  List users;

  //Controllers Form
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //final emailController = TextEditingController();

  @override
  void initState() {
    API.getUsers().then((response){
      setState(() {
        users = response;
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
                      'Hola ' + globals.user,
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
                    child: DataTable(
                        columns: [
                          DataColumn(
                              label: Text(
                            'Usuario',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                          DataColumn(
                              label: Text(
                            'Contraseña',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                          DataColumn(
                              label: Text(
                            'Tipo de Usuario',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                        ],
                        rows: users
                            .map(((element) => DataRow(
                                  cells: [
                                    DataCell(Text(element['username']),
                                        onTap: () {
                                      selectedUser = element;

                                      usernameController.text =
                                          element['username'];
                                      passwordController.text =
                                          element['password'];

                                      setState(() {
                                        if(element['role']=='0'){
                                          selectedUserType = 'admin';
                                        }else if(element['role']=='1'){
                                          selectedUserType = 'contador';
                                        }else{
                                          selectedUserType = 'digitador';
                                        }
                                      });
                                      scrollController.jumpTo(430);
                                    }),
                                    DataCell(Text(element['password']),
                                        onTap: () {
                                      selectedUser = element;

                                      usernameController.text =
                                          element['username'];
                                      passwordController.text =
                                          element['password'];
                                      setState(() {
                                        if(element['role']=='0'){
                                          selectedUserType = 'admin';
                                        }else if(element['role']=='1'){
                                          selectedUserType = 'contador';
                                        }else{
                                          selectedUserType = 'digitador';
                                        }
                                      });
                                      scrollController.jumpTo(430);
                                    }),
                                    DataCell(Text((){
                                      if(element['role'] == "0"){
                                        return 'Administrador';
                                      }else if(element['role']== "1"){
                                        return 'Contador';
                                      }else{
                                        return 'Digitador';
                                      }
                                    }()),
                                    
                                    onTap: () {
                                      selectedUser = element;

                                      usernameController.text =
                                          element['username'];
                                      passwordController.text =
                                          element['password'];
                                      setState(() {
                                        if(element['role']=='0'){
                                          selectedUserType = 'admin';
                                        }else if(element['role']=='1'){
                                          selectedUserType = 'contador';
                                        }else{
                                          selectedUserType = 'digitador';
                                        }
                                      });
                                      scrollController.jumpTo(430);
                                    }),
                                  ],
                                )))
                            .toList()
                        /* [
                        DataRow(cells: [
                          DataCell(Text('hamiltong98')),
                          DataCell(Text('1234567')),
                          DataCell(Text('admin')),
                        ],
                        ),
                        DataRow(cells: [
                          DataCell(Text('marlons67')),
                          DataCell(Text('abcdef')),
                          DataCell(Text('admin')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('edwinv78')),
                          DataCell(Text('sape.com')),
                          DataCell(Text('digitador')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('franciscos87')),
                          DataCell(Text('xyfsa.98')),
                          DataCell(Text('contador')),
                        ]),
                      ], */
                        ),
                  ),
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
                          value: 'digitador',
                          child: Text('Digitador'),
                        ),
                        DropdownMenuItem(
                          value: 'admin',
                          child: Text('Administrador'),
                        ),
                        DropdownMenuItem(
                          value: 'contador',
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
                  Container(
                    margin: EdgeInsets.all(10),
                    child: SearchableDropdown.single(
                      icon: Icon(Icons.more_vert),
                      hint: 'Seleccionar Empleado',
                      searchHint: 'Empleados - Selecciona uno:',
                      value: selectedEmployee,
                      items: [
                        DropdownMenuItem(
                          value: 'AID00001 - Hamilton García',
                          child: Text('AID00001 - Hamilton García'),
                        ),
                        DropdownMenuItem(
                          value: 'AID00002 - Edwin Vega',
                          child: Text('AID00002 - Edwin Vega'),
                        ),
                        DropdownMenuItem(
                          value: 'AID00003 - Marlon Sánchez',
                          child: Text('AID00003 - Marlon Sánchez'),
                        ),
                        DropdownMenuItem(
                          value: 'AID00004 - Francisco Sotelo',
                          child: Text('AID00004 - Francisco Sotelo'),
                        ),
                      ],
                      underline: Container(),
                      onChanged: (value) {
                        setState(() {
                          selectedEmployee = value;
                        });
                      },
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
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
                                onPressed: () => _successDialog()),
                            FlatButton(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(
                                      Icons.delete_outline,
                                      size: 40,
                                      color: Colors.orange,
                                    ),
                                    Text('Eliminar')
                                  ],
                                ),
                                onPressed: () {}),
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
}
