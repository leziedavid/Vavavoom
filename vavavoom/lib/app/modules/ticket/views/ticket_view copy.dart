import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoum/app/constant/Color.dart';
import 'package:vavavoum/app/modules/ticket/views/detail_ticket_view.dart';

import '../controllers/ticket_controller.dart';

class TickeDataModel {
  String ville_depart;
  String ville_arriver;
  String transporteur;

  TickeDataModel(this.ville_depart,this.ville_arriver,this.transporteur);
}

class TicketView  extends GetView<TicketController> {
  final TickeDataModel? data;
  const TicketView({
    Key? key,
    this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    Get.put(TicketController());
    controller.getTickets(data!.ville_depart,data!.ville_arriver,data!.transporteur);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.primary,
        title: const Text('Trouver mon ticket'),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 225, 225, 225),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              height: 40.h,
              alignment: Alignment.center,
              child: TextField(
                onChanged: (value) {},
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Recherche le transporteur",
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
            Text(data!.ville_depart),
             Text(data!.ville_arriver),
            Text(data!.transporteur),
           
            SizedBox(
              height: 20.h,
            )
            ,
            Obx(() => controller.load.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                :

                 Hero(
                  
                    tag: "ticket",
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const DetailTicketView());
                      },
                      
                      child: ClipPath(
                        clipper: const ClipPathModule1(heigth: 2),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            height: 170.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "AVS",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontFamily: 'poppins'),
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          "Gare",
                                          style:
                                              TextStyle(fontFamily: "poppins"),
                                        ),
                                        Text(
                                          "Abengourou",
                                          style: TextStyle(
                                              fontFamily: "poppins",
                                              fontSize: 15.sp,
                                              color: CustomColor.primary),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "AVS",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontFamily: 'poppins'),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    DottedDashedLine(
                                        height: 0,
                                        dashColor: Colors.grey,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                105.w,
                                        axis: Axis.horizontal),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_sharp,
                                            color: CustomColor.primary,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            "5h00",
                                            style: TextStyle(
                                                fontSize: 20.sp,
                                                fontFamily: 'poppins',
                                                color: CustomColor.primary,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "3500 fcfa",
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            fontFamily: 'poppins',
                                            color: CustomColor.primary,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ])
                              ],
                            ),
                          ),
                        ),
                      ),
                    
                    
                    ),
                  )
                  )

          ],
        ),
      ),
    );
  
  }
}

class ClipPathModule1 extends CustomClipper<Path> {
  final double heigth;
  final double? raduis;

  const ClipPathModule1({
    required this.heigth,
    this.raduis = 25,
  });
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.addOval(Rect.fromCircle(
        center: Offset(0, size.height / heigth), radius: raduis!));
    path.addOval(Rect.fromCircle(
      center: Offset(size.width, size.height / heigth),
      radius: raduis!,
    ));
    path.fillType = PathFillType.evenOdd;
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
