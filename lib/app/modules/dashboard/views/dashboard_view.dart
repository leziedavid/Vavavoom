// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/ticket/controllers/ticket_controller.dart';
import 'package:vavavoom/app/widgets/Drawer.dart';
import 'package:vavavoom/app/widgets/dashboard/CardDashboard.dart';

import '../controllers/dashboard_controller.dart';


class NotificationData {
  String id;
  String title;
  String transporteur;

  NotificationData(
      this.id,
      this.title,
      this.transporteur,
    );
}

class DashboardView extends StatefulWidget {
    final NotificationData? data;
    const DashboardView({ Key? key,this.data,}) : super(key: key);
    @override
    State<DashboardView> createState() => _DashboardViewState();
  }

class _DashboardViewState extends State<DashboardView> {
  // NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {

    super.initState();
    // notificationServices.requestNotificationPermission();
    // notificationServices.forgroundMessage();
    // notificationServices.firebaseInit(context);
    // notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();

    // notificationServices.getDeviceToken().then((value){
    //   if (kDebugMode) {
    //     print('device token');
    //     print(value);
    //   }
    // });
    
  }
  @override

  Widget build(BuildContext context) {

      DashboardController dashboardController = Get.put(DashboardController());
   TicketController ticketController = Get.put(TicketController());
      ticketController.onInit();
      // AuthController authController = Get.put(AuthController());
      dashboardController.onClose();
      dashboardController.onInit();

  // final states = authController.checkAdminLoginStatus();
  // final dateCheck = DateFormat("dd-MM-yyyy").format(DateTime.parse(controller.listeticketByScanner[0]!.dateAller.toString()));

    return Scaffold(

          appBar: AppBar(
              elevation: 0,
              leading: Builder(
                  builder: (context) => IconButton(icon: const Icon(Icons.menu),
                  color: Color.fromARGB(255, 255, 255, 255), onPressed: () => Scaffold.of(context).openDrawer(), ),
                ),
                title: Image.asset("assets/images/logovavavoom-01.jpg", height: 150.h,  ),
                centerTitle: true, backgroundColor: CustomColor.primary,
              ),

            drawer: const DrawerCustom(),
            
            body: CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (builder, context) {
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Text("Espace d'Administration !",style: TextStyle(fontFamily: "poppins", fontSize: 20.sp,  ),),
                            ticketController.adminGare=="null" ? Text('Transporteur',style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.w700,fontSize: 23.sp, color: Color(0xffc40619)) ):
                            Text('${ticketController.adminGare}',style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.w700,fontSize: 23.sp, color: Color(0xffc40619)) ),Icon(CupertinoIcons.bus,size: 40,color:CustomColor.primary),
                            
                            const SizedBox( height: 10,),
                            const  Divider(height: 0),
                              const ListTile(
                                leading: CircleAvatar(child: Icon(CupertinoIcons.tickets,size: 40)), title: Text('Pour afficher la liste des tickets du jour'),
                                subtitle: Text( "Cliquez sur la case bleu",style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins", color: Colors.blueAccent)),
                                isThreeLine: true,
                              ),
                            const Divider(height: 0),
                            const SizedBox( height: 20,),

                            const  Divider(height: 0),
                              const ListTile(
                                leading: CircleAvatar(child: Icon(CupertinoIcons.camera,size: 40)),
                                title: Text('Pour vérifier un ticket avec Qrcode,'),
                                subtitle: Text( "Cliquez sur la case verte.",style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",color:Colors.green )),
                                isThreeLine: true,
                              ),
                            const Divider(height: 0),
                            const SizedBox( height: 20,),

                            const  Divider(height: 0),
                              const ListTile(
                                leading: CircleAvatar(child: Icon(CupertinoIcons.add,size: 40)),
                                title: Text('Pour vérifier un ticket avec le code à 4 chiffres,'),
                                subtitle: Text( "Cliquez sur la case orange.",style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins", color: Color.fromARGB(255, 249, 153, 50))),
                                isThreeLine: true,
                              ),
                            const Divider(height: 0),
                            const SizedBox( height: 10,),

                              Obx( () => ticketController.actions.value==true && ticketController.statutTicket.value == 0  && ticketController.etape.value == true ?
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                      Hero(
                                        tag: 'ListTile-Hero',
                                        child: Material(
                                             child: ListTile(
                                              title: const Text('Ticket valide !',textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins", fontSize:18, color:Colors.red )),
                                              // subtitle:  Text("--- Jusqu'au ${dateCheck} à ${controller.listeticketByScanner[0].heure} --- ${controller.listeticketByScanner[0].typeVoyage}",textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",color:Color.fromARGB(255, 255, 255, 255) )),
                                              // subtitle: const Text('Scanner à nouveau pour confirmer le ticket',textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",color:Color.fromARGB(255, 255, 255, 255) )),
                                              
                                              tileColor: Colors.green,
                                              onTap: () { },
                                            ),
                                        ),
                                      ),
                                  ],
                              ) :const SizedBox( height: 0,),
                            ),
                              const SizedBox( height: 0,),
                              Obx( () => ticketController.actions.value==true && ticketController.statutTicket.value == 1  && ticketController.etape.value == true  ?
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                      Hero(
                                        tag: 'ListTile-Hero',
                                        child: Material(
                                             child: ListTile(
                                              title: const Text('Ticket Expiré!',textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",fontSize:18,color:Color.fromARGB(255, 255, 255, 255) )),
                                              subtitle: const Text("Ce ticket a été déja utilisé pour un voyage",textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",color:Color.fromARGB(255, 255, 255, 255) )),
                                              tileColor: Colors.red,
                                              onTap: () { },
                                            ),
                                        ),
                                      ),
                                  ],
                                ) :const SizedBox( height: 0,),
                              ),

                              const SizedBox( height: 0,),
                              Obx( () => ticketController.actions.value==true && ticketController.statutTicket.value == 5  && ticketController.etape.value == true ? 
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  
                                  children: <Widget>[
                                      Hero(
                                        tag: 'ListTile-Hero',
                                        child: Material(
                                             child: ListTile(
                                              title: const Text('Date de voyage invalide !',textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",fontSize:18,color:Color.fromARGB(255, 255, 255, 255) )),
                                              subtitle: const Text("La date de voyage de ce ticket ne correspond pas à la date d'aujourd'hui",textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",color:Color.fromARGB(255, 255, 255, 255) )),
                                              tileColor: Colors.red,
                                              onTap: () { },
                                            ),
                                        ),
                                      ),
                                  ],
                                ) :const SizedBox( height: 0,),
                              ),
                              const SizedBox( height: 0,),
                              Obx( () => ticketController.actions.value==true && ticketController.statutTicket.value == 6  && ticketController.etape.value == true ? 
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  
                                  children: <Widget>[
                                      Hero(
                                        tag: 'ListTile-Hero',
                                        child: Material(
                                             child: ListTile(
                                              title: const Text('Désolé !',textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",fontSize:18,color:Color.fromARGB(255, 255, 255, 255) )),
                                              subtitle: const Text("Ce ticket n'est pas pour vous",textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",color:Color.fromARGB(255, 255, 255, 255) )),
                                              tileColor: Colors.red,
                                              onTap: () { },
                                            ),
                                        ),
                                      ),
                                  ],
                                ) :const SizedBox( height: 0,),
                              ),
                              const SizedBox( height: 0,),
                              Obx( () => ticketController.actions.value==true && ticketController.statutTicket.value == 2  && ticketController.etape.value == true ? 
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  
                                  children: <Widget>[
                                      Hero(
                                        tag: 'ListTile-Hero',
                                        child: Material(
                                             child: ListTile(
                                              title: const Text("CodeQr incorrect !",textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",fontSize:18,color:Color.fromARGB(255, 255, 255, 255) )),
                                              subtitle: const Text("Le CodeQr du ticket est incorrect",textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",color:Color.fromARGB(255, 255, 255, 255) )),
                                              tileColor: Colors.red,
                                              onTap: () { },
                                            ),
                                        ),
                                      ),
                                  ],
                                ) :const SizedBox( height: 0,),
                              ),

                            // Center(
                            //   child: TextButton(
                            //       onPressed: () {
                            //         // send notification from one device to another
                            //         notificationServices.getDeviceToken().then((value) async {
                            //           var data = {
                            //             'to': value.toString(),
                            //             'notification': {
                            //               'title': 'Asif',
                            //               'body': 'Subscribe to my channel',
                            //               "sound": "jetsons_doorbell.mp3"
                            //             },
                            //             'android': {
                            //               'notification': {
                            //                 'notification_count': 23,
                            //               },
                            //             },
                            //             'data': {'type': 'msj', 'id': 'Asif Taj'}
                            //           };

                            //           await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),body: jsonEncode(data),
                            //               headers: { 'Content-Type': 'application/json; charset=UTF-8','Authorization':'key=AAAAp9pXDFM:APA91bGhBeMCUABE2PXjl9UqodAZ2WdV_UI6PoiwdCzYaT8KeZmBKZszc01CD1GgN0OAJ1w3sNw9IVISyKhrrxQLASHizenGJUr2hjzoPjbjFu0HAx1CTk0l8Ut95ZENAQyRKm6hrltV'
                            //               }).then((value) {

                            //             if (kDebugMode) {
                            //               print(value.body.toString());
                            //             }
                            //           }).onError((error, stackTrace) {

                            //             if (kDebugMode) {
                            //               print(error);
                            //             }
                                        
                            //           });
                            //         });
                            //       },
                            //       child: Text('Send Notifications')),
                            // ),
                            
                            const SizedBox( height: 18, ),
                              GridView.count(
                              crossAxisCount: 3,
                              shrinkWrap: true,
                              crossAxisSpacing: 20,
                              children: const [
                                CardDashboard(
                                    color: Colors.blue,
                                    icon: CupertinoIcons.ticket,
                                    text: "Afficher les tickers",
                                    link: 1,
                                    etape: 1,
                                    ),
                                CardDashboard(
                                    color: Colors.green,
                                    icon: CupertinoIcons.camera,
                                    text: "Scanner un Qrcode",
                                    link: 0,
                                    etape: 0,
                                    ),
                                CardDashboard(
                                    color: Color.fromARGB(255, 249, 153, 50),
                                    icon: CupertinoIcons.add,
                                    text: "Vérifier un code",
                                    link: 1,
                                    etape: 2,
                                    ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),

       );
    }

}