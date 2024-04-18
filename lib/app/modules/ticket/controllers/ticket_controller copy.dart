import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vavavoom/app/Services/Api/ApiManager.dart';

class TicketController extends GetxController {
  //TODO: Implement TicketController
  var nbPlace = 1.obs;
  var remise = 0.obs;
  final count = 0.obs;
  final load = false.obs;
  final listTickes = [].obs;
  var sommes = 0.obs;
  var somme= 0.obs;
  var fraisTrans = 0.obs;
  final dataSearch = [].obs;
  final copyDataSearch = [].obs;

  final listeTicketByPhone = [].obs;
  final listeTicketByUsers = [].obs;
  final listeTicketByCode = [].obs;
  final listeTicketByAdmin = [].obs;

  // Timer? timer;
final nb = 0.obs;
final users ="".obs;
final compagnie_Id ="".obs;

var dropdownValue ="1".obs;
final loader = false.obs;
 var item = ['1','2','3','4','5','6','7','8','9','10'];
 var telLength = "0".obs;
 var states =false.obs;
var stateSearch =false.obs;
var etapes =false.obs;
var progress =true.obs;

// donnée d'authentification
var token,role,userId,usernames,userName,compagnieId, gare;

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
            }

      }

    getTickets(String ville_depart, String ville_arriver, String transporteur) async {
       
        load(true);
        listTickes.value = await ApiManager.getTicketSeach(ville_depart, ville_arriver, transporteur);
        
        if(listTickes.value.length>0){

            load(false);
            loader(true);
            
        }else{
           load(true);
        }
       
        print(listTickes);
      } 

    cleanData() async {
    listeTicketByPhone.value=[].obs;
    listeTicketByUsers.value=[].obs;
    stateSearch(false);
    states(false);
    etapes(false);
    progress(true);

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


    searchTickes(String text,List tickesData) async {
              if (text!="") {

                  load(true);
                  final filteredData = tickesData.where(
                          (item) => item.compagnieName.toLowerCase().contains(text.toLowerCase())
                  ).toList();
                  print(filteredData);

                  if(filteredData.length>0){

                    load(false);
                    listTickes.value=filteredData;

                  }else{

                    load(false);
                    listTickes.value = tickesData;
                  }
                  } else {

                  load(false);
                  listTickes.value = tickesData;
              
              }

        }   

    getPrice(String value,int price) async {
      var item=500;
        fraisTrans.value=int.parse(value)*item;
        somme.value = int.parse(value)*price; 
        somme.value+=fraisTrans.value;
        //pour avoir un entier ici j'ai donc 455320
        sommes.value=somme.value;
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
        //  listeTicketByUsers.value=[].obs;
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
}
