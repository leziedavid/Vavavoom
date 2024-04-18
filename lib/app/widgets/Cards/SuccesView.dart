import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/models/TicketModel.dart';
import 'package:vavavoom/app/modules/paiement/controllers/paiement_controller.dart';

class SuccesViews extends StatefulWidget {

   final String reseauText;
   final String depart;
   final String arriver;
   final String transporteur;
   final String  gare;
   final String dateAller;
   final String dateRetour;
   final int prix;
   final String heureDepart;
   final String nombreTicket;
   final int typeVoyage;
   final String image;
   final int remise;
   final String  nom;
   final String  phone;
                               
  const SuccesViews({

    Key? key,
    required this.reseauText,
    required this.depart,
    required this.arriver,
    required this.transporteur,
    required this. gare,
    required this.dateAller,
    required this.dateRetour,
    required this.prix,
    required this.heureDepart,
    required this.nombreTicket,
    required this.typeVoyage,
    required this.image,
    required this.remise,
    required this. nom,
    required this. phone,

  }) : super(key: key);
  @override
  _SuccesViewsState createState() => new _SuccesViewsState();
}

class _SuccesViewsState extends State<SuccesViews> {

     InAppWebViewController? _webViewController;
     PaiementController paiementController = Get.put(PaiementController());

    SharedPreferences? sharedPreferences;
    TextEditingController numberController = TextEditingController();
    TextEditingController nomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var encoded1 = base64.encode(utf8.encode('0db1e2d5-6150-40c1-bc91-4a5d7f4628c4:4bd58abf0d9a430bb2e827f16d6da885'));
  var token, status,reference, user_name,phoneNumber,raison, userName, role,userId, phone,referenceTicket;
  bool isLoading = false;
  var ticket =  Ticket;
  bool show = true;
  var transactionId;
  double progress = 0;

      checkLoginStatus() async {
          sharedPreferences = await SharedPreferences.getInstance();
          if(sharedPreferences?.getString("token") != null ||sharedPreferences?.getString("role") != null || sharedPreferences?.getInt("id") != null|| sharedPreferences?.getString("nom") != null ) {
            setState(() {
                token = sharedPreferences?.getString("token");
                role = sharedPreferences?.getString("role");
                userName = sharedPreferences?.getString("nom");
                phone = sharedPreferences?.getString("telephone");
                userId = sharedPreferences?.getInt("id");
              });
              return sharedPreferences?.getString("token");
          }
        }
 

  @override

  void initState() {
    super.initState();
     checkLoginStatus();
   } 

   @override
   
  Widget build(BuildContext context) {

         return Scaffold(

        appBar: AppBar(
            title: Text('FELICITATION',style: TextStyle(fontFamily: "poppins",
            fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
            centerTitle: true,
            backgroundColor: CustomColor.primary,
            leading: IconButton(
                onPressed: (){paiementController.changesStates(); Navigator.pop(context); },
                icon: Icon(Icons.arrow_back_sharp,
                color: Colors.white,),
              ),
        ),

        body: Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: ListView(
              padding: EdgeInsets.all(10.sp),
              children: [
                
                const Divider(color: Colors.grey, ),
                  Material(

                        child: Container(
                        
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              
                              Container(
                                  height: 130.h,
                                  width: 130.h,
                                  decoration: BoxDecoration(image: DecorationImage( image: AssetImage("assets/images/mtn.jpg"), fit: BoxFit.cover, ),
                                  shape: BoxShape.circle, color: Color.fromARGB(246, 255, 224, 112),
                                  boxShadow: const [ BoxShadow( blurRadius: 2, blurStyle: BlurStyle.inner, color: Colors.grey, offset: Offset(1, 1), spreadRadius: 0, ) ]),
                                  ),
                            ],
                          ),
                        ),
                      ),
                        SizedBox( height: 50.h,),

                        Obx(()  => paiementController.isLoding.value==false ? 

                          Center(child: CircularProgressIndicator( color: CustomColor.primary,),)
                        
                          : Material(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  
                                 children: [
                                        SizedBox( height: 50.h,),
                                        Container(alignment: Alignment.center,
                                        child: Text( "Votre paiement a échoué", textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontWeight: FontWeight.w700, fontFamily: "poppins", fontSize: 20.sp,),), ),
                                        Container(alignment: Alignment.center,
                                        child: Text( "Assurez-vous de disposer des fonds pour cette operations.", textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontWeight: FontWeight.w700, fontFamily: "poppins", fontSize: 15.sp,),), ),
                                        
                                        SizedBox( height: 25.h, ),

                                        Container(alignment: Alignment.center,  child: Text( "Appuyer sur le bouton pour éffectuer un nouveau paiement.", textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w700, fontFamily: "poppins", fontSize: 15.sp,),), ),
                                        SizedBox( height: 20.h, ),

                                        Container(

                                          alignment: Alignment.center,
                                          child: GestureDetector(
                                                // onTap:submit,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: CustomColor.primary),child: const Text( "Confirmez le paiement",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),
                                                  ),
                                                ),
                                            )

                                      ),

                                      ],

                                    ),
                                  ),
                                ),
                              ),
            
              ],
            ),
          ),
        );
     }

}


