import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoom/app/Services/Api/ApiManager.dart';
import 'package:vavavoom/app/modules/ticket/views/MessagesPages.dart';
import 'package:vavavoom/app/modules/ticket/views/ticket_view.dart';
import 'package:vavavoom/app/widgets/Cards/CardWavePaie.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final groupValue = 0.obs;
  final option = ["Aller-Simple", "Aller-Retour"].obs;
  final villeDepart = TextEditingController().obs;
  final villeArrive = TextEditingController().obs;
  final dateDepart = TextEditingController().obs;
  final dateRetours = TextEditingController().obs;
  final transporteur = TextEditingController().obs;
  final listTransporteurSelected = <String>[].obs;
  final listTransporteur = [].obs;
  final listVille = [].obs;
  final selectVille = "".obs;
  final dataSearch = [].obs;
  final copyDataSearch = [].obs;
  final isFirstOnglet = false.obs;
  var lisGare = [].obs;
  final posts = [].obs;
  // var banner = "".obs;

  final nb = 0.obs;
  final etats= false.obs;
  final etapes= false.obs;
// int get sum => count1.value + count2.value;
  final  optionSelect= 0.obs;
  final itineraires= [].obs;
  final fraisTicket= [].obs;
  final typeVoyage= "".obs;
  final dateVooptionyage= "".obs;
  final dateAller= "".obs;
  
  final dateRetour= "".obs;
  final loader = false.obs;
  final load = false.obs;
  final isDonnees = false.obs;
  final listTickes = [].obs;

  var path= "";

  int get selected => groupValue.value;
  final count = 0.obs;
  final temps = 0.obs;

  Timer? timers;
  bool isButtonPressed = false;


  // les variable apres paiement

  @override
  void onInit() {
    copyDataSearch.value = dataSearch;
    super.onInit();
    // cleanData();
    
    fetchBanners();
    checkPaysData();
    fetchGare();
  }


  /// It reads a JSON file and returns the data as a Map.
  Future<void> readJson() async {
      final String response = await rootBundle.loadString('assets/data/donnee.json');
      final data = await json.decode(response);
      listTransporteur.value = data["transporteur"];
      listVille.value = data["ville"];
    }

  /// villeDatas (List): List of data to be searched
  searchVille(String text, List villeDatas) {
    
      if (text.isNotEmpty) {
        final newDataSearch = villeDatas.where((element) => element.toUpperCase().contains(text.toUpperCase())).toList();
        dataSearch.value = newDataSearch;
        inspect(newDataSearch);
      } else {
        dataSearch.value = villeDatas;
      }
  }

  getTickets(String ville_depart, String ville_arriver, String transporteur,groupValue,dateDepart,dateRetours) async {


            temps.value=1;
            final DateFormat formatter = DateFormat('dd-MM-yyyy');
            var today = new DateTime.now();
            final String todays = formatter.format(today);

            if(todays==dateDepart){
             print("Bonjour");


            List filteredData = await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
            DateTime now = DateTime.now();
            DateTime twoHoursLater = now.add(Duration(hours: 1));
            String twoHoursLaterString = '${twoHoursLater.hour}:${twoHoursLater.minute}';
            //  String twoHoursLaterString = '06:30';
            List resultats = filteredData.where((data) => data.heure.compareTo(twoHoursLaterString) > 0).toList();
            
            if(resultats.length>0){

                isButtonPressed = true;
                nb.value=resultats.length;
                isDonnees(true);
                temps.value=0;
              

            }else{

              List result= await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
            
                  if(result.length>0){

                    nb.value=resultats.length;
                    isDonnees(true);
                    temps.value=0;

                  }else{
                    isDonnees(false);
                    temps.value=0;

                  }
              
            }

            }else{

                print("Bonsoir");
                  List result= await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur,);

                  if(result.length>0){

                      Get.to(() => TicketView(
                          data:TickeDataModel(
                          ville_depart,
                          ville_arriver,
                          transporteur,
                          groupValue,
                          dateDepart,
                          dateRetours,
                         )
                      ));
                    isDonnees(true);
                    temps.value=0;

                  }else{
                      Get.to(() => MessagesPages(
                      data:TickeMessagesPages(
                      ville_depart,
                      ville_arriver,
                      transporteur,
                      groupValue,
                      dateDepart,
                      dateRetours,
                      )
                    ));
                    isDonnees(false);
                    temps.value=0;
                  }
            }

            
            

      }


  getDestinationsRetour(String ville_depart, String ville_arriver, String transporteur,groupValue,dateDepart,dateRetours) async {
            temps.value=1;

            final DateFormat formatter = DateFormat('dd-MM-yyyy');
            var today = new DateTime.now();
            final String todays = formatter.format(today);

            if(todays==dateDepart){

                  print("Bonjour");

                      List filteredData = await ApiManager.getDestinationsRetourSeach(ville_depart, ville_arriver, transporteur);
                      DateTime now = DateTime.now();
                      DateTime twoHoursLater = now.add(Duration(hours: 1));
                      String twoHoursLaterString = '${twoHoursLater.hour}:${twoHoursLater.minute}';
                      //  String twoHoursLaterString = '20:30';
                      List resultats = filteredData.where((data) => data.heure.compareTo(twoHoursLaterString) > 0).toList();
            
                  if(resultats.length>0){

                      Get.to(() => TicketView(
                            data:TickeDataModel(
                            ville_depart,
                            ville_arriver,
                            transporteur,
                            groupValue,
                            dateDepart,
                            dateRetours,
                            )
                          ));

                          nb.value=resultats.length;
                          isDonnees(true);
                          temps.value=0;
           
                }else{

                  List result= await ApiManager.getDestinationsRetourSeach(ville_depart, ville_arriver, transporteur);
                
                      if(result.length>0){

                        Get.to(() => MessagesPages(
                          data:TickeMessagesPages(
                          ville_depart,
                          ville_arriver,
                          transporteur,
                          groupValue,
                          dateDepart,
                          dateRetours,
                          )
                        ));

                        nb.value=resultats.length;
                        isDonnees(true);
                        temps.value=0;

                      }else{

                          Get.to(() => MessagesPages(
                          data:TickeMessagesPages(
                          ville_depart,
                          ville_arriver,
                          transporteur,
                          groupValue,
                          dateDepart,
                          dateRetours,
                          )
                        ));

                        isDonnees(false);
                        temps.value=0;

                      }
                  
                }

            }else{

                print("Bonsoir");
                  List result= await ApiManager.getDestinationsRetourSeach(ville_depart, ville_arriver, transporteur);

                  if(result.length>0){

                      Get.to(() => TicketView(
                          data:TickeDataModel(
                          ville_depart,
                          ville_arriver,
                          transporteur,
                          groupValue,
                          dateDepart,
                          dateRetours,
                         )
                      ));
                    isDonnees(true);
                    temps.value=0;

                  }else{
                      Get.to(() => MessagesPages(
                      data:TickeMessagesPages(
                      ville_depart,
                      ville_arriver,
                      transporteur,
                      groupValue,
                      dateDepart,
                      dateRetours,
                      )
                    ));
                    isDonnees(false);
                    temps.value=0;
                  }
            }
           

      }

  getTicketsOne(String ville_depart, String ville_arriver, String transporteur,groupValue,dateDepart,dateRetours) async {
            temps.value=1;

            final DateFormat formatter = DateFormat('dd-MM-yyyy');
            var today = new DateTime.now();
            final String todays = formatter.format(today);

            if(todays==dateDepart){

                  print("Bonjour");

                      List filteredData = await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
                      DateTime now = DateTime.now();
                      DateTime twoHoursLater = now.add(Duration(hours: 1));
                      String twoHoursLaterString = '${twoHoursLater.hour}:${twoHoursLater.minute}';
                      //  String twoHoursLaterString = '20:30';
                      List resultats = filteredData.where((data) => data.heure.compareTo(twoHoursLaterString) > 0).toList();
            
                  if(resultats.length>0){

                      Get.to(() => TicketView(
                            data:TickeDataModel(
                            ville_depart,
                            ville_arriver,
                            transporteur,
                            groupValue,
                            dateDepart,
                            dateRetours,
                            )
                          ));

                          nb.value=resultats.length;
                          isDonnees(true);
                          temps.value=0;
           
                }else{

                  List result= await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
                
                      if(result.length>0){

                        Get.to(() => MessagesPages(
                          data:TickeMessagesPages(
                          ville_depart,
                          ville_arriver,
                            transporteur,
                            groupValue,
                            dateDepart,
                            dateRetours,
                          )
                        ));

                        nb.value=resultats.length;
                        isDonnees(true);
                        temps.value=0;

                      }else{

                          Get.to(() => MessagesPages(
                          data:TickeMessagesPages(
                          ville_depart,
                          ville_arriver,
                            transporteur,
                            groupValue,
                            dateDepart,
                            dateRetours,
                          )
                        ));

                        isDonnees(false);
                        temps.value=0;

                      }
                  
                }

            }else{

                print("Bonsoir");
                  List result= await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);

                  if(result.length>0){

                      Get.to(() => TicketView(
                          data:TickeDataModel(
                          ville_depart,
                          ville_arriver,
                          transporteur,
                          groupValue,
                          dateDepart,
                          dateRetours,
                         )
                      ));
                    isDonnees(true);
                    temps.value=0;

                  }else{
                      Get.to(() => MessagesPages(
                      data:TickeMessagesPages(
                      ville_depart,
                      ville_arriver,
                      transporteur,
                      groupValue,
                      dateDepart,
                      dateRetours,
                      )
                    ));
                    isDonnees(false);
                    temps.value=0;
                  }
            }
           

      }

  getTicketsX(String ville_depart, String ville_arriver, String transporteur) async {

      print(transporteur);
        temps.value=1;
        listTickes.value = await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
        nb.value=listTickes.length;
       
        if(nb>0){

          isDonnees(true);
          temps.value=0;

        }else{
   
          isDonnees(false);
          temps.value=0;
        }

        inspect(listTickes);
      }

  fetchGare() async {
    listVille.value = await ApiManager.getGare();
    listTransporteur.value = await ApiManager.getTansporteur();
    inspect(lisGare.value);
  }


  fetchBanners() async {
    posts.value = await ApiManager.fetchBanner();

    for(var paths in posts.value ){
          print("https://vavavoom.ci/mobile-ads/banner/${paths.bannerName}");
          // path=paths.bannerName;
          path="https://vavavoom.ci/mobile-ads/banner/${paths.bannerName}";
    }
    
  }

  changeMyValue(data) async {

    if(data==0){

      loader(false);
      optionSelect.value=data;
      print(optionSelect);

    }else if(data==1){

      loader(true);
      optionSelect.value=data;
      print(optionSelect);

    }
    
   

  }


// nous allons verifier qu'il a deja un paiement en cour !

  cleanData() async {

      final sharedPreferences = await SharedPreferences.getInstance();
        if (sharedPreferences.getString("codes") != null) {

            await sharedPreferences.remove("reseauText");
            await sharedPreferences.remove("depart");
            await sharedPreferences.remove("arriver");
            await sharedPreferences.remove("transporteur");
            await sharedPreferences.remove("gare");
            await sharedPreferences.remove("dateAller");
            await sharedPreferences.remove("prix");
            await sharedPreferences.remove("heureDepart");
            await sharedPreferences.remove("nombreTicket");
            await sharedPreferences.remove("typeVoyage");
            await sharedPreferences.remove("image");
            await sharedPreferences.remove("remise");
            await sharedPreferences.remove("nom");
            await sharedPreferences.remove("phone");
            await sharedPreferences.remove("codes");
        }
      }


    checkPaysData() async {

        final sharedPreferences = await SharedPreferences.getInstance();
            print(sharedPreferences.getString("codes".toString()));

        if (sharedPreferences.getString("codes") != null ) {

                  var reseauText=sharedPreferences.getString("reseauText".toString());
                  var depart=sharedPreferences.getString("depart".toString());
                  var arriver=sharedPreferences.getString("arriver".toString());
                  var transporteur=sharedPreferences.getString("transporteur".toString());
                  var gare=sharedPreferences.getString("gare".toString());
                  var dateAller=sharedPreferences.getString("dateAller".toString());
                  var dateRetour=sharedPreferences.getString("dateRetour".toString());
                  var prix=sharedPreferences.getString("prix".toString() );
                  var heureDepart=sharedPreferences.getString("heureDepart".toString());
                  var nombreTicket=sharedPreferences.getString("nombreTicket".toString());
                  var typeVoyage=sharedPreferences.getInt("typeVoyage");
                  var image=sharedPreferences.getString("image".toString());
                  var remise=sharedPreferences.getInt("remise");
                  var nom=sharedPreferences.getString("nom".toString());
                  var phone=sharedPreferences.getString("phone".toString());
                  var codes=sharedPreferences.getString("codes".toString());

              // nous allons faire une requette pour verifier le statut

                var wavekey ="wave_ci_prod_BRoKc90NC_ioDJ-csqkMIvPOMzidfGwFhjS7YNtk6T4ucmxisg5UI-tDCRyBc4gFy4qsaeaVL318WHkWC17Hj1KLF3mUeN3dxw";
                await http.get(Uri.parse("https://api.wave.com/v1/checkout/sessions/$codes"),
                    
                    headers: {
                        'Authorization': 'Bearer $wavekey',
                      }).then((response) {
                      var bodyresponses = jsonDecode(response.body);
                      var status = bodyresponses['payment_status'];
                      var lastpayment_error = bodyresponses['last_payment_error'];

                      print(bodyresponses['last_payment_error']);

                      if(status=="succeeded")
                          {
                            Get.dialog(
                               AlertDialog(
                                    title: Text('Paiement validé !',textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 20,fontWeight: FontWeight.w700,color: Color(0xffc40619))),
                                    content: Column(  mainAxisSize: MainAxisSize.min,  crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text('Cliquez sur le bouton pour finaliser votre achat.',textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 16,color: Color.fromARGB(255, 0, 0, 0))), ], ),
                                    
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          TextButton(
                                            onPressed: () {
                                                  Get.to(WavePaie(
                                                  reseauText:reseauText!,
                                                  depart:depart!,
                                                  arriver:arriver!,
                                                  transporteur:transporteur!,
                                                  gare:gare!,
                                                  dateAller:dateAller!,
                                                  dateRetour:dateRetour!,
                                                  prix:prix!,
                                                  heureDepart:heureDepart!,
                                                  nombreTicket:nombreTicket!,
                                                  typeVoyage:typeVoyage!,
                                                  image:image!,
                                                  remise:remise!,
                                                  nom: nom!,
                                                  phone: phone!,
                                                  waveid: codes!,
                                              ));
                                              Get.back();
                                            },
                                            style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF234a99)),),
                                            child: Text('Finaliser le paiement'),
                                          ),
                                          
                                        ],
                                      ),
                                    ],
                              ),
                              );
                                      
                          }

                     if(status=="cancelled")
                          {
                            cleanData();
                          }

                     if(status=="processing" && lastpayment_error!=null)

                          {
                             Get.dialog(
                                  AlertDialog(
                                    title: Text('Échec de paiement',textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 20,fontWeight: FontWeight.w700,color: Color(0xffc40619))),
                                    content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [ Text('Vous avez déjà lancé une transaction de paiement avec wave.',textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 16,color: Color.fromARGB(255, 0, 0, 0))), ],
                                  ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              cleanData();
                                              Get.back();
                                            },
                                            style: ButtonStyle( foregroundColor: MaterialStateProperty.all<Color>(Color(0xffc40619)),),
                                            child: Text('Annuler'),
                                          ),

                                          Spacer(),

                                          TextButton(
                                            onPressed: () {
                                               Get.to(WavePaie(
                                                  reseauText:reseauText!,
                                                  depart:depart!,
                                                  arriver:arriver!,
                                                  transporteur:transporteur!,
                                                  gare:gare!,
                                                  dateAller:dateAller!,
                                                  dateRetour:dateRetour!,
                                                  prix:prix!,
                                                  heureDepart:heureDepart!,
                                                  nombreTicket:nombreTicket!,
                                                  typeVoyage:typeVoyage!,
                                                  image:image!,
                                                  remise:remise!,
                                                  nom: nom!,
                                                  phone: phone!,
                                                  waveid: codes!,
                                              ));
                                              // Get.back();

                                             },
                                            style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Color(0xFF234a99)),),
                                            child: Text('Réessayer'),
                                          ),

                                        ],
                                      ),
                                    ],
                              ),
                              );
                          }

                    });



                  }

            }
    

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
