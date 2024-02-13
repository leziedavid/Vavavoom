import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vavavoum/app/Services/Api/ApiManager.dart';

// import 'package:share/share.dart';

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

  int get selected => groupValue.value;
  final count = 0.obs;
  final temps = 0.obs;

  Timer? timers;
  
  @override
  void onInit() {
    copyDataSearch.value = dataSearch;
    super.onInit();
    fetchBanners();
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

  getTickets(String ville_depart, String ville_arriver, String transporteur) async {

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
