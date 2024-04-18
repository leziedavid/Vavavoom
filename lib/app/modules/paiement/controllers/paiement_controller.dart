import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaiementController extends GetxController {
  
  var telLength = "0".obs;
  var globalstetes = true.obs;
  var isLoding = false.obs;
  final fulname = TextEditingController().obs;
  final phone = TextEditingController().obs;
  
  // final TextEditingController fulname = TextEditingController();
  // final TextEditingController phone = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }


    void changesStates() {
      globalstetes.value=true;
      print(globalstetes);
      }
      
    void changesStatesisLoding() {
      isLoding.value=false;
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
