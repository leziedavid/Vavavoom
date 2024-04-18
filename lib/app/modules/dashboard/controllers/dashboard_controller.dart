import 'package:get/get.dart';

class DashboardController extends GetxController {

  //TODO: Implement DashboardController
  final actions = false.obs;
  final count = 0.obs;
  final listeticketByScanner = [].obs;
  final statuts =7.obs;
  final etape = false.obs;

  // cette fonction permet de voir le status du scanner
  getStatus(int status,data){
    print(status);
    actions.value =true;
    statuts.value = status;
    listeticketByScanner.value=data;
    etape(true);
    }

  changeValue(){
     etape(false);
    }

   
  @override
  void onInit() {
    super.onInit();
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
