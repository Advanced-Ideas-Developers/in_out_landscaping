import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const url = 'http://161.35.100.25/emps/';

class API{

  static Future<List> getUsers() async{
    var response = await http.get(url + 'users');
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse["respuesta: "];
    }else{
      return null;
    }
  }

  static Future<List> getEmployees() async{
    var response = await http.get(url + 'employees');
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

}
