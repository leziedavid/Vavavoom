import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Fonctions/lancherUrl.dart';
import '../controllers/auth_controller.dart';

class Signin extends StatelessWidget {
  const Signin({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage( image: AssetImage("assets/images/logovavavoom-01.jpg"),  fit: BoxFit.cover, ),
          ),
          height: 90.h,
        ),

        Text("Connexion", textAlign: TextAlign.center, style: TextStyle( fontFamily: "poppins",  fontSize: 22.sp, color: Colors.white,fontWeight: FontWeight.w600),),
        const SizedBox( height: 10, ),
        Text("Connectez-vous pour accéder de vos historiques d'achats",textAlign: TextAlign.center,style: TextStyle( fontFamily: "poppins",fontSize: 15.sp,color: Colors.white,),),
       
        const SizedBox(
          height: 80,
        ),

        TextFormField(
            maxLength: 10,
            controller: controller.phone,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide( width: 2, color: Colors.amberAccent), ),
            border: OutlineInputBorder( borderRadius: BorderRadius.circular(4),),
            filled: true, //<-- SEE HERE
            fillColor: Colors.white,
            hintText: "Numéro de téléphone",
            hintStyle: const TextStyle(fontFamily: "poppins"),
            prefixIcon: const Icon(Icons.phone, ),
          ),
        ),

        const SizedBox(
          height: 15,
        ),

        Obx(()  =>controller.isObsureText.value
                 ? TextFormField(
                    controller: controller.password,
                    keyboardType: TextInputType.phone,
                    obscureText: controller.isObsureText.value,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.amberAccent), ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),  ),
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.yellow,
                      hintText: "Votre Code pin ou code secret",
                      hintStyle: const TextStyle(fontFamily: "poppins"),
                      prefixIcon: const Icon(Icons.security),
                      suffixIcon: IconButton(
                      onPressed: () {controller.isObsureText(!controller.isObsureText.value); },
                        icon:Obx(()  =>controller.isObsureText.value==false
                        ? const Icon( Icons.remove_red_eye,color: Colors.black,)
                        : const Icon( Icons.remove_red_eye_outlined, color: Colors.black, ),
                        ),

                      ),
                    ),
                  ):
              
                  TextFormField(
                      controller: controller.password,
                      keyboardType: TextInputType.phone,
                      
                      obscureText: controller.isObsureText.value,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.amberAccent), ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),  ),
                        filled: true,
                        fillColor: Colors.white,
                        focusColor: Colors.yellow,
                        hintText: "Votre Code pin ou code secret",
                        hintStyle: const TextStyle(fontFamily: "poppins"),
                        prefixIcon: const Icon(Icons.security),
                        suffixIcon: IconButton(
                        onPressed: () {controller.isObsureText(!controller.isObsureText.value); },
                          icon:Obx(()  =>controller.isObsureText.value==false
                          ? const Icon( Icons.remove_red_eye,color: Colors.black,)
                          : const Icon( Icons.remove_red_eye_outlined, color: Colors.black, ),
                          ),

                        ),
                      ),
                    ),
             ),
        
        // TextFormField(
        //   controller: controller.password,
        //   keyboardType: TextInputType.phone,
          
        //   obscureText: controller.isObsureText.value,
        //   decoration: InputDecoration(
        //     focusedBorder: const OutlineInputBorder(
        //     borderSide: BorderSide(width: 2, color: Colors.amberAccent), ),
        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(4),  ),
        //     filled: true,
        //     fillColor: Colors.white,
        //     focusColor: Colors.yellow,
        //     hintText: "Votre Code pin ou code secret",
        //     hintStyle: const TextStyle(fontFamily: "poppins"),
        //     prefixIcon: const Icon(Icons.security),
        //     suffixIcon: IconButton(
        //     onPressed: () {controller.isObsureText(!controller.isObsureText.value); },
        //       icon:Obx(()  =>controller.isObsureText.value==false
        //       ? const Icon( Icons.remove_red_eye,color: Colors.black,)
        //       : const Icon( Icons.remove_red_eye_outlined, color: Colors.black, ),
        //       ),

        //       // icon: controller.isObsureText.value
        //       // ? const Icon( Icons.remove_red_eye,color: Colors.black,)
        //       // : const Icon( Icons.remove_red_eye_outlined, color: Colors.black, ),

        //     ),
        //   ),
        // ),

        const SizedBox(
          height: 15,
        ),
        GestureDetector(
          onTap: () {
            if (controller.phone.text.isNotEmpty && controller.password.text.isNotEmpty) { controller.login(); }
          },
          child: Material(
            elevation: 1,
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.yellow),
              child: Text("Se connecter",
                style: TextStyle(
                    fontFamily: "poppins",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        const SizedBox(  height: 30,  ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                launchInBrowser(Uri.parse("https://vavavoom.ci/mot-passe-oublier"));},
              child: const Text("Mot de passe oublié ?",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: "poppins",
                    color: Colors.yellow),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.pageController.nextPage(
                    duration: const Duration(microseconds: 300),
                    curve: Curves.bounceInOut);
              },
              child: const Text("Inscrivez vous ici",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: "poppins",
                    color: Colors.yellow),
              ),
            ),
          ],
        )
      ],
    );
  }
}

