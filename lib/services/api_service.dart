import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:info_fina/const/global_const.dart';



class ApiServices {
  static final Dio _dio = Dio();
  static Future<Map<String, dynamic>> get({required String slug}) async {
    try {
      var response = await _dio.get('${ApiConstant.BASEURL}/$slug');
      print('Response: $response');

      Map<String, dynamic> json = jsonDecode(response.data);
      return json;
    } catch (e) {
      
       }
    return {
      'status': false,
      'message': 'Something Went Wrong',
    };
  }

  static Future<Map<String, dynamic>> post({
    required String slug,
    required Map<String, dynamic> body,
  }) async {
     
    try {
      var response = await _dio.post('${ApiConstant.BASEURL}/$slug',
          data: jsonEncode(body),
          options: Options(headers: {
           'Content-Type': 'application/json',
          
          }));
      Map<String, dynamic> json = response.data;
      return json;
    } catch (e) {
      return {
        'status': false,
        'message': 'Invalid Data',
      };
    }
  }
  
}