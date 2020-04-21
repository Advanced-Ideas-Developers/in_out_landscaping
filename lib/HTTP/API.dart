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

}
