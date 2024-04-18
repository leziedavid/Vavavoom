import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vavavoom/app/constant/Color.dart';

class InputCustom2 extends StatelessWidget {
  const InputCustom2({
    Key? key,
    required this.controller,
    required this.text,
    required this.icon,
    this.onTap,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController controller;
  final String text;
  final int? maxLines;
  final IconData icon;
  final VoidCallback? onTap;
 
  @override
  Widget build(BuildContext context) {
    return Container(
     
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 45.h,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all( color: controller.text.isEmpty  ? const Color.fromARGB(255, 202, 202, 202)  : CustomColor.darck, ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Icon(icon,color: CustomColor.darck,),
                    SizedBox( width: 10.w, ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 1,
                      color: controller.text.isEmpty ? const Color.fromARGB(255, 202, 202, 202): CustomColor.darck,
                    ),

                    const SizedBox( width: 10, )
                  ],
               ),


                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: TextField(
                      maxLines: maxLines,
                      style: const TextStyle(fontFamily: "poppins"),
                      enabled: false,
                      controller: controller,
                      decoration: InputDecoration(
                        hintText:text,
                        border: InputBorder.none),
                    ),
                  ),
                ),

             RichText(
              text: TextSpan( style: TextStyle(fontSize: 15,),
                children: <TextSpan>[TextSpan(text:controller.text.isEmpty ?' (Optionnel)':" ", style: TextStyle(color: const Color.fromARGB(255, 221, 8, 8) ))  ],
                ),
              ),
                
              ],
            ),
          )
        ],
      ),
    );

  }
}
