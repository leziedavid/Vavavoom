import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vavavoom/app/widgets/buttons/btn_paie.dart';

class CardPaiement extends StatelessWidget {
  final String reseauText;
  final Color colorBtn;
  final Color backagroundColor;
  final Color circleColor;
  final String logos;

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

  const CardPaiement({

    Key? key,
    required this.reseauText,
    required this.colorBtn,
    required this.backagroundColor,
    required this.circleColor,
    required this.logos,

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

  @override
  Widget build(BuildContext context) {
    return  Material(
      borderRadius: BorderRadius.circular(7),
      elevation: 2,
      child: Container(
        
        padding: EdgeInsets.all(20.sp),
        color: backagroundColor,
        height: 150.h,
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Container(
              height: 60.h,
              width: 60.h,
              
             decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(logos),fit: BoxFit.cover,),
                  shape: BoxShape.circle,
                  color: circleColor,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      blurStyle: BlurStyle.inner,
                      color: Colors.grey,
                      offset: Offset(1, 1),
                      spreadRadius: 0,
                    )
                  ]),
            ),
            BtnPaie(
              colorBtn: colorBtn,
              reseauText: reseauText,
              depart:depart,
              arriver:arriver,
              transporteur:transporteur,
              gare:gare,
              dateAller:dateAller,
              dateRetour: dateRetour,
              prix: prix,
              heureDepart:heureDepart,
              nombreTicket:nombreTicket,
              typeVoyage:typeVoyage,
              image:image,
              remise:remise,
             ),
          ],
        ),
      ),
    );
  }
}
