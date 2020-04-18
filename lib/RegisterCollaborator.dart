import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:email_validator/email_validator.dart';
/* 
class RegisterCollaborator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collaborator',
      home: RegisterCollaboratorView(),
      theme: ThemeData(
        primaryColor: Colors.green[800],
        accentColor: Colors.black,
      ),
    );
  }
} */

class RegisterCollaboratorView extends StatefulWidget {
  @override
  _RegisterCollaboratorViewState createState() =>
      _RegisterCollaboratorViewState();
}

class _RegisterCollaboratorViewState extends State<RegisterCollaboratorView> {
  bool _isChecked = false; // Variable a utilizar en el checkbox de la Pantalla
  bool _valid = true;

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final payHoursController = TextEditingController();

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
              margin: EdgeInsets.only(top: 10, bottom: 5),
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
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(40, 5, 40, 15),
              child: OutlineDropdownButton(
                inputDecoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  contentPadding: EdgeInsets.only(left: 20),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'tree',
                    child: Text('Poda de Arboles'),
                  ),
                  DropdownMenuItem(
                    value: 'irrigation',
                    child: Text('Riego'),
                  ),
                  DropdownMenuItem(
                    value: 'cleaning',
                    child: Text('Limpieza a Presion'),
                  ),
                  DropdownMenuItem(
                    value: 'pest control',
                    child: Text('Control de Plagas'),
                  ),
                  DropdownMenuItem(
                    value: 'mantenimiento',
                    child: Text('Mantenimiento'),
                  ),
                ],
                onChanged: (value) {
                  print(value);
                },
                hint: Text('Seleccionar Categoria'),
                iconSize: 40,
              ),
            ),
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
              ],
            ),
          ),
          //Fin de la Segunda Parte de la pantalla (Textfields)
          //Inicio de la Tercera Parte de la Pantalla (checkbox y PopupButton)
          Container(
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
                Container(
                  child: DropdownButton(
                    items: [
                      DropdownMenuItem(
                        value: 'admin',
                        child: Text('Administrador'),
                      ),
                      DropdownMenuItem(
                        value: 'contador',
                        child: Text('Contador'),
                      ),
                      DropdownMenuItem(
                        value: 'digitador',
                        child: Text('Digitador'),
                      ),
                      DropdownMenuItem(
                        value: 'colaborador',
                        child: Text('Colaborador'),
                      )
                    ],
                    onChanged: (value) {
                      print(value);
                    },
                    icon: Icon(Icons.menu),
                    iconSize: 25,
                    hint: Text('Tipo de Usuario  '),
                  ),
                ),
              ],
            ),
          ),
          // Fin de la Tercera Parte de la Pantalla (checkbox y PopupButton)
          //Inicio de la Cuarta Parte  de la Pantalla (Boton Registrar)
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
              child: Text(
                'Registrar',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Georgia',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text(
                      '¡El  Usuario se ha registrado exitosamente!',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    children: <Widget>[
                      SizedBox(height: 5),
                      Container(
                        alignment: Alignment.center,
                        child: Text('Usuario: Shewin'),
                      ),
                      SizedBox(height: 5),
                      Container(
                        alignment: Alignment.center,
                        child: Text('Contraseña: Purrungudo01'),
                      ),
                      SizedBox(height: 5),
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.check_circle,
                            size: 40,
                            color: Colors.green,
                          ),
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
        ],
      ),
    );
  }
}
