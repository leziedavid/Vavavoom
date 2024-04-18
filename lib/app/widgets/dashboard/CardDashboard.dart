import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:vavavoom/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:vavavoom/app/modules/ticket/controllers/ticket_controller.dart';
import 'package:vavavoom/app/modules/ticket/views/GareListeTicket.dart';
import 'package:vavavoom/app/modules/ticket/views/SearchTicketByCode.dart';

class CardDashboard extends StatelessWidget {
  const CardDashboard({
     Key? key,
    required this.text,
    required this.icon,
    required this.color,
    required this.link,
    required this.etape,
  
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Color color;
  final int link;
  final int etape;

  @override
  Widget build(BuildContext context) {

  TicketController controller = Get.put(TicketController());
  DashboardController dashboardController = Get.put(DashboardController());
  controller.onInit();

    return GestureDetector(
      onTap: () {

        if(link>0 && etape==1){

          Get.to( GareListeTicket());
          controller.getDataTickeAdmin();

        }else if(link>0 && etape==2){
          Get.to( SearchTicketByCode());
          // controller.getTicketByCode();

        }else if(link==0 && etape==0){
          _scan();
         }
       
      },

      child: Material(
        elevation: 2,
        child: Column(
          children: [
            Container(
              height: 50,
              color: color,
              width: double.infinity,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
            )
          ],
        ),
      ),
    );


  }


Future _scan() async {

  TicketController controller = Get.put(TicketController());
  controller.onInit();
  DashboardController dashboardController = Get.put(DashboardController());
  dashboardController.onInit();

  await Permission.camera.request();
  String? barcode = await scanner.scan();

  if (barcode == null) {
  
    print('nothing return.');

    } else {

    print(barcode);
    print("ok");
    controller.getDataByScans(barcode);
    dashboardController.getStatus(controller.statutTicket.value,controller.ticketByScanner);

    }
    
  }


}

