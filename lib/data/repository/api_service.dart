import 'dart:convert';

import 'package:api_getmethod_multipleitem/data/model/comments_page.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl='https://jsonplaceholder.typicode.com';
  Future<List<Comments>>fetchComments() async{
    final response =await http.get(Uri.parse('$_baseUrl/comments'));
    if(response.statusCode==200){
      List<dynamic>data=json.decode(response.body);
      return data.map((commentsjson) => Comments.fromJson(commentsjson)).toList();
    }else{
      throw Exception('faild to load comments');
    }
  }
}