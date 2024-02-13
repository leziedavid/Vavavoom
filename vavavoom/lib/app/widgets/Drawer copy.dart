import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoum/app/Fonctions/lancherUrl.dart';
import 'package:vavavoum/app/Fonctions/share.dart';
import 'package:vavavoum/app/modules/home/views/home_view.dart';

import '../constant/Color.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/partenaire/views/partenaire_view.dart';
import '../modules/ticket/views/MyHistorique.dart';
import '../modules/ticket/views/history_ticket_view.dart';

// class DrawerCustom extends StatelessWidget {

class DrawerCustom extends StatefulWidget {

  const DrawerCustom({ Key? key,}) : super(key: key);

  @override
  DrawerState createState() => new DrawerState();
  }

class DrawerState extends State<DrawerCustom> {

  var token,role,userId,usernames,userName,compagnieId, gare;

  bool isLogin = false;
  bool isAdmin = false;

  checkLoginStatus() async {

    final sharedPreferences = await SharedPreferences.getInstance();

        if( sharedPreferences.getString("nom") != "" || sharedPreferences.getInt("id") != null ){

          setState(() {
                  token= sharedPreferences.getString("token").toString();
                  role = sharedPreferences.getString("role").toString();
                  userName = sharedPreferences.getString("nom").toString();
                  userId =sharedPreferences.getInt("id").toString();
                  compagnieId = sharedPreferences.getString("compagnie_id").toString();
                  gare= sharedPreferences.getString("gare").toString(); 
                  
                   if(role == "chef_gare")
                    {  
                  isLogin=true;
                  isAdmin=true;
                    }else{
                    isLogin=true;
                    isAdmin=false;
                    }

              
            });

      }else {

        setState(() {
            isLogin=false;
            isAdmin=false;
            
        });
      }
  }

  void initState() {
    checkLoginStatus();
    super.initState();
  }



  Widget build(BuildContext context) {

        // HomeController homeController = Get.put(HomeController());
        // TicketController ticketController = Get.put(TicketController());
        // AuthController authController = Get.put(AuthController());

          return Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [ Container( height: 50.h,color: CustomColor.primary, ), const SizedBox(  height: 5,
                ),
                ListTile(
                  // dense: true,
                  shape: const Border.symmetric( horizontal: BorderSide(width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),),
                  leading: const Icon(CupertinoIcons.tickets),
                  title: Text( 'Achetez un ticket', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                  ),
                  onTap: () { Get.to( const HomeView()); },
                ),
                const SizedBox( height: 5,
                ),
                ListTile( shape: const Border.symmetric(horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)), ),
                  leading: const Icon(CupertinoIcons.refresh_circled),
                  title: Text( 'Mes tickets',style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),),
                    onTap: () { Get.to(const HistoryTicketView(),);
                    //  ticketController.getData();
                    },
                ),
                const SizedBox( height: 5,),
                ListTile(
                  shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)), ),
                  leading: const Icon(CupertinoIcons.bus),
                  title: Text('Nos partenaires', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),),
                  onTap: () { Get.to(const PartenaireView()); },
                ),
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                  shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),),
                  leading: const Icon(CupertinoIcons.search),
                  title: Text('Trouver mon ticket', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp), ),
                  onTap: () { Get.to(const MyHistorique());},
                ),
                const SizedBox(
                  height: 5,
                ),
                ListTile(
                  shape: const Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),
                  ),  
                  leading: const Icon(CupertinoIcons.reply),
                  title: Text('Partagez',
                    style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                  ),
                  onTap: () {  share("vavavoom", "Vavavoom est une application de reservation de ticket de voyage","https://play.google.com/store/apps/details?id=com.onecall.vavavoum");
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox( height: 5,  ),
                // ${isLogin}
                Obx(() => isLogin==true && isAdmin==true
                  ?ListTile(
                        shape: const Border.symmetric(horizontal: BorderSide(width: 0.3, color: Color.fromARGB(141, 158, 158, 158)), ),
                        leading: const Icon(CupertinoIcons.qrcode_viewfinder),
                        title: Text('Scanner un ticker',style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),  ),
                        onTap: () {  Get.to(const DashboardView());},
                          
                        ): const SizedBox(height:0, ),

                  ),

                const SizedBox( height: 5, ),
                ListTile(
                  shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)), ),
                  leading: const Icon(CupertinoIcons.arrow_up_doc),
                  title: Text('Conditions générales d\'utilisation', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp), ),
                  onTap: () { launchInBrowser( Uri.parse("https://vavavoom.ci/condition_utilisation"));
                  },
                ),

                const SizedBox( height: 5,),

                Obx(() => isLogin==true
                 ?ListTile(
                          shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),  ),
                          leading: const Icon(CupertinoIcons.square_arrow_left),
                          title: Text('Deconnexion', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                          ),
                          onTap: () {
                            Get.to(const HomeView()); 
                            // authController.logout();
                          },
                        )
                        : ListTile(
                          shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),  ),
                          leading: const Icon(CupertinoIcons.person_add),
                          title: Text('Se connecter', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                          ),
                          onTap: () { 
                            Get.to(const AuthView());
                          // authController.logout();
                          },
                          )

                    
                    ),
          
                //   ListTile(
                //   shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),  ),
                //   leading: const Icon(CupertinoIcons.person_add),
                //   title: Text('Se connecter', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                //   ),
                //   onTap: () { Get.to(const AuthView());},
                // )
                
              ],
            ),
          );
  }

}
