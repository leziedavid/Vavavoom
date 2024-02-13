import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoum/app/Services/Api/Auth.dart';
import 'package:vavavoum/app/modules/dashboard/views/dashboard_view.dart';
import 'package:vavavoum/app/modules/home/views/home_view.dart';

class AuthController extends GetxController {
  //TODO: Implement AuthController

  final count = 0.obs;
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController registerPhone = TextEditingController();

  final messageLogin = "".obs;
  PageController pageController = PageController();
  final loadAuth = false.obs;
  final isObsureText = true.obs;
  final donnees = [].obs;
  final nameUsers = "".obs;
  final messages = "".obs;
  final isLogin = false.obs;
  final isAdmin = false.obs;
  var token,role,userId,usernames,userName,compagnieId, gare;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  logout() async {
      final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.clear();
        isLogin(false);
        isAdmin(false);
        print(isLogin);
      }


    checkLoginStatus() async {
    
      final sharedPreferences = await SharedPreferences.getInstance();

        if(sharedPreferences.getString("nom") != "") 
          {
              token= sharedPreferences.getString("token").toString();
              role = sharedPreferences.getString("role").toString();
              userName = sharedPreferences.getString("nom").toString();
              userId  =sharedPreferences.getInt("id");
              compagnieId = sharedPreferences.getString("compagnie_id").toString();
              gare= sharedPreferences.getString("gare").toString();

            // ici nous verifions si l'etulisateur est connecté
            isLogin(true);
            isAdmin(true);


            if(role == "chef_gare")
                {
                    isLogin(true); 
                    isAdmin(true); 
                
                } else {
                  isLogin(true); 
                  isAdmin(false); 
                }

          }else{

            isLogin(false);
            isAdmin(false);
          }

  }    
      
  login() async {
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    log(phone.text);
    log(password.text);

    loadAuth(true);
    final res = await Auth.login(phone.text, password.text);
    loadAuth(false);
    isLogin(true);
    // print(donnees[0]['role']);
     if (res!) {

    nameUsers.value=donnees[0]['nom'];
    nameUsers.value=donnees[0]['nom'];
    // messages.value=donnees[0]['message'].toString();
      
          sharedPreferences.setString("token",'authToken');
          // sharedPreferences.setString("token", donnees[0]['token'].toString());
          sharedPreferences.setString("role", donnees[0]['role']);
          sharedPreferences.setString("nom", donnees[0]['nom']);
          sharedPreferences.setString("telephone", donnees[0]['telephone']);
          sharedPreferences.setString("compagnie_id", donnees[0]['compagnie_id'].toString());
          sharedPreferences.setString("gare", donnees[0]['gare'].toString());
          sharedPreferences.setInt("id", donnees[0]['id']);

          if(donnees[0]['role'] == "chef_gare")
            {
              Get.to(const DashboardView());
              isLogin(true); 
              isAdmin(true); 
              Get.snackbar("Bonjour","Bienvenue $nameUsers !", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff191970)); 
           
            } else {

             isLogin(true); 
             isAdmin(false); 
             Get.to(const HomeView());
              Get.snackbar("Bonjour","Bienvenue $nameUsers !", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff191970)); 
            }

         }else{

          loadAuth(false);
           Get.snackbar("Erreur","$messageLogin !.", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff234A99));
         }

    }


 registers() async {

      final resulte = await Auth.register(registerPhone.text, registerPassword.text,fullName.text);

        if (resulte!) {

            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            loadAuth(true);
            final res = await Auth.login(registerPhone.text, registerPassword.text);
            loadAuth(false);
            isLogin(true);
            nameUsers.value=donnees[0]['nom'];
            print(donnees[0]['role']);

            if (res!) {

                      sharedPreferences.setString("token",'authToken');
                      sharedPreferences.setString("role", donnees[0]['role']);
                      sharedPreferences.setString("nom", donnees[0]['nom']);
                      sharedPreferences.setString("telephone", donnees[0]['telephone']);
                      sharedPreferences.setString("compagnie_id", donnees[0]['compagnie_id'].toString());
                      sharedPreferences.setString("gare", donnees[0]['gare'].toString());
                      sharedPreferences.setInt("id", donnees[0]['id']);

                  if(donnees[0]['role'] == "chef_gare")
                    {
                      Get.to(const DashboardView());
                      isLogin(true); 
                      isAdmin(true); 
                      Get.snackbar("Bonjour","Bienvenue $nameUsers !", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff191970)); 
                  
                    } else {

                    isLogin(true); 
                    isAdmin(false); 
                      Get.to(const HomeView());
                      Get.snackbar("Bonjour","Bienvenue $nameUsers !", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff191970)); 
                    }  
                }

     
          }else{

            Get.snackbar("Erreur","Ce numéros de téléphone est déja utilisé.", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff234A99));
        }

    }


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
