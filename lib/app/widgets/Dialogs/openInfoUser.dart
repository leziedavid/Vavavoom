import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart'; // Package pour générer des UUID
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/paiement/controllers/paiement_controller.dart';
import 'package:vavavoom/app/widgets/Cards/CardMtnPaie.dart';
import 'package:vavavoom/app/widgets/Cards/CardOrangePaie.dart';
import 'package:vavavoom/app/widgets/Cards/CardWavePaie.dart';


openInfoUser(
    String reseauText,
    String depart,
    String arriver,
    String transporteur,
    String gare,
    String dateAller,
    String dateRetour,
    String  prix,
    String heureDepart,
    String nombreTicket,
    int  typeVoyage,
    String image,
    int  remise,)

    {

    final _formKey = GlobalKey<FormState>();
    DateTime selectedDate = DateTime.now();

    SharedPreferences sharedPreferences;
    InAppWebViewController webViewController;

    final  fulname = TextEditingController();
    final  phone = TextEditingController();
    double progress = 0;
    var token, status,orderId, phoneNumber,raison,userName,role, userId, prixTicket,nom;

    final data= [
      { "reseauText": reseauText },
      { "depart": depart },
      { "arriver": arriver },
      { "transporteur": transporteur },
      { "dateAller": dateAller },
      { "dateRetour": dateRetour },
      { "typeVoyage": typeVoyage },
      { "image": image },
      { "remise": remise },
    ];
 
  PaiementController paiementController = Get.put(PaiementController());

  savePaiement() async {
      await http.post(Uri.parse("https://vavavoom.ci/api/v1/save-paiement"), 
      headers: {'Content-type': 'application/json', 'Accept' : 'application/json',},
      
      body: jsonEncode({
          "service_paiement": reseauText,
          "id_transaction": orderId,
          "statut_transaction": status,
          "numero_transaction":phone,
          "reference_ticket": prix,
          "compagnie_name": transporteur
        })).then((response) {

          print(response.body);
          
        });
  }

  void submit() async{

          if (_formKey.currentState!.validate()) {

             paiementController.globalstetes.value=false;
             paiementController.isLoding.value=true;

              if(reseauText=="Orange"){

                  //get reference id
                  var code = await http.get(Uri.parse("https://www.uuidgenerator.net/api/version4"));
                  var codess = code.body;

                  //get token;
                  await http.post(Uri.parse("https://api.orange.com/oauth/v3/token"),
                    headers: {
                      'Authorization': 'Basic b2d1WWNzbXlEY2JMVm93YXZOY2pvN0x3YVVxQjhkeUE6aWhXendaSUtIR0hmN3RBNQ==',
                      'Content-Type': 'application/x-www-form-urlencoded'
                        },body: {'grant_type': 'client_credentials'}).then((response) {
                          var bodyresponse = jsonDecode(response.body);
                          token =bodyresponse['access_token'];
                          orderId=codess;
                        });
                      //send request to pay
                       await http.post(Uri.parse("https://api.orange.com/orange-money-webpay/ci/v1/webpayment"),
                        headers: {
                            'Authorization': 'Bearer $token',
                            'Content-type': 'application/json',
                            'Accept' : 'application/json'
                          },
                        body: jsonEncode({
                        "merchant_key":"08cea967",
                        "amount": prix,
                        // "amount":"10",
                        "order_id": "$codess",
                        "currency": "XOF",

                        "return_url": "https://vavavoom.ci/return-app",
                        "cancel_url": "https://vavavoom.ci/return-app",
                        "notif_url": "https://vavavoom.ci/return-app",
                        "lang": "fr",
                        "reference": "Vavavoom achat de ticket"

                        })).then((response) {
                          var bodyresponses = jsonDecode(response.body);

                          if(response.statusCode == 201 || response.statusCode == 200){
                          Get.to( OrangePaie(
                                reseauText:reseauText,
                                depart:depart,
                                arriver:arriver,
                                transporteur:transporteur,
                                gare:gare,
                                dateAller:dateAller,
                                dateRetour:dateRetour,
                                prix:prix,
                                heureDepart:heureDepart,
                                nombreTicket:nombreTicket,
                                typeVoyage:typeVoyage,
                                image:image,
                                remise:remise,
                                url: bodyresponses['payment_url'],
                                orderId: "$codess",
                                tokens: token,
                                nom: fulname.text,
                                phone: phone.text,
                                payenToken: bodyresponses['pay_token'],

                              ));
                          
                          }
                    });


              }else if(reseauText=="MTN"){

                  Get.to(MtnPaie(
                  reseauText:reseauText,
                  depart:depart,
                  arriver:arriver,
                  transporteur:transporteur,
                  gare:gare,
                  dateAller:dateAller,
                  dateRetour:dateRetour,
                  prix:prix,
                  heureDepart:heureDepart,
                  nombreTicket:nombreTicket,
                  typeVoyage:typeVoyage,
                  image:image,
                  remise:remise,
                  nom: fulname.text,
                  phone: phone.text,
                  ));

              }else if(reseauText=="WAVE"){

                  var wavekey = "wave_ci_prod_BRoKc90NC_ioDJ-csqkMIvPOMzidfGwFhjS7YNtk6T4ucmxisg5UI-tDCRyBc4gFy4qsaeaVL318WHkWC17Hj1KLF3mUeN3dxw";
                  String  generateIdempotencyKey() {
                      var uuid = Uuid();
                      return uuid.v4(); // Génère un UUID v4 aléatoire
                    }

                        Get.to(WavePaie(
                            reseauText:reseauText,
                            depart:depart,
                            arriver:arriver,
                            transporteur:transporteur,
                            gare:gare,
                            dateAller:dateAller,
                            dateRetour:dateRetour,
                            prix:prix,
                            heureDepart:heureDepart,
                            nombreTicket:nombreTicket,
                            typeVoyage:typeVoyage,
                            image:image,
                            remise:remise,
                            nom: fulname.text,
                            phone: phone.text,
                            waveid: "",
                            // wave_launch_url: bodyresponses['wave_launch_url'],
                            // wave_id: bodyresponses['id'],
                        ));

                  //       await http.post(Uri.parse("https://api.wave.com/v1/checkout/sessions"),
                  //         headers: {
                  //           'Authorization': 'Bearer $wavekey',
                  //           'Content-type': 'application/json',
                  //           'idempotency-key': generateIdempotencyKey(),
                  //         },
                  //         body: jsonEncode({
                  //           "amount": "10000",
                  //           "currency": "XOF",
                  //           "error_url": "https://vavavoom.ci/return-app",
                  //           "success_url": "https://vavavoom.ci/return-app"

                  //         }))
                  //     .then((response) {
                  //           print("response body= ${response.body}");
                  //           var bodyresponses = jsonDecode(response.body);

                  //          Get.to(WavePaie(
                  //           reseauText:reseauText,
                  //           depart:depart,
                  //           arriver:arriver,
                  //           transporteur:transporteur,
                  //           gare:gare,
                  //           dateAller:dateAller,
                  //           dateRetour:dateRetour,
                  //           prix:prix,
                  //           heureDepart:heureDepart,
                  //           nombreTicket:nombreTicket,
                  //           typeVoyage:typeVoyage,
                  //           image:image,
                  //           remise:remise,
                  //           nom: fulname.text,
                  //           phone: phone.text,
                  //           wave_launch_url: bodyresponses['wave_launch_url'],
                  //           wave_id: bodyresponses['id'],
                  //       ));

                  // });



              }
          }
          
    }

   Get.defaultDialog(
    title: reseauText.toString(),
    radius: 7,
    content: Container(
      padding: EdgeInsets.all(10.sp),
      width: 250.w,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) { if (value!.isEmpty) {return "Champ obligatoire !";} },
              controller: fulname,
              strutStyle: const StrutStyle(),
              decoration: const InputDecoration( labelText: "Nom & prénoms",  labelStyle: TextStyle(fontFamily: "poppins"),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              maxLength: 10,
              onChanged: (value) { paiementController.telLength.value = value.length.toString(); },
              validator: (value) {if (value!.length < 10) { return "Téléphone à 10 chiffresn obligatoire"; } },
              controller: phone, keyboardType: TextInputType.number, strutStyle: const StrutStyle(),
              decoration: const InputDecoration( labelText: "Téléphone", labelStyle: TextStyle(fontFamily: "poppins"),border: OutlineInputBorder(), ),
            ),
            const SizedBox( height: 5,  ),
            Obx(()  => paiementController.globalstetes.value==true? GestureDetector(
                  onTap:submit,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: CustomColor.primary),child: const Text( "Confirmez le paiement",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),
                    ),
                  ),
                ):Center(child: CircularProgressIndicator( color: CustomColor.primary,),) 
             ),
              
          ],
        ),
      ),
    ),
  );

}
