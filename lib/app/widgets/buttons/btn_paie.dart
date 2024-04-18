import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vavavoom/app/widgets/Dialogs/openInfoUser.dart';

class BtnPaie extends StatelessWidget {

  const BtnPaie({

    Key? key, 
    required this.colorBtn, 
    required this.reseauText,

    required this.depart,
    required this.arriver,
    required this.transporteur,
    required this.gare,
    required this.dateAller,
    required this.dateRetour,
    required this.prix,
    required this.heureDepart,
    required this.nombreTicket,
    required this.typeVoyage,
    required this.image,
    required this.remise,

    }) : super(key: key);

  final Color colorBtn;
  final String reseauText;
  final String depart;
  final String arriver;
  final String transporteur;
  final String gare;
  final String dateAller;
  final String dateRetour;
  final String prix;
  final String heureDepart;
  final String nombreTicket;
  final int typeVoyage;
  final String image;
  final int remise;

  @override
  Widget build(BuildContext context) {
      //  TicketController controller = Get.put(TicketController());
    return GestureDetector(
      onTap: () { openInfoUser(
          reseauText,
          depart,
          arriver,
          transporteur,
          gare,
          dateAller,
          dateRetour,
          prix,
          heureDepart,
          nombreTicket,
          typeVoyage,
          image,
          remise,
      ); },

      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(3),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: 35.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: colorBtn,
          ),
          child: Text( "Payer avec $reseauText", style: TextStyle( fontSize: 15.sp, fontFamily: "poppins", color: Colors.black),
          ),
        ),
      ),
    );
  }
}
