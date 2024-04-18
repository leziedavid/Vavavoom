import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoom/app/models/TicketModel.dart';
import 'package:vavavoom/app/modules/paiement/controllers/paiement_controller.dart';
import 'package:vavavoom/app/modules/ticket/views/ModelTickesViews.dart';
// class OrangePaie extends StatelessWidget {
class OrangePaie extends StatefulWidget {

   final String reseauText;
   final String depart;
   final String arriver;
   final String transporteur;
   final String  gare;
   final String dateAller;
   final String dateRetour;
   final String prix;
   final String heureDepart;
   final String nombreTicket;
   final int typeVoyage;
   final String image;
   final int remise;
   final String url;
   final String orderId;

   final String tokens;
   final String  nom;
   final String  phone;
   final String  payenToken;
                                
  const OrangePaie({

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
    required this.url,
    required this.orderId,

    required this.tokens,
    required this. nom,
    required this. phone,
    required this. payenToken,

  }) : super(key: key);
  @override
  _OrangePaieState createState() => new _OrangePaieState();

}

class _OrangePaieState extends State<OrangePaie> {

    PaiementController paiementController = Get.put(PaiementController());

    InAppWebViewController? _webViewController;

    Timer? timer;
    var transactionId;
    double progress = 0;
    bool isLoding =false;
    String url = "";
    var typevoyageChoice = "";
    var user;
    var dateDeb="";
    var datereturn="";
    var tarif;
    var tag;
    var token,tokens,role,userId,usernames,userName,status,reference,raison, referenceTicket;
    var listeTicket = [];
    
    String formattedDate="";
    String formattedDate2="";
    final  pays = 1;
    final  statutx = "1";

  checkLoginStatus() async {
        final sharedPreferences = await SharedPreferences.getInstance();
          if(sharedPreferences.getString("token") != null ||sharedPreferences.getString("role") != null || sharedPreferences.getInt("id") != null|| sharedPreferences.getString("nom") != null ) {
            setState(() {
                token = sharedPreferences.getString("token");
                role = sharedPreferences.getString("role");
                userName = sharedPreferences.getString("nom");
                userId = sharedPreferences.getInt("id");
              });
              return sharedPreferences.getString("token");
          }
    }

  requestToSavePaiement() async {
      await http.post( Uri.parse("https://vavavoom.ci/api/v1/save-paiement"),
      headers: {
          'Content-type': 'application/json',
          'Accept' : 'application/json',
      },
        body: jsonEncode({
            "service_paiement": "Orange Money",
            "id_transaction": widget.orderId,
            "statut_transaction": "$status",
            "numero_transaction":widget.phone,
            "reference_ticket": widget.prix,
            "compagnie_name": widget.transporteur
          })).then((response) { 
            print(response.body);
            
          });
    }

  getTickets() async {



      if(widget.typeVoyage==0){

        typevoyageChoice="Aller-Simple";

      }else if(widget.typeVoyage==1){

      typevoyageChoice="Aller-Retour";
      }


      if(widget.dateAller!=""){

        String dateStr=widget.dateAller;
        DateTime dateTime = DateFormat("dd-MM-yyyy").parse(dateStr);
         formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);
        print(formattedDate);
 
      }

      if(widget.dateRetour!=""){

        String dateStr2=widget.dateRetour;
        DateTime dateTime2 = DateFormat("dd-MM-yyyy").parse(dateStr2);
        formattedDate2 = DateFormat("yyyy-MM-dd").format(dateTime2);
        print(formattedDate2);

      }

    await http.post( Uri.parse("https://vavavoom.ci/api/v1/ticket"),
          headers: {
        'Content-type': 'application/json',
        'Accept' : 'application/json',
     },
     body: jsonEncode({
          "ville_depart": widget.depart,
          "ville_arriver": widget.arriver,
          "heure_depart": widget.heureDepart,
          "transporteur": widget.transporteur,
          "gare": widget.gare,
          "type_voyage": typevoyageChoice,
          "type_ticket":"National",
          "username": widget.nom +" / "+widget.phone,
          "user_id": userId != null ? userId.toString() : " ",
          "tarif": widget.prix.toString(),
          "nombre_ticket": widget.nombreTicket,
          "transaction_id": widget.orderId.toString(),
          "date_depart":formattedDate.toString(),
          "date_retour":formattedDate2.toString() != null ? formattedDate2:""

        })).then((response) {

            print(response.statusCode);
            if (!mounted) return;
                setState(() {
                Iterable list = json.decode(response.body);
                listeTicket  = list.map((model) => Ticket.fromJson(model)).toList();
              });

            Get.to(ModelTickesViews(
                    data:DataModelTickes(
                    // listeTicket[0].id,
                    pays,
                    listeTicket[0].typeVoyage,
                    listeTicket[0].villeArriver,
                    listeTicket[0].villeDepart,
                    listeTicket[0].transporteur,
                    listeTicket[0].gare,
                    listeTicket[0].heure,
                    listeTicket[0].dateAller,
                    listeTicket[0].dateRetour,
                    listeTicket[0].tarif,
                    listeTicket[0].referenceTicket,
                    listeTicket[0].code,
                    listeTicket[0].transactionId,
                    listeTicket[0].nbreticket,
                    listeTicket[0].username,
                    listeTicket[0].userId,
                    statutx,
                    )
                  )
              );

        });
    }

  requestToGetTransactionStatus() async {
        tokens = widget.tokens;
        //get transaction statut*
          await http.post( Uri.parse("https://api.orange.com/orange-money-webpay/ci/v1/transactionstatus"),
          headers: {
            'Authorization': 'Bearer $tokens',
            'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "order_id": widget.orderId,
          "amount": widget.prix,
          "pay_token": widget.payenToken
          })).then((response) {

              var bodyresponses = jsonDecode(response.body);
                if(response.statusCode == 201) {
                  if (!mounted) return;
                   setState(() { status = bodyresponses['status'];}
                  );
                }
            });
            print("status=$status");
    }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();

     timer = Timer.periodic(Duration(seconds: 3), (timer){

       requestToGetTransactionStatus();
       if(status=="SUCCESS")
          {
              timer.cancel();
              print("timer is stopped");
              requestToSavePaiement();
              getTickets();
                
          } else if(status=="EXPIRED" || status=="FAILED" ) {
            // getTickets();
              timer.cancel();
              requestToSavePaiement();
              paiementController.changesStates();
              Navigator.of(context).pop();
               Get.snackbar("Votre paiement a échoué\n","Assurez-vous de disposer des fonds pour cette opération!",
                  icon: Icon(Icons.info, color: const Color.fromARGB(255, 255, 0, 0),size: 50,),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: 10,
                  margin: EdgeInsets.all(15),
                  colorText: const Color.fromARGB(255, 255, 0, 0),
                  duration: Duration(seconds: 10),
                  isDismissible: true,
                  forwardAnimationCurve: Curves.easeOutBack,
               );

                

          }

      });
  
   }

  @override
  void dispose() {
    super.dispose();
  }
   
  Widget build(BuildContext context) {
    final webUrl = WebUri(widget.url);
        return Scaffold(
                  appBar: AppBar(
                  leading: 
                      IconButton(
                        onPressed:(){
                          paiementController.changesStates();
                          Navigator.of(context).pop(); 
                         },
                        icon: Icon(FontAwesomeIcons.times, size: 25,)), title: Text("Annuler", style:  TextStyle(fontWeight: FontWeight.w500),),
                    ),

                    body: InAppWebView(

                            initialUrlRequest: URLRequest( url: webUrl),

                            onWebViewCreated: (controller) {
                              _webViewController = controller;
                            },

                            onLoadStart: (InAppWebViewController controller, url) {
                              setState(() {
                                 this.url = url.toString();
                                print('Page started loading: $url');
                              });
                            },

                            onLoadStop: (InAppWebViewController controller, url) {
                              setState(() {
                                this.url = url.toString();
                                print('Page finished loading: $url');
                              });
                            },

                            onProgressChanged: (InAppWebViewController controller, int progress) {
                                  setState(() {
                                    this.progress = progress / 100;
                                  });
                              },

                          ),
                   );
    
  }

  openPaymentSuccessDialog(BuildContext context){
      showGeneralDialog(
            barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.4),
            transitionDuration: Duration(milliseconds: 300),
            context: context,
            pageBuilder: (_, __, ___) {
              return Material(
                type: MaterialType.transparency,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.00,
                      right: 20.00,
                    ),
                    child: Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 12, left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/Paysuccess.png', height: 60.h),
                          SizedBox(height: 10.00),
                          const Text("Paiement bien effectuée, Votre téléchargement est en cours \n Veuillez ne pas quitter l'application.",textAlign: TextAlign.center, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.black ),),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            transitionBuilder: (_, anim, __, child) {
              return SlideTransition(
                position:Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim), child: child,
              );
            });
  }

}
