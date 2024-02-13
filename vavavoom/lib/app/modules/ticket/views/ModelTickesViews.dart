import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vavavoum/app/constant/Color.dart';
import 'package:vavavoum/app/modules/ticket/views/PdfFiles.dart';
import 'package:vavavoum/app/widgets/Cards/QrImageViews.dart';

// import 'package:flutter/services.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';

import '../controllers/ticket_controller.dart';

class DataModelTickes {

  // int id;
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

  DataModelTickes(
  // this.id,
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
    );
}

class ModelTickesViews extends GetView<TicketController> {
  final DataModelTickes? data;

  const ModelTickesViews({ Key? key,this.data, }) : super(key: key);

  @override

  Widget build(BuildContext context) {



  final phone = TextEditingController();
  Get.put(TicketController());

  ScrollController scollBarController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

 final dateDeb=DateFormat("dd-MM-yyyy").format(DateTime.parse(data!.dateAller.toString()));
// final dateRet=DateFormat("dd-MM-yyyy").format(DateTime.parse(data!.dateRetour.toString()));

  return Scaffold(

      appBar: AppBar(
          title:  Text('Vavavoum e-Ticket',style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton(onPressed: (){ Navigator.pop(context); },icon: Icon(Icons.arrow_back_sharp, color: Colors.white,),),
        ),

      body: Container(
        color: Color.fromARGB(255, 255, 254, 254),
        
        child: ListView(
          padding: const EdgeInsets.all(15),

          children: [
            //  SizedBox( height: 8.h,),
                  Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0) ),
                    elevation: 4,

                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                       children: [
                         SizedBox( height: 20.h,),
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
                            SizedBox( height: 30.h,),

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
                                                            SizedBox( height: 0.h,),

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                                
                                                                  Container(
                                                                      margin: EdgeInsets.only(left: 20),
                                                                      child:Text( "${data!.code}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
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
                                                                      
                                                                      child:Text( "${data!.heure}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
                                                                  ),

                                                                  Container(
                                                                      margin: EdgeInsets.only(right: 13), 
                                                                      child:Text("${dateDeb!}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
                                                                    ),
                                                                    
                                                                  // Container(
                                                                  //     margin: EdgeInsets.only(right: 13), 
                                                                  //     child:Text("${data!.dateAller!}",style: TextStyle(fontSize: 15.sp, fontFamily: 'poppins'), ),
                                                                  //   ),
                                                                  
                                                                  ]
                                                            ),
                                                          SizedBox( height: 20.h,),
                                                          DottedDashedLine( height: 50,  dashColor: Colors.grey, width:MediaQuery.of(context).size.width - 105.w, axis: Axis.horizontal),
                                                          QrImageViews(url:"${data!.referenceTicket}"), 
                                                      ],
                                                   ),
                                                  
                                              
                                              ), 
                                               SizedBox( height: 10.h,),
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
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(0),color: CustomColor.primary),
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
