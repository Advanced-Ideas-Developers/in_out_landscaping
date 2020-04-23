import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const url = 'http://161.35.100.25/emps/';

class API{

  static Future<List> getUser(String username) async{
    var response = await http.get(url + 'user-nombre/$username');
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['respuesta: '];
    }else{
      return null;
    }
  }

  static Future<List> getUsers() async{
    var response = await http.get(url + 'colaboradores');
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse["datos"];
    }else{
      return null;
    }
  }

  static Future<List> getEmployees() async{
    var response = await http.get(url + 'employees-categories');
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse["respuesta: "];
    }else{
      return null;
    }
  }

  static Future<List> getCategories() async{
    var response = await http.get(url + 'categories');
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse["respuesta: "];
    }else{
      return null;
    }
  }

  static Future<List> getEmployeesbyName(String nombre) async{
    var response = await http.get(url + 'colaboradores-nombre/$nombre');
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse["datos"];
    }else{
      return null;
    }
  }

  static Future<List> getAssistance() async{
    var response = await http.get(url + 'inout-employee');
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse["respuesta: "];
    }else{
      return null;
    }
  }

  static Future<bool> addUser(Map user) async{
    var response = await http.post(url + 'add-user',headers: {'content-type':'application/json'} , body: convert.json.encode(user));
    if (response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  static Future<bool> updateUser(Map user) async{
    var response = await http.put(url + 'actualizar-usuario', headers: {'content-type':'application/json'}, body: convert.json.encode(user));
    if (response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
  
  static Future<bool> addEmployee(Map employee) async {
    var response = await http.post(url + 'add-employee',headers: {'content-type':'application/json'},
    body: convert.json.encode(employee));
    print(response.statusCode);
    if (response.statusCode == 200){
      return true;
    }else {
      return false;
    }
  } 

  static Future<bool> addAssistance(Map inout) async {
    var response = await http.post(url + 'inout',headers: {'content-type':'application/json'},
      body: convert.json.encode(inout)
    );
    if (response.statusCode == 200) {
      return true;
    }else {
      return false;
    }
  }

  static Future<bool> updateAssisance(Map inout) async {
    var response = await http.put(url + 'inout', headers: {'content-type':'application/json'},
      body: convert.json.encode(inout)
    );
    if (response.statusCode == 200) {
      return true;
    }else {
      return false;
    }
  }

}
