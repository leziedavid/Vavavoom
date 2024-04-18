import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// Importation de la bibliothèque de formatage de date et d'heure
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoom/app/Services/Api/ApiManager.dart';
import 'package:vavavoom/app/constant/Apis.dart';

class TicketController extends GetxController {
  //TODO: Implement TicketController
  var nbPlace = 1.obs;
  var remise = 0.obs;
  final count = 0.obs;
  final load = false.obs;
  final listTickes = [].obs;
  // final filteredData = [].obs;
  var sommes = 0.obs;
  var somme= 0.obs;
  var sommeIntial= 0.obs;
  var sommeTva= 0.obs;
  var fraisTrans = 0.obs;

  final dataSearch = [].obs;
  final copyDataSearch = [].obs;

  final listeTicketByPhone = [].obs;
  final listeTicketByUsers = [].obs;
  final listeTicketByCode = [].obs;
  final listeTicketByAdmin = [].obs;
  final ticketByScanner = [].obs;

  // Timer? timer;
final nb = 0.obs;
final users ="".obs;
final compagnie_Id ="".obs;
final statutTicket =6.obs;
final adminGare ="".obs;
final etape = false.obs;
final adminConnecte = false.obs;

var dropdownValue ="1".obs;
final loader = false.obs;
final actions = false.obs;
var item = ['1','2','3','4','5','6','7','8','9','10'];
var telLength = "0".obs;
var states =false.obs;
var stateSearch =false.obs;
var etapes =false.obs;
final errors =false.obs;
var progress =true.obs;

 bool isButtonPressed = false;

  RxDouble montantHT = 0.0.obs;
  RxDouble tauxTVA = 0.18.obs;
  RxString montantTTC = '0.0'.obs;
  RxString tvaApplique = '0.0'.obs;
  // RxString somtotalTVA = '0.0'.obs;

// donnée d'authentification
  var token,role,userId,usernames,userName,compagnieId, gare;


  var currentTime = DateFormat('HH:mm').format(DateTime.now()).obs; // Heure actuelle formatée en "HH:mm"
  var databaseTime = ''.obs; // Heure provenant de la base de données
  // bool get isSameTime => currentTime.value == databaseTime.value; // Comparaison des heures


  @override
  void onInit() {
      checkLoginStatus();
      copyDataSearch.value = dataSearch;
      super.onInit();
  }
 
    reloader(){
      listTickes.value = [].obs;
      nb.value = 0;
     }


    checkLoginStatus() async {
    
      final sharedPreferences = await SharedPreferences.getInstance();
        if(sharedPreferences.getString("nom") != "")
            {
                  token= sharedPreferences.getString("token").toString();
                  role = sharedPreferences.getString("role").toString();
                  userName = sharedPreferences.getString("nom").toString();
                  userId =sharedPreferences.getInt("id").toString();
                  
                  compagnieId = sharedPreferences.getString("compagnie_id").toString();
                  gare= sharedPreferences.getString("gare").toString();

                  // recuperation
                  users.value=userId;
                  compagnie_Id.value=compagnieId;
                  adminGare.value=sharedPreferences.getString("gare").toString();

                    if(role == "chef_gare" || role == "gestionnaire_ticket")
                      {
                        adminConnecte(true);
                        
                      }else{

                        adminConnecte(false);
                    }

                    print(adminConnecte);
            }

      }

    getTickets(String ville_depart, String ville_arriver, String transporteur,groupValue,dateDepart,dateRetours) async {

        final DateFormat formatter = DateFormat('dd-MM-yyyy');
        var today = new DateTime.now();
        final String todays = formatter.format(today);

        if(todays==dateDepart){
       
                load(true);
                List filteredData = await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
                DateTime now = DateTime.now();
                DateTime twoHoursLater = now.add(Duration(hours: 1));
                String twoHoursLaterString ='${twoHoursLater.hour}:${twoHoursLater.minute}';
                List resultats = filteredData.where((data) => data.heure.compareTo(twoHoursLaterString) > 0).toList();

              if(resultats.length>0){

                  load(false);
                  loader(true);
                  isButtonPressed=true;
                  listTickes.value=resultats;

              }else{
                load(true);
                  listTickes.value = await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
                load(false);
              }

          }else{
            load(true);
            listTickes.value = await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
            load(false);
          }
      }

    cleanData() async {
      listeTicketByPhone.value=[].obs;
      listeTicketByUsers.value=[].obs;
      stateSearch(false);
      states(false);
      etapes(false);
      etape(false);
      progress(true);
      statutTicket.value=6;
      ticketByScanner.value =[].obs;
      actions(false);

  }

    // faire des recherche des ticket par le numero le code ,et le qrscan

    getTicketByPhone(String phones) async {

        listeTicketByPhone.value = await ApiManager.searchTicket(phones);
        
        if(listeTicketByPhone.value.length>0){
          states(false);
          stateSearch(true);
          etapes(false);
          progress(false);

        }else{
           states(false);
           stateSearch(false);
           etapes(true);
           progress(false);
        }
          print(phones);
          
        }

    getTicketbyCode(String codes) async {

      listeTicketByCode.value = await ApiManager.getBilletBycode(codes);
      print(listeTicketByCode);

      if(listeTicketByCode.value.length>0){

          states(false);
          stateSearch(true);
          etapes(false);
          progress(false);

        }else{

           states(false);
           stateSearch(false);
           etapes(true);
           progress(false);
        }
          print(codes);
    }

    searchTickes(String text,List tickesData,String ville_depart, String ville_arriver, String transporteur,groupValue,dateDepart,dateRetours) async {
             
              if (text!="") {
                    load(true);
                    final filteredData = tickesData.where((item){
                    final titleLower = item.gare.toLowerCase();
                    final authorLower = item.compagnieName.toLowerCase();
                    final searchLower = text.toLowerCase();
                    return titleLower.contains(searchLower) || authorLower.contains(searchLower);
                  }).toList();

                    if(filteredData.isNotEmpty){
                      errors(false);
                      load(false);
                      listTickes.value=filteredData;

                  }else {

                    errors(true);
                    print(tickesData);
                    load(false);
                    getTickets(ville_depart,ville_arriver,transporteur,groupValue,dateDepart,dateRetours);
                  }
                inspect(filteredData);

              }else{
                 errors(false);
                 load(false);
                 getTickets(ville_depart,ville_arriver,transporteur,groupValue,dateDepart,dateRetours);
              }


        }

    getPrice(String nombres,int price, int typeVoyage,int destinationInter) async {
      var item=0;
      if(destinationInter==0){

        if(typeVoyage==1){
          item=1000;
        }else{

        item=500;
        }

      }else{

      if(typeVoyage==1){

          item=2000;

        }else{

        item=1000;
        }

      }


       
        fraisTrans.value=int.parse(nombres)*item;
        somme.value = int.parse(nombres)*price;

        if(int.parse(nombres)==1){

          sommeIntial.value = price;

        }else{

          sommeIntial.value = int.parse(nombres)*price;
        }

        // double totalTTC =(sommeIntial.value * tauxTVA.value + somme.value+100+fraisTrans.value);
        double totalTTC =(sommeIntial.value * tauxTVA.value + somme.value+fraisTrans.value);
        double somtotalTVA =(sommeIntial.value * tauxTVA.value);
        montantTTC.value = totalTTC.toStringAsFixed(0);
        tvaApplique.value = somtotalTVA.toStringAsFixed(0);
        // somme.value+=fraisTrans.value;
        // sommes.value=somme.value;

        // print(montantTTC);
      }

// envoie des ticket apres authentification cleint et admin
    getDataTickeAdmin() async {
      
        checkLoginStatus();
        print(compagnie_Id);

        listeTicketByAdmin.value = await ApiManager.getBillet(compagnie_Id.toString());
        //  listeTicketByAdmin.value=[].obs;
          print(listeTicketByAdmin);

        if(listeTicketByAdmin.value.length>0){

          states(false);
          stateSearch(true);
          progress(false);
          etapes(false);

        }else{
           states(false);
           stateSearch(false);
           etapes(true);
           progress(false);
        }
    }

    getData() async {
      
        checkLoginStatus();
        print(users);
        listeTicketByUsers.value = await ApiManager.getHistorique(userId);
        if(listeTicketByUsers.value.length>0){

          states(false);
          stateSearch(true);
          progress(false);
          etapes(false);

        }else{
           states(false);
           stateSearch(false);
           etapes(true);
           progress(false);
        }
  }

    getDataByScans(String barcode) async {
        
        checkLoginStatus();
        print(compagnie_Id);
        try {
              final response = await http.get(
                Uri.parse("${HostApi.baseUrl}/validatorticket/$barcode/+$compagnie_Id"),
              );
              int data = jsonDecode(response.body);
              statutTicket.value=data;
              ticketByScanner.value = await ApiManager.dataByScansCodes(barcode);
              actions.value=true;
              etape(true);

            } catch (e) {
              print("lose");
              print(e.toString());
              return [];
        }

    }

    verify(String code) async {

        checkLoginStatus();
        print(compagnie_Id);

        try {
            final response = await http.get( Uri.parse("${HostApi.baseUrl}/validatorcodeticket/$code/+$compagnie_Id"),); 
            int data = jsonDecode(response.body);

              listeTicketByCode.value = await ApiManager.getBilletBycode(code);
              print(listeTicketByCode);

                if(listeTicketByCode.value.length>0){
                    states(false);
                    stateSearch(true);
                    etapes(false);
                    progress(false);

                    }else{

                    states(false);
                    stateSearch(false);
                    etapes(true);
                    progress(false);
                  }
                print(code);

            } catch (e) {

              print("lose");
              print(e.toString());

              return [];
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

    void incrementPlace()  {

      if (nbPlace.value <= 1 || nbPlace.value == 0 )
        {
          nbPlace.value++;
        }
      }

    void decrementPlace() {

      if (nbPlace.value >= 1 || nbPlace.value == 0 )
          {
            nbPlace.value--;
          }
      }

  // void decrementPlace() => nbPlace.value--;
  // Plus de départ disponible. Vous pouvez réserver pour demain ou passer en voyage d'urgence pour essayer d'y aller aujourd'hui.
  // Nous allons effectué des verification

  
}
