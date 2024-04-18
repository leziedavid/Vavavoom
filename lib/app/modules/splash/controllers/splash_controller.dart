import 'package:get/get.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  // nous allons verifier sille un payement en cours si oui continuer sur la page de wave si nom retour sur la page d'accueil

  // final options = ["Aller-Simple", "Aller-Retour"].obs;
  // final villeDeparts = TextEditingController().obs;
  // final villeArrives = TextEditingController().obs;
  // final dateDeparts = TextEditingController().obs;
  // final dateRetours = TextEditingController().obs;
  // final transporteurs = TextEditingController().obs;
  // final listTransporteurSelecteds = <String>[].obs;
  // final listTransporteurs = [].obs;

  //     checkLoginStatus() async {
  //         sharedPreferences = await SharedPreferences.getInstance();
  //         if(sharedPreferences?.getString("token") != null ||sharedPreferences?.getString("role") != null || sharedPreferences?.getInt("id") != null|| sharedPreferences?.getString("nom") != null ) {
  //           setState(() {
  //               token = sharedPreferences?.getString("token");
  //               role = sharedPreferences?.getString("role");
  //               userName = sharedPreferences?.getString("nom");
  //               phoneNumber = sharedPreferences?.getString("telephone");
  //               userId = sharedPreferences?.getInt("id");
  //             });
  //             return sharedPreferences?.getString("token");
  //         }
  //       }

  final count = 0.obs;
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
