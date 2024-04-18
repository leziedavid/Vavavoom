import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart'; // Package pour générer des UUID
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/models/TicketModel.dart';
import 'package:vavavoom/app/modules/home/controllers/home_controller.dart';
import 'package:vavavoom/app/modules/paiement/controllers/paiement_controller.dart';
import 'package:vavavoom/app/modules/ticket/views/ModelTickesViews.dart';

class WavePaie extends StatefulWidget {

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
   final String  nom;
   final String  phone;
   final String  waveid;
  //  final String  wave_launch_url;
  // final String  transacId;
                           
  const WavePaie({

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
    required this. waveid,

    // required this. transacId,
    // required this. wave_launch_url,
    // required this. wave_id,


  }) : super(key: key);
  @override
  _WavePaieState createState() => new _WavePaieState();
}

class _WavePaieState extends State<WavePaie> {

     InAppWebViewController? _webViewController;
     PaiementController paiementController = Get.put(PaiementController());
     HomeController homeController = Get.put(HomeController());

    SharedPreferences? sharedPreferences;
    TextEditingController numberController = TextEditingController();
    TextEditingController nomController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

  var encoded1 = base64.encode(utf8.encode('0db1e2d5-6150-40c1-bc91-4a5d7f4628c4:4bd58abf0d9a430bb2e827f16d6da885'));
  var status;
  var lastpayment_error;
  var token;
  var message;
  var reference;
  var user_name;
  var phoneNumber;
  var raison;
  var userName;
  var role;
  var userId;
  var phone;
  var referenceTicket;
  var wave_id;
  var wavelaunchurl;
  var listeTicket = [];
  var typevoyageChoice;
  var formattedDate = "";
  var formattedDate2 = "";
  final int pays = 1;
  var  statBtn = 1;
  final String statutx = "1";
  bool isLoading = false;
  String url = "";
  bool show = true;
  var transactionId;
  double progress = 0;
  Timer? timer;
  late String _latestLink;
  String idLinks = "";

  @override
  void initState() {
    super.initState();
    _latestLink = 'Unknown';

      if(widget.waveid != "") {

        statBtn=0;
        idLinks = widget.waveid;
        requestToGetTransactionStatus(idLinks);

      }else{
        
          statBtn=1;
          idLinks="";
      }

  }


  // fonction de paiment

    payDataSave(idLink) async {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          setState(() {
                sharedPreferences.setString("reseauText", widget.reseauText.toString());
                sharedPreferences.setString("depart", widget.depart.toString());
                sharedPreferences.setString("arriver", widget.arriver.toString());
                sharedPreferences.setString("transporteur", widget.transporteur.toString());
                sharedPreferences.setString("gare", widget.gare.toString());
                sharedPreferences.setString("dateAller", widget.dateAller.toString());
                sharedPreferences.setString("dateRetour", widget.dateRetour.toString());
                sharedPreferences.setString("prix", widget.prix.toString());
                sharedPreferences.setString("heureDepart", widget.heureDepart.toString());
                sharedPreferences.setString("nombreTicket", widget.nombreTicket.toString());
                sharedPreferences.setInt("typeVoyage", widget.typeVoyage!);
                sharedPreferences.setString("image", widget.image.toString());
                sharedPreferences.setInt("remise", widget.remise!);
                sharedPreferences.setString("nom", widget.nom.toString());
                sharedPreferences.setString("phone", widget.phone.toString());
                sharedPreferences.setString("codes", idLink.toString());
            });
      }

      startTimer(id) async {
        timer = Timer.periodic(Duration(seconds: 5), (timer) {
          requestToGetTransactionStatus(id);
        });
       }


       void activateVariableAfterDelay() {
          // Utilisation de la fonction `Future.delayed` pour déclencher une action après un certain délai
          Future.delayed(Duration(seconds: 5), () {
            // Après 3 secondes, la variable est définie sur true
            isLoading =false;
            print('Variable activée après 3 secondes: $isLoading');
          });
        }

      _launchPayment() async {

          isLoading =true;
          activateVariableAfterDelay();

          //Nous allons générer le lien en payer
           var wavekey = "wave_ci_prod_BRoKc90NC_ioDJ-csqkMIvPOMzidfGwFhjS7YNtk6T4ucmxisg5UI-tDCRyBc4gFy4qsaeaVL318WHkWC17Hj1KLF3mUeN3dxw";
           String  generateIdempotencyKey() {
           var uuid = Uuid();
            return uuid.v4();
            // Génère un UUID v4 aléatoire
           }

          await http
              .post(Uri.parse("https://api.wave.com/v1/checkout/sessions"),
                  headers: {
                    'Authorization': 'Bearer $wavekey',
                    'Content-type': 'application/json',
                    'idempotency-key': generateIdempotencyKey(),
                  },
                  body: jsonEncode({
                    "amount": widget.prix,
                    // "amount": "10000",
                    "currency": "XOF",
                     "error_url": "https://vavavoom.ci/error",
                    "success_url": "https://vavavoom.ci/infos"
                  }))
              .then((response) {

                  print("response body= ${response.body}");
                  var bodyresponses = jsonDecode(response.body);
                  final Uri apiLink = Uri.parse(bodyresponses['wave_launch_url']);
                  final idLink=bodyresponses['id'];

                  setState(() {
                    wave_id=idLink;
                    wavelaunchurl=apiLink;

                  });
                  
                  startTimer(bodyresponses['id']);
                  payDataSave(idLink);
                  openLink(apiLink,idLink);

               });
      }

      // ouvrir l'application lien Wave

       void openLink(apiLink,idLink) async {

          if (await canLaunchUrl(apiLink)) {

            await launchUrl(apiLink);
            setState(() {  statBtn = 0; });

          } else {

            throw 'Could not launch $apiLink';
          }
      }


      requestToGetTransactionStatus(var waveid) async {

          try {

        var wavekey = "wave_ci_prod_BRoKc90NC_ioDJ-csqkMIvPOMzidfGwFhjS7YNtk6T4ucmxisg5UI-tDCRyBc4gFy4qsaeaVL318WHkWC17Hj1KLF3mUeN3dxw";
        await http.get(Uri.parse("https://api.wave.com/v1/checkout/sessions/$waveid"), headers: {
          'Authorization': 'Bearer $wavekey',
        }).then((response) {
          var bodyresponses = jsonDecode(response.body);

          if (!mounted) return; // Vérifier si le widget est toujours monté
          setState(() {
            status = bodyresponses['payment_status'];
            lastpayment_error = bodyresponses['last_payment_error'];
          });

          if (status == "succeeded") {
            timer!.cancel();
            print("timer is stopped");
            requestToSavePaiement();
            getTickets();
            setState(() {
              statBtn = 0;
              show = false;
              paiementController.isLoding.value = false;
            });
          }

          if (status == "cancelled") {
            timer!.cancel();
            print("timer is stopped");
            requestToSavePaiement();
            setState(() {
              statBtn = 0;
              isLoading = false;
              show = false;
              paiementController.isLoding.value = false;
            });
          }

          if (status == "processing" && lastpayment_error != null) {
            if (timer != null) {
              timer?.cancel();
            }
            print("timer is stopped");
            requestToSavePaiement();
            setState(() {
              statBtn = 0;
              show = false;
              isLoading = false;
              paiementController.isLoding.value = false;
            });
          }
          print("reponse =$bodyresponses");
        });
        print("status =$status");


      } catch (e) {
          print("Erreur lors de la connexion au serveur: $e");
          // Gérer l'erreur, par exemple afficher un message d'erreur à l'utilisateur
        }

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
            "transaction_id": wave_id.toString(),
            "date_depart":formattedDate.toString(),
            "date_retour":formattedDate2.toString() != null ? formattedDate2:""

          })).then((response) {
             print(response.statusCode);
             homeController.cleanData();
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
                  statutx
                  )
                )
            );

          });
      }

      requestToSavePaiement() async{
            await http.post( Uri.parse("https://vavavoom.ci/api/v1/save-paiement"),
                headers: {'Content-type': 'application/json','Accept' : 'application/json',},
                  body: jsonEncode({
                      "service_paiement": widget.reseauText,
                      "id_transaction": wave_id,
                      "statut_transaction": "$status",
                      "numero_transaction": widget.phone,
                      // "numero_transaction":"$phoneNumber",
                      "reference_ticket": widget.prix,
                      "compagnie_name": widget.transporteur
                    })).then((response) {
                      print(response.body);
                      
                    });
              }
        
  @override

  Widget build(BuildContext context) {

         return Scaffold(

        appBar: AppBar(
            title: Text('WAVE',style: TextStyle(fontFamily: "poppins",
            fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
            centerTitle: true,
            backgroundColor: CustomColor.primary,
            leading: IconButton(
                onPressed: (){
                  paiementController.changesStates();
                  Navigator.pop(context);
                  },
                icon: Icon(Icons.arrow_back_sharp, color: Colors.white,),
              ),
        ),

        body: Container(
            color: Color.fromARGB(255, 255, 255, 255),

            child: ListView(
              padding: EdgeInsets.all(10.sp),
              children: [
                
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( "TOTAL", style: TextStyle(fontFamily: "popins", fontSize: 18.sp,fontWeight: FontWeight.w700), ),
                    Text( "${widget.prix} Fcfa", style: TextStyle(fontFamily: "popins", fontSize: 18.sp,fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox( height: 10.h,),

                  Material(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 110.h,
                                  width: 110.h,
                                  decoration: const BoxDecoration(image: DecorationImage( image: AssetImage("assets/images/wave.png"), fit: BoxFit.cover, ),
                                  shape: BoxShape.circle, color: Color.fromARGB(114, 17, 177, 226),
                                  boxShadow: const [ BoxShadow( blurRadius: 2, blurStyle: BlurStyle.inner, color: Colors.grey, offset: Offset(1, 1), spreadRadius: 0, ) ]),
                                  ),
                            ],
                          ),
                        ),

                        
                      ),
                          SizedBox( height: 30.h,),
                          Container(alignment: Alignment.center,child: isLoading==true ? CircularProgressIndicator()
                          :
    
                          statBtn== 1 ?
                           Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                              onTap: () {
                                 _launchPayment();
                                
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: CustomColor.primary),
                                  child: const Text( "Ouvrir l'application",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),),
                                    ),
                                )
                            )
                            :Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                              onTap: () {
                                  _launchPayment();
                              },

                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: CustomColor.primary),
                                  child: const Text( "Effectuer un nouveau paiement",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),),
                                    ),
                                )
                            ),
                            
                            ),



                        if(status=="insufficient-funds" && lastpayment_error!=null)(
                          RichText(
                            text:TextSpan(
                            text: 'Votre paiement a échoué\n',
                            children: const <TextSpan>[ TextSpan(text: "Assurez-vous de disposer des fonds pour cette opération.\n",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                            TextSpan(text: '\nAppuyer sur le bouton pour efféctuer un nouveau paiement.', style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold)),],
                            style: TextStyle(fontSize: 24,color: Colors.redAccent, fontWeight: FontWeight.w700)
                            ),
                            textAlign: TextAlign.center,
                            )
                          ),
 
                        if(status=="succeeded")(
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.00, right: 20.00, ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(bottom: 12, left: 15, right: 15),
                                decoration: BoxDecoration( borderRadius: BorderRadius.circular(12),),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/Paysuccess.png', height: 60.h),
                                    SizedBox(height: 12.00),
                                    const Text("Paiement bien effectuée, Votre téléchargement est en cours ...", textAlign: TextAlign.center,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ),
            
              ],
            ),
          ),
          
        );
     }

}


