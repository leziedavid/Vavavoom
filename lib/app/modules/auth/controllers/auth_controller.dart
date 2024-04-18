import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoom/app/Services/Api/Auth.dart';
import 'package:vavavoom/app/modules/auth/views/auth_view.dart';
import 'package:vavavoom/app/modules/dashboard/views/dashboard_view.dart';
import 'package:vavavoom/app/modules/home/views/home_view.dart';

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
  final appareil = 0.obs;
  final isLogin = false.obs;
  final statusLogin = 0.obs;
  final isAdmin = false.obs;
  final isUsers = true.obs;
  var token,role,userId,usernames,userName,compagnieId, gare;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
    // checkAdminLoginStatus();
  }




Future<void> cleanData() async {
  final sharedPreferences = await SharedPreferences.getInstance();

        if (sharedPreferences.getString("nom") != null) {
          await sharedPreferences.remove("token");
          await sharedPreferences.remove("role");
          await sharedPreferences.remove("nom");
          await sharedPreferences.remove("id");
          await sharedPreferences.remove("compagnie_id");
          await sharedPreferences.remove("gare");
    }
  }


  logout() async {

      final sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.clear();
      await sharedPreferences.remove("token");
      await sharedPreferences.remove("role");
      await sharedPreferences.remove("nom");
      await sharedPreferences.remove("id");
      await sharedPreferences.remove("compagnie_id");
      await sharedPreferences.remove("gare");
        statusLogin.value=0;
        isLogin(false);
        isAdmin(false);
        isUsers(true);

        if(appareil==1){

          checkLoginStatus();
           Get.to(const AuthView());

        }else{

          checkLoginStatus();
        }


        
      }


  checkAdminLoginStatus() async {
  
      final sharedPreferences = await SharedPreferences.getInstance();

        if(sharedPreferences.getString("nom") != null && statusLogin.value==1) 
          {
              Get.to(const DashboardView());
          }else{
             Get.to(const AuthView());
          }
  }

      
  checkLoginStatus() async {
        print(statusLogin.value);
        final sharedPreferences = await SharedPreferences.getInstance();

        if(sharedPreferences.getString("nom") != null && statusLogin.value==1) 
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
           
            if(role == "chef_gare" || role == "gestionnaire_ticket")
                {
                    isLogin(true);
                    isAdmin(true);
                    isUsers(false);
                } else {
                  isLogin(true);
                  isAdmin(false);
                  isUsers(true);
                }

          }else{

            isLogin(false);
            isAdmin(false);
            isUsers(true);
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
    
     if (res!) {

          nameUsers.value=donnees[0]['nom'];
          nameUsers.value=donnees[0]['nom'];
          sharedPreferences.setString("token",'authToken').toString();
          statusLogin.value=1;
          sharedPreferences.setString("role", donnees[0]['role']);
          sharedPreferences.setString("nom", donnees[0]['nom'].toString());
          sharedPreferences.setString("telephone", donnees[0]['telephone'].toString());
          sharedPreferences.setString("compagnie_id", donnees[0]['compagnie_id'].toString());
          sharedPreferences.setString("gare", donnees[0]['gare'].toString());
          sharedPreferences.setInt("id", donnees[0]['id']);

          if(donnees[0]['role'] == "chef_gare"  || donnees[0]['role'] == "gestionnaire_ticket")
            {
              appareil.value=1;
              isLogin(true);
              isAdmin(true);
              isUsers(false);
              Get.to(const DashboardView());
              Get.snackbar("Bonjour","Bienvenue $nameUsers !",
               icon: Icon(Icons.person, color: const Color.fromARGB(255, 255, 0, 0),size: 50,),
               snackPosition: SnackPosition.BOTTOM,
               backgroundColor: Color.fromARGB(255, 255, 255, 255),
               borderRadius: 10,
               margin: EdgeInsets.all(15),
               colorText: const Color.fromARGB(255, 255, 0, 0),
               duration: Duration(seconds: 4),
               isDismissible: true,
               forwardAnimationCurve: Curves.easeOutBack,
               );

              // Get.snackbar("Bonjour","Bienvenue $nameUsers !", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff191970)); 
           
            } else {

             isLogin(true);
             isAdmin(false);
             isUsers(true);
             Get.to(const HomeView());
             appareil.value=0;
              Get.snackbar("Bonjour","Bienvenue $nameUsers !",
               icon: Icon(Icons.person, color: const Color.fromARGB(255, 255, 0, 0),size: 50,),
               snackPosition: SnackPosition.BOTTOM,
               backgroundColor: Color.fromARGB(255, 255, 255, 255),
               borderRadius: 10,
               margin: EdgeInsets.all(15),
               colorText: const Color.fromARGB(255, 255, 0, 0),
               duration: Duration(seconds: 4),
               isDismissible: true,
               forwardAnimationCurve: Curves.easeOutBack,
               );

              // Get.snackbar("Bonjour","Bienvenue $nameUsers !", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff191970)); 
            }

         }else{
          appareil.value=0;
              loadAuth(false);
              Get.snackbar("Erreur", "$messageLogin !",
              icon: Icon(Icons.person, color: const Color.fromARGB(255, 255, 0, 0),size: 50,),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              borderRadius: 10,
              margin: EdgeInsets.all(15),
              colorText: const Color.fromARGB(255, 255, 0, 0),
              duration: Duration(seconds: 4),
              isDismissible: true,
              //dismissDirection: SnackDismissDirection.HORIZONTAL,
              forwardAnimationCurve: Curves.easeOutBack,
            );
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
                      statusLogin.value=1;
                      sharedPreferences.setString("token",'authToken').toString();
                      sharedPreferences.setString("role", donnees[0]['role']);
                      sharedPreferences.setString("nom", donnees[0]['nom'].toString());
                      sharedPreferences.setString("telephone", donnees[0]['telephone'].toString());
                      sharedPreferences.setString("compagnie_id", donnees[0]['compagnie_id'].toString());
                      sharedPreferences.setString("gare", donnees[0]['gare'].toString());
                      sharedPreferences.setInt("id", donnees[0]['id']);

                  if(donnees[0]['role'] == "chef_gare" || donnees[0]['role'] == "gestionnaire_ticket")
                    {
                      appareil.value=1;
                      Get.to(const DashboardView());
                      isLogin(true);
                      isAdmin(true);
                      isUsers(false);
                        Get.snackbar("Bonjour","Bienvenue $nameUsers !",
                        icon: Icon(Icons.person, color: const Color.fromARGB(255, 255, 0, 0),size: 50,),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: 10,
                        margin: EdgeInsets.all(15),
                        colorText: const Color.fromARGB(255, 255, 0, 0),
                        duration: Duration(seconds: 4),
                        isDismissible: true,
                        forwardAnimationCurve: Curves.easeOutBack,
                        );
                      // Get.snackbar("Bonjour","Bienvenue $nameUsers !", colorText: Colors.white,  borderRadius: 7,backgroundColor: Color(0xff191970)); 
                  
                    } else {
                      appareil.value=0;
                      isLogin(true);
                      isAdmin(false);
                      isUsers(true);
                      Get.to(const HomeView());
                      Get.snackbar("Bonjour","Bienvenue $nameUsers !",
                      icon: Icon(Icons.person, color: const Color.fromARGB(255, 255, 0, 0),size: 50,),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: 10,
                      margin: EdgeInsets.all(15),
                      colorText: const Color.fromARGB(255, 255, 0, 0),
                      duration: Duration(seconds: 4),
                      isDismissible: true,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );

                    }
                }

     
          }else{
            appareil.value=0;
              Get.snackbar("Erreur","Ce numéros de téléphone est déja utilisé !",
              icon: Icon(Icons.person, color: const Color.fromARGB(255, 255, 0, 0),size: 50,),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              borderRadius: 10,
              margin: EdgeInsets.all(15),
              colorText: const Color.fromARGB(255, 255, 0, 0),
              duration: Duration(seconds: 4),
              isDismissible: true,
              forwardAnimationCurve: Curves.easeOutBack,
            );
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
