import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';

import '../controllers/partenaire_controller.dart';

class PartenaireView extends GetView<PartenaireController> {
  const PartenaireView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PartenaireController());

  //  print('value = ${controller.listPartner}');

    return Scaffold(
      

     appBar: AppBar(
          title:  Text('Nos partenaires',style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton(
              onPressed: (){ Navigator.pop(context); },
              icon: Icon(Icons.arrow_back_sharp,
              color: Colors.white,),
            ),
      ),

      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: controller.loadPartner.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.primary,
                  ),
                )
              : GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 20,
                  children: controller.listPartner
                      .map(
                        (element) => Material(
                          elevation: 3,
                          borderRadius: BorderRadius.circular(10),
                          
                          
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage( image: NetworkImage(element["url"]), fit: BoxFit.contain)),
                          ),
                        ),
                      )
                      .toList(),
                ),
        );
      }),
    );
  }
}
