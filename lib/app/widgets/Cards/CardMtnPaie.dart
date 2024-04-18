import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/models/TicketModel.dart';
import 'package:vavavoom/app/modules/paiement/controllers/paiement_controller.dart';
import 'package:vavavoom/app/modules/ticket/views/ModelTickesViews.dart';

class MtnPaie extends StatefulWidget {

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

  //  final String url;
  //  final String orderId;
  //  final String tokens;
  //  final String  nom;
  //  final String  phone;
  //  final String  payenToken;
                                
  const MtnPaie({

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

    // required this.url,
    // required this.orderId,
    // required this.tokens,
    // required this. nom,
    // required this. phone,
    // required this. payenToken,

  }) : super(key: key);
  @override
  _MtnPaieState createState() => new _MtnPaieState();
}

class _MtnPaieState extends State<MtnPaie> {

     InAppWebViewController? _webViewController;
     PaiementController paiementController = Get.put(PaiementController());

    SharedPreferences? sharedPreferences;
    TextEditingController numberController = TextEditingController();
    TextEditingController nomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var encoded1 = base64.encode(utf8.encode('0db1e2d5-6150-40c1-bc91-4a5d7f4628c4:4bd58abf0d9a430bb2e827f16d6da885'));
  var token, status,reference, user_name,phoneNumber,raison, userName, role,userId, phone,referenceTicket;
  var listeTicket = [];
  var typevoyageChoice = "";
  String formattedDate="";
  String formattedDate2="";
  final  pays = 1;
  final  statutx = "1";

  void submit() async{ }
  bool isLoading = false;
  var ticket =  Ticket;
  bool show = true;
  var transactionId;
  double progress = 0;
  Timer? timer;

  // fonction de paiment

      checkLoginStatus() async {
          sharedPreferences = await SharedPreferences.getInstance();
          if(sharedPreferences?.getString("token") != null ||sharedPreferences?.getString("role") != null || sharedPreferences?.getInt("id") != null|| sharedPreferences?.getString("nom") != null ) {
            setState(() {
                token = sharedPreferences?.getString("token");
                role = sharedPreferences?.getString("role");
                userName = sharedPreferences?.getString("nom");
                phoneNumber = sharedPreferences?.getString("telephone");
                userId = sharedPreferences?.getInt("id");
              });
              return sharedPreferences?.getString("token");
          }
        }

       requestToGetTransactionStatus(var tokens, var ref) async {
        
          await http.get(Uri.parse("https://proxy.momoapi.mtn.com/collection/v1_0/requesttopay/$ref"),
              headers: {
                  'Authorization': 'Bearer $tokens',
                  'X-Target-Environment' : 'mtnivorycoast',
                  'Ocp-Apim-Subscription-Key' : '32fab837b8ac4129ab1ba22f67d29a32'
                }).then((response) {

                      var bodyresponses = jsonDecode(response.body);
                        setState(() {
                        status =bodyresponses['status'];
                        raison =bodyresponses['reason'];
                      });
                      if(status=="SUCCESSFUL" || status=="FAILED")
                           {
                            
                              timer!.cancel();
                              print("timer is stopped");
                              requestToSavePaiement();
                              // getTickets();
                          }
                    
                      if(response.statusCode == 200 && status=="SUCCESSFUL") {

                        setState(() {
                          isLoading =false; show = false;
                          paiementController.isLoding.value=false;
                          });
                          
                        getTickets();

                      }else if(response.statusCode == 200 && status=="FAILED"){

                        setState(() {
                              isLoading =false;
                              paiementController.isLoding.value=false;
                            });

                      }else{

                      }
                      print("reponse =$bodyresponses");
                      
                    });

                    print("status =$status");
        }

        requestToPay(phone) async{
          
          setState(() { isLoading =true; });
          //get reference id
          var code = await http.get(Uri.parse("https://www.uuidgenerator.net/api/version4"));
          var codess = code.body;
          //get token;
            await http.post(Uri.parse("https://proxy.momoapi.mtn.com/collection/token/"),
              headers: {
              'Authorization': 'Basic $encoded1',
                'Ocp-Apim-Subscription-Key' : '32fab837b8ac4129ab1ba22f67d29a32'
              },
              body: {}).then((response) {
                  var bodyresponse = jsonDecode(response.body);

                    setState(() {

                      token =bodyresponse['access_token'];
                      reference=codess;

                    });
                });
          
            //send request to pay
            await http.post(Uri.parse("https://proxy.momoapi.mtn.com/collection/v1_0/requesttopay"),
            headers: {
              'Authorization': 'Bearer $token',
                'Content-type': 'application/json',
                'X-Reference-Id' :'$codess',
                'X-Target-Environment' : 'mtnivorycoast',
                'Ocp-Apim-Subscription-Key' : '32fab837b8ac4129ab1ba22f67d29a32'
            },
              body: jsonEncode({
                  "amount": widget.prix,
                  // "amount":"10",
                  "currency": "XOF",
                  "externalId": "Vavavoom",
                  "payer": {
                    "partyIdType": "MSISDN",
                    "partyId": "225${widget.phone}"
                  },
                  "payerMessage": "Vavavoom mobile paiement",
                  "payeeNote": "mobile001"
                })).then((response) {

                  print("response body= ${response.body}");
                  // requestToGetTransactionStatus(token,reference);
                  });

              print("reference id= $codess");
              print("base encode $encoded1");
              print("token= $token");
              print("telephone= ${widget.phone}");
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
              "transaction_id": reference.toString(),
              "date_depart":formattedDate.toString(),
              "date_retour":formattedDate2.toString() != null ? formattedDate2:""

            })).then((response) {

            print(response.statusCode);
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
                        "id_transaction": "$reference",
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

  void initState() {
    super.initState();
     checkLoginStatus();
     requestToPay(widget.phone);
      timer = Timer.periodic(Duration(seconds: 5), (timer) {
          requestToGetTransactionStatus(token,reference);
      });

   }

   @override
   
  Widget build(BuildContext context) {

         return Scaffold(

        appBar: AppBar(
            title: Text('MTN Momo',style: TextStyle(fontFamily: "poppins",
            fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
            centerTitle: true,
            backgroundColor: CustomColor.primary,
            leading: IconButton(
                onPressed: (){
                  paiementController.changesStates();
                  Navigator.pop(context);
                  },
                icon: Icon(Icons.arrow_back_sharp,
                color: Colors.white,),
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
                                  decoration: BoxDecoration(image: DecorationImage( image: AssetImage("assets/images/mtn.jpg"), fit: BoxFit.cover, ),
                                  shape: BoxShape.circle, color: Color.fromARGB(246, 255, 224, 112),
                                  boxShadow: const [ BoxShadow( blurRadius: 2, blurStyle: BlurStyle.inner, color: Colors.grey, offset: Offset(1, 1), spreadRadius: 0, ) ]),
                                  ),
                            ],
                          ),
                        ),
                      ),
                          SizedBox( height: 30.h,),
                          Container(alignment: Alignment.center,child: isLoading ? CircularProgressIndicator() : Text("") ),
                          SizedBox( height: 10.h,),

                        if(status=="PENDING")(
                          RichText(
                            text: TextSpan(
                              text: 'Votre paiement est en attente',
                              children: const <TextSpan>[ TextSpan(text: '\nFaite le *133*1*1*1# pour la confirmation.', style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),],
                              style: TextStyle(fontSize: 20,color: Colors.black)
                                ),
                              textAlign: TextAlign.center,
                            )
                          ),

                        if(status=="FAILED")(
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
                          
                        if(status=="FAILED")(
                            Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                              onTap: () {
                                if(status=="SUCCESSFUL") {
                                  print(status);

                                }else{

                                    requestToPay(widget.phone);
                                    timer = Timer.periodic(Duration(seconds: 5), (timer) {
                                    requestToGetTransactionStatus(token,reference);
                                    });
                                }
                              },
                              // onTap:submit,
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: CustomColor.primary),
                                  child: const Text( "Effectuer un nouveau paiement",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),),
                                    ),
                                )
                            )
                          ),

                        if(status=="SUCCESSFUL")(

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


