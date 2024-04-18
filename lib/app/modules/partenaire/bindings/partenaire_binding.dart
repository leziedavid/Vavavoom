import 'package:get/get.dart';

import '../controllers/partenaire_controller.dart';

class PartenaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartenaireController>(
      () => PartenaireController(),
    );
  }
}
