import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/widgets/Cards/CardPaiement.dart';

import '../controllers/paiement_controller.dart';


class PaiementDataModel {

  String depart;
  String arriver;
  String transporteur;
  String gare;
  String dateAller;
  String dateRetour;
  String prix;
  String heureDepart;
  String nombreTicket;
  int typeVoyage;
  String image;
  int remise;
  

  PaiementDataModel(
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

class PaiementView extends GetView<PaiementController> {
final PaiementDataModel? data;

const PaiementView({ Key? key,this.data, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Text('Vue des paiements',style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton( onPressed: (){ Navigator.pop(context); }, icon: Icon(Icons.arrow_back_sharp,color: Colors.white,), ),
      ),

      body: Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          padding: EdgeInsets.all(10.sp),
          children: [
          // const Divider(  color: Colors.grey,  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "TOTAL", style: TextStyle(fontFamily: "popins", fontSize: 18.sp,fontWeight: FontWeight.w700), ),
                Text( "${data!.prix} Fcfa", style: TextStyle(fontFamily: "popins", fontSize: 18.sp,fontWeight: FontWeight.w700),
                ),
              ],
            ),

            const  Divider(height: 1),

            Card(
              color: const Color.fromARGB(255, 255, 255, 255) ,
              child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child:Icon(CupertinoIcons.antenna_radiowaves_left_right),
                      ),
                      title: const Text('Choisissez votre moyen de paiement'),
                    ),
                  ),

            // const ListTile( leading: CircleAvatar(child: Icon(CupertinoIcons.antenna_radiowaves_left_right)),
            //    title: Text('Choisissez votre moyen de paiement', style: TextStyle(fontSize: 18,)),
            //   ),
            const  Divider(height: 1),

             CardPaiement(

                  reseauText: "Orange",colorBtn: Color.fromARGB(255, 255, 119, 0), 
                  backagroundColor: Color.fromARGB(189, 255, 153, 0),
                  circleColor: Color.fromARGB(255, 255, 119, 0),
                  logos:"assets/images/Orangemoney.jpg",
                  depart:data!.depart,
                  arriver:data!.arriver,
                  transporteur:data!.transporteur,
                  gare:data!.gare,
                  dateAller:data!.dateAller,
                  dateRetour: data!.dateRetour,
                  prix: data!.prix,
                  heureDepart:data!.heureDepart,
                  nombreTicket:data!.nombreTicket,
                  typeVoyage:data!.typeVoyage,
                  image:data!.image,
                  remise:data!.remise,

            ),
            SizedBox(
              height: 20.h,
            ),
             CardPaiement(
              reseauText: "MTN",
              colorBtn: Color.fromARGB(255, 237, 166, 12), 
              backagroundColor: Color.fromARGB(158, 255, 235, 59), 
              circleColor: Color.fromARGB(246, 255, 224, 112),
              logos:"assets/images/mtn.jpg",
              depart:data!.depart,
              arriver:data!.arriver,
              transporteur:data!.transporteur,
              gare:data!.gare,
              dateAller:data!.dateAller,
              dateRetour: data!.dateRetour,
              prix: data!.prix,
              heureDepart:data!.heureDepart,
              nombreTicket:data!.nombreTicket,
              typeVoyage:data!.typeVoyage,
              image:data!.image,
              remise:data!.remise,

            ),
            SizedBox(
              height: 20.h,
            ),
             CardPaiement( reseauText: "WAVE",
             colorBtn: Color(0xff11B0E2),
             backagroundColor: Color.fromARGB(114, 17, 177, 226),
             circleColor: const Color(0xff11B0E2),
             logos:"assets/images/wave.png",
             depart:data!.depart,
             arriver:data!.arriver,
             transporteur:data!.transporteur,
             gare:data!.gare,
             dateAller:data!.dateAller,
             dateRetour: data!.dateRetour,
             prix: data!.prix,
             heureDepart:data!.heureDepart,
             nombreTicket:data!.nombreTicket,
             typeVoyage:data!.typeVoyage,
             image:data!.image,
             remise:data!.remise,

            ),
          ],
        ),
      ),
    );
  }
}
