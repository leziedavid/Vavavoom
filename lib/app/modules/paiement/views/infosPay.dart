import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';

import '../controllers/paiement_controller.dart';

class InfosPayDataModel {

  String depart;
  String arriver;
  String transporteur;
  String gare;
  String dateAller;
  String dateRetour;
  int prix;
  String heureDepart;
  String nombreTicket;
  int typeVoyage;
  String image;
  int remise;
  

  InfosPayDataModel(
    this.depart,
    this.arriver,
    this.transporteur,
    this.gare,
    this.dateAller,
    this.dateRetour,
    this.prix,
    this.heureDepart,
    this.nombreTicket,
    this.typeVoyage,
    this.image,
    this.remise,
   
  );
}

class InfosPay extends GetView<PaiementController> {
final InfosPayDataModel? data;

const InfosPay({ Key? key,this.data, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Vue des paiements',style: TextStyle(fontFamily: "poppins",fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
        //  style : TextStyle (couleur : const Color.fromARGB(255, 255, 255, 255)),
        centerTitle: true,
        backgroundColor: CustomColor.primary,
        
      ),
      body: Container(
        color: const Color.fromARGB(255, 225, 225, 225),
        child: ListView(
          padding: EdgeInsets.all(10.sp),
          children: [
            
            const Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "TOTAL", style: TextStyle(fontFamily: "popins", fontSize: 20.sp), ),
                Text( "${data!.prix} Fcfa", style: TextStyle(fontFamily: "popins", fontSize: 20.sp),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),

            Container(
              alignment: Alignment.center,
              child: Text( "Choisissez votre moyen de paiement", textAlign: TextAlign.center, style: TextStyle( fontWeight: FontWeight.w700, fontFamily: "poppins", fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),

          ],
        ),
      ),
    );
  }
}
