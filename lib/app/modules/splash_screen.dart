import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/home/views/home_view.dart';

import '../modules/dashboard/views/dashboard_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final List<Color> colors = <Color>[Colors.red, Colors.blue,Colors.amber];
  final  colorizeColors = [
    Color(0xfff6ff00), Colors.blue, Colors.blueAccent, Colors.white,
  ];
  var token,role,userId,compagnieId,usernames,userName,gare, statut;

  // CHECK USER SESSION
   checkLoginStatus() async {
      final sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") != null || sharedPreferences.getInt("compagnie_id") != null||sharedPreferences.getString("role") != null || sharedPreferences.getInt("id") != null|| sharedPreferences.getString("nom") != null
       || sharedPreferences.getString("gare") != null ) {
       setState(() {
          token = sharedPreferences.getString("token");
          role = sharedPreferences.getString("role");
          userName = sharedPreferences.getString("nom");
          userId = sharedPreferences.getInt("id");
          compagnieId = sharedPreferences.getInt("compagnie_id");
          gare= sharedPreferences.getString("gare");
        });
    }
  }



  @override
  void initState() {
    super.initState();
     checkLoginStatus();
      Timer(
        Duration(seconds:8),() {

            if(role == "chef_gare")
              {
                  Get.to(const DashboardView());
              } else if(role == null || role != "chef_gare"){
                  Get.to(const HomeView());
             }
          }
       );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: CustomColor.primary,
          image: DecorationImage(image: AssetImage("assets/images/bg4.jpg"), colorFilter: ColorFilter.mode(Colors.black54, BlendMode.colorBurn),fit: BoxFit.fill)
        ),
        child:
        Column(
          children: [
          Container(
            margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/6),
            child:AnimatedTextKit( animatedTexts: [
                ColorizeAnimatedText('vavavoom',
                textAlign: TextAlign.center,
                 textStyle: TextStyle(
                fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white, fontFamily: 'Aviano'), colors: colorizeColors, speed: const Duration(milliseconds: 1000),),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            )),
            Text("Vos voyages commencent ici !",style: TextStyle(fontFamily: 'PtRegularItalic',fontSize: 20, fontWeight: FontWeight.bold,  color: Colors.white ))
          ],
        ),
      ),
    );
  }
}
