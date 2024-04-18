import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class Signup extends StatelessWidget {
  const Signup({
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
            image: DecorationImage(
              image: AssetImage("assets/images/logovavavoom-01.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          height: 100.h,
        ),
        Text("Inscription",textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "poppins",
              fontSize: 22.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox( height: 10, ),
        Text("Inscrivez-vous afin de créer un ccompte historique d'achat.",
          textAlign: TextAlign.center,
          style: TextStyle( fontFamily: "poppins", fontSize: 15.sp, color: Colors.white,),
        ),
        const SizedBox( height: 80,),
        TextFormField(
          controller: controller.fullName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.amberAccent),
            ),
            border: OutlineInputBorder( borderRadius: BorderRadius.circular(4), ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Nom & Prénoms",
            hintStyle: const TextStyle(fontFamily: "poppins"),
            prefixIcon: const Icon( Icons.person,),
          ),
        ),
        const SizedBox( height: 15,),

        TextFormField(
          maxLength: 10,
          controller: controller.registerPhone,
          keyboardType: TextInputType.text,
          decoration: InputDecoration( focusedBorder: const OutlineInputBorder( borderSide: BorderSide(width: 2, color: Colors.amberAccent),  ),
            border: OutlineInputBorder( borderRadius: BorderRadius.circular(4), ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Numéro de téléphone",
            hintStyle: const TextStyle(fontFamily: "poppins"),
            prefixIcon: const Icon(
              Icons.phone,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        
        Obx(()  =>controller.isObsureText.value
            ? TextFormField(
                  controller: controller.registerPassword,
                  keyboardType: TextInputType.phone,
                  obscureText: controller.isObsureText.value,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.amberAccent),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.yellow,
                    hintText: "Votre Code pin ou code secret",
                    hintStyle: const TextStyle(fontFamily: "poppins"),
                    prefixIcon: const Icon(Icons.security),
                    suffixIcon: IconButton( onPressed: () {controller.isObsureText(!controller.isObsureText.value); },
                       icon:Obx(()  =>controller.isObsureText.value==false
                        ? const Icon( Icons.remove_red_eye,color: Colors.black,)
                        : const Icon( Icons.remove_red_eye_outlined, color: Colors.black, ),
                        ),
                    ),
                  ),
                ):TextFormField(
                controller: controller.registerPassword,
                keyboardType: TextInputType.phone,
                obscureText: controller.isObsureText.value,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.amberAccent),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.yellow,
                  hintText: "Votre Code pin ou code secret",
                  hintStyle: const TextStyle(fontFamily: "poppins"),
                  prefixIcon: const Icon(Icons.security),
                  suffixIcon: IconButton( onPressed: () {controller.isObsureText(!controller.isObsureText.value); },
                    icon:Obx(()  =>controller.isObsureText.value==false
                        ? const Icon( Icons.remove_red_eye,color: Colors.black,)
                        : const Icon( Icons.remove_red_eye_outlined, color: Colors.black, ),
                        ),
                  ),
                ),
              ),

         ),





        const SizedBox(
          height: 15,
        ),
        GestureDetector(

          onTap: () {

            if (controller.registerPhone.text.isNotEmpty && controller.registerPassword.text.isNotEmpty && controller.fullName.text.isNotEmpty) 
              { 
                controller.registers();
              }

            },

          child: Material(
            elevation: 1,
            child: Container(
              height: 60,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.yellow),
              child: Text("S'inscrire",style: TextStyle(fontFamily: "poppins", fontSize: 16.sp, fontWeight: FontWeight.w600), ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Column(
          children: [
            Text("Vous avez un compte ? ",
              style: TextStyle(
                fontFamily: "poppins",
                fontSize: 15.sp,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () { controller.pageController.previousPage( duration: const Duration(microseconds: 3000), curve: Curves.bounceInOut); },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Connectez-vous ",
                      style: TextStyle(
                          fontFamily: "poppins",
                          fontSize: 15.sp,
                          color: Colors.white),
                    ),
                    TextSpan(
                      text: "ici",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: "poppins",
                          fontSize: 15.sp,
                          color: Colors.yellow),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
