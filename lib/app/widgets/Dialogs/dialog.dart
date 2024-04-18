import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/home/controllers/home_controller.dart';

openDialog(TextEditingController controller, List data, String? text, String? title) {
  
  HomeController homeController = Get.put(HomeController());
  homeController.dataSearch.value = data;
  /// It's a function that opens a dialog box.
  Get.defaultDialog(
    title: title!,
    radius: 7,
    content: SizedBox(
      width: 250.w,
      height: 250.w,
      child: Obx(
        () { 
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromARGB(207, 234, 232, 232)),
                height: 30.h,
                child: TextFormField(
                  onChanged: (value) { homeController.searchVille(value, data);},
                  decoration: InputDecoration( border: InputBorder.none, hintText: "Recherche $title",
                      prefixIcon: const Icon(Icons.search)),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...homeController.dataSearch
                        .map(
                          (e) => ListTile(
                            style: ListTileStyle.list,
                            title: Text(
                              e.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  color:
                                      text != e ? Colors.black : Colors.grey),
                            ),
                                selectedTileColor: CustomColor.primary,
                                selected: homeController.selectVille.value == e && homeController.selectVille.value.isNotEmpty
                                ? true
                                : false, selectedColor: Colors.blue[100],
                            onTap: () {
                              if (text != e) {
                                controller.text = e;
                                log(homeController.selectVille.value);
                                homeController.selectVille.value = e;
                                Get.back();
                              }
                            },
                          ),
                        )
                        .toList()
                  ],
                ),
              )
            ],
          );
        },
      ),
    ),
  );
}

openDialogTransporteur( TextEditingController controller, List data, String? text, String? title){
  HomeController homeController = Get.put(HomeController());
  homeController.dataSearch.value = data;

  Get.defaultDialog(
    title: title!,
    radius: 7,
    content: SizedBox(
      width: 250.w,
      height: 250.w,
      child: Obx(
        () {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(207, 234, 232, 232)),
                height: 30.h,
                child: TextFormField(
                  onChanged: (value) {
                    homeController.searchVille(value, data);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Recherche $title",
                      prefixIcon: const Icon(Icons.search)),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [...homeController.dataSearch
                        .map((e) => ListTile(
                            title: Text(e.toUpperCase(),
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  color: homeController.listTransporteurSelected.contains(e.toUpperCase())
                                      ? CustomColor.primary
                                      : Colors.black),
                            ),trailing: homeController.listTransporteurSelected.contains(e.toUpperCase())
                                ? Icon(
                                    Icons.check,
                                    color: homeController.listTransporteurSelected.contains(e.toUpperCase())
                                        ? CustomColor.primary
                                        : Colors.black,
                                  )
                                : null,
                            onTap: () {

                              if (homeController.listTransporteurSelected.contains(e.toUpperCase())) {

                                homeController.listTransporteurSelected.remove(e.toUpperCase());

                              } else {

                                homeController.listTransporteurSelected.add(e.toUpperCase());

                              }
                              homeController.transporteur.value.text = homeController.listTransporteurSelected.join(",");
                              // options = "";
                            },
                          ),
                        )
                        .toList()
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CustomColor.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          );
        },
      ),
    ),
  );
}

openDialogTickerDashboard() {
  Get.defaultDialog(
      title: "Entrez le code à 4 chiffre du ticket pour la vérification",
      content: TextFormField(
        onChanged: (value) {},
        validator: (value) {
          if (value!.length < 10) {
            return "Téléphone à 10 chiffresn obligatoire";
          }
        },
        // controller: phone,
        keyboardType: TextInputType.number,
        strutStyle: const StrutStyle(),
        decoration: const InputDecoration(
          labelText: "Téléphone",
          labelStyle: TextStyle(fontFamily: "poppins"),
          border: OutlineInputBorder(),
        ),
      ));
}

openDialogSearchTicker(String villeDepart, String villeArrive,String transporteur) { 
    HomeController homeController = Get.put(HomeController());
  //  homeController.getTickets(villeDepart,villeArrive,transporteur);
  //   if(homeController.nb.value>0){
      
  //   }

  Get.defaultDialog(

        title: 'Erreur 403',
        content: Text('Aucun itinéraire ne correspond à vos choix. Veuillez choisir une autre destination.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 255, 1, 1), fontWeight: FontWeight.bold), ),
        buttonColor: const Color.fromARGB(255, 243, 33, 33),
        onCancel: () => print("cancle"),
        // onCancel: () => homeController.listTickes.value = [].obs,
        textCancel: 'Fermer',
        // textConfirm: 'Submit',
        // onConfirm: () => print("Ok"),
        //// backgroundColor: Get.theme.accentColor,
      );
}