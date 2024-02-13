import 'package:get/get.dart';

import '../controllers/paiement_controller.dart';

class PaiementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaiementController>(
      () => PaiementController(),
    );
  }
}
