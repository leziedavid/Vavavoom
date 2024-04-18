import 'dart:async';

import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/home/views/home_view.dart';
import 'package:vavavoom/app/modules/ticket/views/PdfFiles.dart';
import 'package:vavavoom/app/widgets/Cards/QrImageViews.dart';

import '../controllers/ticket_controller.dart';

class DataModelTickes {

  int pays;
  String typeVoyage;
  String villeArriver;
  String villeDepart;
  String transporteur;
  String gare;
  String heure;
  String dateAller;
  String dateRetour;
  String tarif;
  String referenceTicket;
  String code;
  String transactionId;
  String nbreticket;
  String username;
  String userId;
  String statut;

  DataModelTickes(
  this.pays,
  this.typeVoyage,
  this.villeArriver,
  this.villeDepart,
  this.transporteur,
  this.gare,
  this.heure,
  this.dateAller,
  this.dateRetour,
  this.tarif,
  this.referenceTicket,
  this.code,
  this.transactionId,
  this.nbreticket,
  this.username,
  this.userId,
  this.statut,
    );
}

class ModelTickesViews extends GetView<TicketController> {
  final DataModelTickes? data;
  

  const ModelTickesViews({ Key? key,this.data, }) : super(key: key);

  @override

  

  Widget build(BuildContext context) {



  final phone = TextEditingController();

  // String chaine = "partie1/partie2";
  List<String> parties =data!.username.split('/');

   String nomPrenom = parties[0]; // Première partie
   String tel = parties[1]; // Deuxième partie


  ScrollController scollBarController = ScrollController();
  Get.put(TicketController());
  controller.onInit();
  // TicketController ticketController = TicketController();

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

 final dateDeb=DateFormat("dd-MM-yyyy").format(DateTime.parse(data!.dateAller.toString()));

  final timers =Timer(Duration(seconds: 0), () { data!.pays>0?_dialogBuilder(context):SizedBox( height: 0.h,);});

  return Scaffold(
    
      appBar: AppBar(
          title:  Text('vavavoom e-Ticket',style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: data!.pays>0 ?
           IconButton(onPressed: (){ timers.cancel();Get.to( const HomeView()); data!.pays=0; },icon: Icon(Icons.arrow_back_sharp, color: Colors.white,),)
           :IconButton(onPressed: (){timers.cancel();Navigator.pop(context); data!.pays=0; },icon: Icon(Icons.arrow_back_sharp, color: Colors.white,),),
        ),

      body: Container(
        color: Color.fromARGB(255, 255, 254, 254),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
                  Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0) ),
                    elevation: 4,

                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                       children: [
                         SizedBox( height: 10.h,),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child:Text( "${data!.villeDepart}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
                                    ),
                                
                                  Column(
                                    children: [
                                       Icon( Icons.bus_alert_sharp,color: CustomColor.primary, ),
                                       Text( "${data!.typeVoyage}",style: TextStyle(fontFamily: "poppins",  fontSize: 15.sp, color: CustomColor.primary), ),
                                      ],
                                  ),

                                    Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child:Text("${data!.villeArriver}",style: TextStyle(  fontSize: 15.sp,  fontFamily: 'poppins'),),
                                    ),
                                  ],
                          ),
                            // SizedBox( height: 10.h,),

                              Hero(
                                tag: "ticket",
                                child: GestureDetector(
                                  onTap: () { },
                                  
                                  child: ClipPath(
                                    clipper: const ClipPathModule1(heigth: 2),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric( vertical: 20, horizontal: 20),
                                        height: 450.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                              // SizedBox( height: 30.h,),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Companie", style: TextStyle(fontSize: 15.sp,fontFamily: 'poppins'),),
                                                    ],
                                                  ),
                                                  Text("${data!.transporteur}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'),
                                                  )
                                                ]
                                              ),
                                              const Divider(height: 0,thickness: 2,indent: 0,endIndent: 0,color: Colors.black, ),
                                              Container(
                                                child:Column(
                                                    children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                          Row( children: [ Text("Gare :", style: TextStyle( fontSize: 15.sp),),], ),
                                                          Text("${data!.gare}",style: TextStyle(fontSize: 15.sp),)
                                                          ]
                                                          ),

                                                          SizedBox( height: 10.h,),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                Row( children: [Text("Code ticket", style: TextStyle( fontSize: 15.sp),),],  ),
                                                                Row( children: [ Text("Voyageur(s)", style: TextStyle( fontSize: 15.sp),),], ),
                                                                
                                                                ]
                                                            ),
                                                            SizedBox(height: 0.h,),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                
                                                                  Container(
                                                                      margin: EdgeInsets.only(left: 20),
                                                                      child:controller.adminConnecte==true? Text("******",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'),)
                                                                          :Text("${data!.code}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'),),
                                                                    ),

                                                                  Container(
                                                                      margin: EdgeInsets.only(right: 20),
                                                                      child:Text( "${data!.nbreticket}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
                                                                  ),

                                                                  ]
                                                            ),
                                                          
                                                           SizedBox( height: 10.h,),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                Row( children: [Text("Heure de dépard", style: TextStyle( fontSize: 15.sp),),],  ),
                                                                Row( children: [ Text("Date de départ", style: TextStyle( fontSize: 15.sp),),], ),
                                                                
                                                                ]
                                                            ),
                                                            SizedBox( height: 0.h,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                  Container(
                                                                      margin: EdgeInsets.only(left: 18),
                                                                      child:Text("${data!.heure}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
                                                                    ),

                                                                  Container(
                                                                      margin: EdgeInsets.only(right: 13), 
                                                                      child:Text("${dateDeb!}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
                                                                    ),
                                                                    
                                                                  // Container(
                                                                  //     margin: EdgeInsets.only(right: 13), 
                                                                  //     child:Text("${controller.adminGare}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
                                                                  //   ),
                                                                  
                                                                  ]
                                                            ),
                                                          
                                                          SizedBox( height: 20.h,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                Row( children: [Text("Télephone :", style: TextStyle( fontSize: 15.sp),),],  ),
                                                                Row( children: [Text("${tel}", style: TextStyle( fontSize: 15.sp,fontWeight: FontWeight.w700),),], ),
                                                                
                                                                ]
                                                            ),
                                                          
                                                          SizedBox( height: 10.h,),
                                                          DottedDashedLine(height: 50,dashColor: Colors.grey, width:MediaQuery.of(context).size.width - 105.w, axis: Axis.horizontal),
                                                          controller.adminConnecte.value?SizedBox(height:0.h,)
                                                          :QrImageViews(url:"${data!.referenceTicket}"),
                                                        
                                                      ],
                                                   ),
                                                  
                                              
                                              ),
                                               SizedBox( height: 10.h,),
                                                   controller.adminConnecte.value?SizedBox(height:0.h,):
                                                   GestureDetector(
                                                     onTap: () { Get.to(PdfFiles(
                                                      // id:data!.id,
                                                      typeVoyage:data!.typeVoyage,
                                                      villeArriver:data!.villeArriver,
                                                      villeDepart:data!.villeDepart,
                                                      transporteur:data!.transporteur,
                                                      gare:data!.gare,
                                                      heure:data!.heure,
                                                      dateAller:data!.dateAller,
                                                      dateRetour:data!.dateRetour,
                                                      tarif:data!.tarif,
                                                      referenceTicket:data!.referenceTicket,
                                                      code:data!.code,
                                                      transactionId:data!.transactionId,
                                                      nbreticket:data!.nbreticket,
                                                      username:data!.username,
                                                      userId:data!.userId,
                                                     )); },
                                                      
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.symmetric(vertical: 10.h),
                                                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                                                      decoration: BoxDecoration( borderRadius: BorderRadius.circular(0),color: CustomColor.primary),
                                                      child: const Text("Télecharger le ticket",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                
                                
                                ),
                              )
                          ],

                      )
                    
                  ),
          ],
        ),
      ),
    );
 
  }

}

  Future<void> _dialogBuilder(BuildContext context) {

        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                   content: Container(
                      height: 230.h,
                        child: Column(
                            children: [
                              Text("Félicitations,....",textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 20.sp,fontWeight: FontWeight.w700)),
                              Icon(Icons.check_circle_outline_sharp, size: 80.0,color: Colors.green,),
                              Text("Le paiement a été effectué avec succès ...",textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 18.sp,fontWeight: FontWeight.w700)),
                              SizedBox( height: 10.h,),
                              SizedBox(
                                  width: 200,
                                  height: 58,
                                     child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); 
                                      },
                                      child: Text("Fermer", style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 236, 0, 0) , fontWeight: FontWeight.w700))
                                    )
                                )
                            ],
                          ),
                      ),
                  );
           },

          );
 
      }

class ClipPathModule1 extends CustomClipper<Path> {
  final double heigth;
  final double? raduis;

  const ClipPathModule1({
    required this.heigth,
    this.raduis = 25,
  });
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.addOval(Rect.fromCircle(
        center: Offset(0, size.height / heigth), radius: raduis!));
    path.addOval(Rect.fromCircle(
      center: Offset(size.width, size.height / heigth),
      radius: raduis!,
    ));
    path.fillType = PathFillType.evenOdd;
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
