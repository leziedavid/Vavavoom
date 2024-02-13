// import 'dart:developer';

// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:vavavoum/app/constant/Color.dart';
// import 'package:vavavoum/app/modules/ticket/views/searchResult.dart';
// import 'package:vavavoum/app/modules/ticket/views/ticket_view.dart';
// import 'package:vavavoum/app/widgets/Dialogs/dateDialog.dart';
// import 'package:vavavoum/app/widgets/Dialogs/dialog.dart';
// import 'package:vavavoum/app/widgets/Drawer.dart';
// import 'package:vavavoum/app/widgets/Inputs/InputCustom.dart';
// import 'package:vavavoum/app/widgets/Inputs/InputDate.dart';

// import '../controllers/home_controller.dart';

// enum Sky { midnight, viridian, cerulean }
// Map<Sky, Color> skyColors = <Sky, Color>{
//   Sky.midnight: const Color(0xff191970),
//   Sky.viridian: const Color(0xff40826d),
//   Sky.cerulean: const Color(0xff007ba7),
// };

// // class HomeView extends GetView<HomeController> {

// class HomeView extends StatefulWidget {
//   const HomeView({Key? key}) : super(key: key);
//   @override
// _HomeViewState createState() => _HomeViewState();
//     // static const routeName = '/search-result';  
// }

// class _HomeViewState extends State<HomeView> {
//   HomeController controller = Get.put(HomeController());

//   @override
//   void initState() {
//     super.initState();

//      welcome() {
//           if(controller.userName.value !="")
//           {
//             var names =controller.userName.value;
//             return Flushbar(
//                 titleText: Text("Bienvenue $names!",textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
//                 message: " ",
//                 duration: Duration(seconds: 3),
//                 backgroundColor: CustomColor.primary,
//                 flushbarPosition: FlushbarPosition.TOP,
//                 ).show(context);
//           }
//         }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get.put(HomeController()); // controller.onInit();
//     return Scaffold(
      
//       bottomSheet: GestureDetector(
//         onTap: () async {

//             if(controller.villeDepart.value.text == "") {
//                   return Flushbar(
//                     titleText: Text("Veuillez sélectionner une ville de départ",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
//                     message: " ",
//                     duration: Duration(seconds: 2),
//                     backgroundColor: Color.fromARGB(255, 163, 26, 26),
//                   ).show(context);

//                 }else if(controller.villeArrive.value.text == "")
//                   {
//                     return Flushbar(
//                         titleText: Text("Veuillez sélectionner une ville d'arrivée",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
//                         message: " ",
//                         duration: Duration(seconds: 2),
//                         backgroundColor: Color.fromARGB(255, 163, 26, 26),
//                         ).show(context);

//                   }else if(controller.dateDepart.value.text == "")
//                     {
//                       return Flushbar(
//                           titleText: Text("Veuillez sélectionner une date départ",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
//                           message: " ",
//                           duration: Duration(seconds: 2),
//                           backgroundColor: Color.fromARGB(255, 163, 26, 26),
//                       ).show(context);

//                     }else if(controller.optionSelect.value!=0 && controller.dateRetours.value.text == "")
//                       {
//                           return Flushbar(
//                               titleText: Text("Veuillez sélectionner une date de retour",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
//                               message: " ",
//                               duration: Duration(seconds: 3),
//                               backgroundColor: Color.fromARGB(255, 163, 26, 26),
//                           ).show(context);

//                       } 
//                         // else if(controller.optionSelect.value==1 && controller.dateRetours.value.text!=""){

//                         //     if(controller.dateRetours.value.text.compareTo(controller.dateDepart.value.text)<0){
//                         //       return Flushbar(
//                         //         titleText: Text("Date de retour invalide",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
//                         //         message: "La date de retour est inféreur à la de départ. ",
//                         //         duration: Duration(seconds: 2),
//                         //         backgroundColor: Color.fromARGB(255, 163, 26, 26),
//                         //         ).show(context);
//                         //     }

//                         // }

//                         else if(controller.transporteur.value.text == "")
//                           {
//                             return Flushbar(
//                                 titleText: Text("Veuillez sélectionner 1 ou 3 transporteurs",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
//                                 message: " ",
//                                 duration: Duration(seconds: 2),
//                                 backgroundColor: Color.fromARGB(255, 163, 26, 26),
//                                 ).show(context);

//                         }else{
//                                 // controller.dispose();
//                                controller.getTickets(controller.villeDepart.value.text,controller.villeArrive.value.text,controller.transporteur.value.text);
                      
//                                 if(controller.nb.value>0 && controller.listTickes.isNotEmpty){

//                                   Get.to(() => TicketView(data:TickeDataModel(
//                                       controller.villeDepart.value.text,
//                                       controller.villeArrive.value.text,
//                                       controller.transporteur.value.text,
//                                       controller.groupValue.value,
//                                       controller.dateDepart.value.text,
//                                       controller.dateRetours.value.text,
//                                       )));

//                                 }else{
                                  
//                                   Get.to(() => SearchResult(data:SearchDataModel(
//                                       controller.villeDepart.value.text,
//                                       controller.villeArrive.value.text,
//                                       controller.transporteur.value.text,
//                                       controller.groupValue.value,
//                                       controller.dateDepart.value.text,
//                                       controller.dateRetours.value.text,
//                                       )));
//                                   // openDialogSearchTicker(controller.villeDepart.value.text,controller.villeArrive.value.text,controller.transporteur.value.text);

//                                 }
                            
//                             }
    
//         },child: Container(
//           alignment: Alignment.center,
//           height: 50.h,
//           decoration: BoxDecoration(color: CustomColor.primary),
//           child: const Text( "RECHERCHER", style: TextStyle(fontSize: 18, color: Colors.white),
//           ),
//         ),
//       ),


//       appBar: AppBar(
//         elevation: 0,

//         leading: Builder(
//           builder: (context) => IconButton(icon: const Icon(Icons.menu),
//           color: Color.fromARGB(255, 255, 255, 255), onPressed: () => Scaffold.of(context).openDrawer(), ),
//         ),

//         title: Image.asset("assets/images/logo.png", height: 150.h,),
//         centerTitle: true, backgroundColor: CustomColor.primary,
//       ),

//       drawer: const DrawerCustom(),

//       body: ListView(

//         padding: EdgeInsets.only(bottom: 50.h),
//         children: [
//           Container(
//             height: 230.h,
//             constraints: const BoxConstraints(
//                 maxWidth: double.infinity, maxHeight: double.infinity),
//             child: Stack(
//               // fit: StackFit.expand,
//               children: [Image.asset("assets/images/banner.jpg",width: double.infinity, fit: BoxFit.cover, ),
//                 Positioned( bottom: 0.sp,  left: 0.sp,  right: 0.sp,
//                   child: Obx(
//                     () {
//                       return Container(
//                         decoration: const BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black45,
//                               offset: Offset(0, 2),
//                               blurRadius: 4,
//                             ),
//                           ],
//                         ),
//                         margin: EdgeInsets.symmetric(horizontal: 25.w),
//                         child: CupertinoSlidingSegmentedControl<int>(
//                           backgroundColor: CustomColor.primary,
//                           thumbColor: CupertinoColors.white,
//                           groupValue: controller.groupValue.value,
//                           children: {
//                             0: Container(
//                               height: 45.h,
//                               width: 150.w,
//                               decoration: BoxDecoration( borderRadius: BorderRadius.circular(30)),
//                               alignment: Alignment.center,
                              
//                               child: Text(controller.userName.value.toString(), style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.w700, color: controller.groupValue.value == 0 ? Colors.black: Colors.white),
                             
//                               ),
                               
//                             ),
//                             1: Container(
//                               height: 45.h,
//                               width: 150.w,
//                               decoration: BoxDecoration( borderRadius: BorderRadius.circular(30)),
//                               alignment: Alignment.center,
//                               child: Text( "Aller-Retour", style: TextStyle(  fontFamily: "poppins", fontWeight: FontWeight.w700,color: controller.groupValue.value == 1 ? Colors.black: Colors.white),
//                               ),
//                             ),
                            
//                           },
//                           onValueChanged: (value) {
//                             controller.isFirstOnglet.value = !controller.isFirstOnglet.value; 
//                             controller.groupValue.value = value!;
//                             controller.changeMyValue(value);
//                             log(value.toString());
//                             log(controller.groupValue.value.toString());
//                           },

//                         ),
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),

//           SizedBox(
//             height: 5.h,
//           ),
//           InputCustom( icon: Icons.map, controller: controller.villeDepart.value, text: "Ville de départ", 
//                onTap: () => openDialog(controller.villeDepart.value,controller.listVille,controller.villeArrive.value.text,"Ville de départ"),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//           Container(
//             margin: const EdgeInsets.only(left: 20),
//             alignment: Alignment.centerLeft, child: Icon( Icons.arrow_downward,color: CustomColor.primary,
//             ),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//           InputCustom(
//             icon: Icons.location_on,
//             controller: controller.villeArrive.value,
//             text: "Ville d'arrivée",
//             onTap: () => openDialog( controller.villeArrive.value, controller.listVille, controller.villeDepart.value.text,"Ville d'arrivée"),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//          Container(
//             margin: const EdgeInsets.only(left: 20),
//             alignment: Alignment.centerLeft, child: Icon( Icons.arrow_downward,color: CustomColor.primary,
//             ),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),

//           InputCustomDate(
//             icon: Icons.date_range, controller: controller.dateDepart.value,
//             text: "Date de depart",
//             callback: () => selectDate(controller, context),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),

//           Obx(
//             () => controller.loader.value
//                 ? InputCustomDate(
//                     icon: Icons.date_range, controller: controller.dateRetours.value,
//                     text: "Date de retour",
//                     callback: () => selectDate2(controller, context),
//                   )
//                 : SizedBox(
//                     height: 0.h,
//                   ),
//           ),

//         Container(
//             margin: const EdgeInsets.only(left: 20),
//             alignment: Alignment.centerLeft, child: Icon( Icons.arrow_downward,color: CustomColor.primary,
//             ),
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//           InputCustom( icon: Icons.car_repair_outlined,controller: controller.transporteur.value,text: "Tansporteur (optionnel)",
//             // maxLines: 2,
//             onTap: () => openDialogTransporteur(controller.transporteur.value,controller.listTransporteur, "", "Transporteur"),
//           ),
//            SizedBox(
//             height: 10.h,
//           ),
//         ],
//       ),
//       );

//   }
// }
