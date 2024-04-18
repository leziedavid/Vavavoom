import 'package:get/get.dart';
import 'package:vavavoom/app/Services/Api/ApiManager.dart';

class PartenaireController extends GetxController {
  //TODO: Implement PartenaireController

  final listPartner = [].obs;
  final loadPartner = false.obs;
  

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchPartner();
  }

  fetchPartner() async {
    loadPartner(true);
    listPartner.value = await ApiManager.getPartner();
    loadPartner(false);
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
