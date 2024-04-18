
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/home/controllers/home_controller.dart';
import 'package:vavavoom/app/modules/ticket/views/ticket_view.dart';

import '../controllers/ticket_controller.dart';

class TickeMessagesPages {
  String ville_depart;
  String ville_arriver;
  String transporteur;
  int typeVoyage;
  String dateAller;
  String dateRetour;

  TickeMessagesPages(
    this.ville_depart,
    this.ville_arriver,
    this.transporteur,
    this.typeVoyage,
    this.dateAller,
    this.dateRetour

    );
}

class MessagesPages extends GetView<TicketController> {
  
final TickeMessagesPages? data;

  const MessagesPages({ Key? key, this.data, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    return Scaffold(

      appBar: AppBar(
           title: data!.typeVoyage==0 ?
           Text("${data!.ville_depart} -> ${data!.ville_arriver}",style: TextStyle(fontFamily: "poppins",fontSize: 13.sp, color: Color.fromARGB(255, 255, 255, 255)))
           :Text("${data!.ville_depart} -> ${data!.ville_arriver} -> ${data!.ville_depart}",style: TextStyle(fontFamily: "poppins",fontSize: 13.sp, color: Color.fromARGB(255, 255, 255, 255))),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton(
            onPressed: ()  { Navigator.of(context).pop(); },
              icon: Icon(Icons.arrow_back_sharp,color: Colors.white,),
            ),
        ),

      body:Container(
        child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // si nous avons trouver

                  Obx( () => controller.isDonnees.value==true && controller.nb.value==0 ?
                      Container( height: 250, decoration: BoxDecoration(image: DecorationImage( image: AssetImage("assets/images/bus.png"), fit: BoxFit.contain ) ),)
                      :SizedBox( height: 0.h,),),

                      Obx( () =>  controller.isDonnees.value==true && controller.nb.value==0 ?
                      Container( margin: EdgeInsets.all(15),child: Text("Plus de départ disponible aujourd'hui!\n Vous pouvez réserver pour demain", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),)
                        ) :SizedBox( height: 0.h,)),
                      // Le bouton
                      Obx( () => controller.isDonnees.value==true ?
                        ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 255, 2, 2),
                                // primary: Color.fromARGB(255, 255, 2, 2),
                                shape: StadiumBorder(), ),
                                onPressed: () {
                                  Get.to(() => TicketView(
                                      data:TickeDataModel(
                                          data!.ville_depart,
                                          data!.ville_arriver,
                                          data!.transporteur,
                                          data!.typeVoyage,
                                          data!.dateAller,
                                          data!.dateRetour
                                        ) )
                                      );
                                },
                                icon: const Icon(Icons.search,color: Color.fromARGB(255, 255, 255, 255),size: 30,),
                                label: const Text("Voir les depart de demain", style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold) ),
                            )
                          :SizedBox( height: 0.h,),
                      ),

                    // si nous avons rien trouver

                    Obx( () => controller.isDonnees.value==false?
                  
                      Container( height: 250, decoration: BoxDecoration(image: DecorationImage( image: AssetImage("assets/images/bus.png"), fit: BoxFit.contain )),)
                     
                      :SizedBox( height: 0.h,),),

                    Obx( () =>  controller.isDonnees.value==false?
                      Container(margin: EdgeInsets.all(15),
                        child: Text("Aucun itinéraire ne correspond à vos choix. Veuillez choisir une autre destination.", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),)
                      ) :SizedBox( height: 0.h,)),

                  ],
            )
            
          )

    );
  }


  Future<void>_dialogBuilder(BuildContext context) {

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
                                      onPressed: () { Navigator.of(context).pop(); },
                                      child: Text("Fermer", style: TextStyle(fontSize: 20)) 
                                      )    
                                )
                              // Center( child: CircularProgressIndicator(), )
                            ],
                          ),
                      ),
                  );
           },

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
    return true;
  }

}
