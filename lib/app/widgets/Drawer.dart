import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/Fonctions/lancherUrl.dart';
import 'package:vavavoom/app/Fonctions/share.dart';
import 'package:vavavoom/app/modules/home/views/home_view.dart';

import '../../app/modules/auth/controllers/auth_controller.dart';
import '../../app/modules/home/controllers/home_controller.dart';
import '../../app/modules/ticket/controllers/ticket_controller.dart';
import '../constant/Color.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/partenaire/views/partenaire_view.dart';
import '../modules/ticket/views/MyHistorique.dart';
import '../modules/ticket/views/history_ticket_view.dart';

// class DrawerCustom extends StatelessWidget {

class DrawerCustom extends StatefulWidget {

  const DrawerCustom({

    Key? key,

  }) : super(key: key);

  @override
  DrawerState createState() => new DrawerState();
  }

class DrawerState extends State<DrawerCustom> {

  Widget build(BuildContext context) {

        HomeController homeController = Get.put(HomeController());
        TicketController ticketController = Get.put(TicketController());
        AuthController authController = Get.put(AuthController());
        
        homeController.onInit();
        ticketController.onInit();
        authController.onInit();


    final states = authController.checkLoginStatus();

          return Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
              Container( height: 100.h,color: CustomColor.primary, ),
              const SizedBox(  height: 5, ),
              Obx(() => authController.isAdmin.value==false && authController.isUsers.value==true
                   ?ListTile(
                      // dense: true,
                      shape: const Border.symmetric( horizontal: BorderSide(width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),),
                      leading: const Icon(CupertinoIcons.tickets),
                      title: Text( 'Achetez un ticket', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                      ),
                      onTap: () {
                          Navigator.of(context).pop();
                          Get.to( const HomeView()); 
                         },
                    ): const SizedBox(height:0, ),
               ),

              const SizedBox( height: 5, ),

               Obx(() => authController.isAdmin.value==false && authController.isLogin==true && authController.statusLogin==1 && authController.isUsers.value==true
               
                     ?ListTile( shape: const Border.symmetric(horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)), ),
                      leading: const Icon(CupertinoIcons.refresh_circled),
                      title: Text( 'Mes tickets',style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),),
                      onTap: () {  Get.to(const HistoryTicketView(),); ticketController.getData(); },
                    ): const SizedBox(height:0, ),
                  ),


                const SizedBox( height: 5,),
                 Obx(() => authController.isAdmin.value==false
                  ? ListTile(
                      shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)), ),
                      leading: const Icon(CupertinoIcons.bus),
                      title: Text('Nos partenaires', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),),
                      onTap: () { Get.to(const PartenaireView()); },
                    ): const SizedBox(height:0, ),
                ),

                const SizedBox( height: 5, ),
                Obx(() => authController.isAdmin.value==false && authController.isUsers.value==true

                    ?ListTile(
                        shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),),
                        leading: const Icon(CupertinoIcons.search),
                        title: Text('Trouver mon ticket', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp), ),
                        onTap: () { Get.to(const MyHistorique());},
                      ): const SizedBox(height:0, ),
                   ),

                const SizedBox( height: 5, ),
                ListTile(
                  shape: const Border.symmetric(
                    horizontal: BorderSide(
                        width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),
                  ),
                  leading: const Icon(CupertinoIcons.reply),
                  title: Text('Partagez',
                    style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                  ),
                  onTap: () {  share("vavavoom", "Vavavoom est une application de reservation de ticket de voyage","https://play.google.com/store/apps/details?id=com.onecall.vavavoom");
                  },
                ),
                const SizedBox( height: 5, ),

                Obx(() => authController.isAdmin.value==true && authController.isLogin==true && authController.statusLogin==1

                    ?ListTile(
                        shape: const Border.symmetric(horizontal: BorderSide(width: 0.3, color: Color.fromARGB(141, 158, 158, 158)), ),
                        leading: const Icon(CupertinoIcons.qrcode_viewfinder),
                        title: Text('Scanner un ticker',style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),  ),
                        onTap: () {
                           Navigator.of(context).pop();
                           Get.to(const DashboardView());},
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

                Obx(() => authController.isLogin.value==true && authController.statusLogin==1
                      ?  ListTile(
                          shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),  ),
                          leading: const Icon(CupertinoIcons.square_arrow_left),
                          title: Text('Deconnexion', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                          ),
                          onTap: () {
                            Get.to(const HomeView()); authController.logout();
                          },
                        )

                      : ListTile(
                          shape: const Border.symmetric( horizontal: BorderSide( width: 0.3, color: Color.fromARGB(141, 158, 158, 158)),  ),
                          leading: const Icon(CupertinoIcons.person_add),
                          title: Text('Se connecter', style: TextStyle(fontFamily: "poppins", fontSize: 16.sp),
                          ),
                          onTap: () { Get.to(const AuthView());authController.logout();},
                          )
                    ),
        
                
              ],
            ),
          );
  }

}
