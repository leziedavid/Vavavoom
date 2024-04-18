import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/auth/views/signin_view.dart';
import 'package:vavavoom/app/modules/auth/views/signup_view.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Get.put(AuthController());
    
    return Scaffold(appBar: AppBar(centerTitle: true, backgroundColor: CustomColor.primary,elevation: 0, ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: CustomColor.primary,
        width: double.infinity,
        child: Obx(() {
          return controller.loadAuth.value==true
              ? const Center( child: CircularProgressIndicator(color: Colors.white, ),)
              : PageView(controller: controller.pageController,
                  children: [ Signin(controller: controller,), Signup(controller: controller) ],
              );
        }),
      ),
    );
  }
}
