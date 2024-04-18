import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vavavoom/app/constant/Apis.dart';
import 'package:vavavoom/app/modules/auth/controllers/auth_controller.dart';

class Auth {
  
  // static Future<bool>? login(String phone, String password) async {
  static Future login(String phone, String password) async {
    AuthController authController = Get.find();
    try {
      final response = await http.post(
        Uri.parse("${HostApi.baseUrl}/userlogin"),
        body: {
         "telephone": phone,
         "password": password},
      );
      final data = jsonDecode(response.body);
      print(data);
      
      if (response.statusCode == 200) {

        authController.donnees.value=data;
        return true;
        
      } else {

        authController.messageLogin.value = data["message"];
        return false;

      }
    } catch (e) {

      print(e.toString());
      
      return false;
    }
  }

  static Future<bool>? register(String phone, String password,String fullName) async {
    try {
      final response = await http.post(
        Uri.parse("${HostApi.baseUrl}/registers"),
        body: {
          "telephone": phone,
          "password": password,
          "nom": fullName
          },
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return true;

      } else {

        return false;

      }
    } catch (e) {

      print(e.toString());

      return false;
    }
  }
}