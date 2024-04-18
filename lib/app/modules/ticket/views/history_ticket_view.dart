import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/ticket/views/ModelTickesViews.dart';

import '../controllers/ticket_controller.dart';

class HistoryTicketView extends GetView<TicketController> {

  const HistoryTicketView({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {

    ScrollController scollBarController = ScrollController();
    final  codes = TextEditingController();
    Get.put(TicketController());
    final  pays = 0;
    final _formKey = GlobalKey<FormState>();
    DateTime selectedDate = DateTime.now();
    
    // final datas= controller.getData();
     controller.onInit();

    return Scaffold(

      appBar: AppBar(
              title:  Text('MES TICKETS',style: TextStyle(fontFamily: "poppins",
              fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
              centerTitle: true,
              backgroundColor: CustomColor.primary,
              leading: IconButton(onPressed: (){ 
                Navigator.pop(context); 
                controller.cleanData();

                },
              icon: Icon(Icons.arrow_back_sharp,color: Colors.white,), ),
            ),

      body: Container(
        // color: const Color.fromARGB(255, 225, 225, 225),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [

                const ListTile(
                    leading: CircleAvatar(child: Icon(CupertinoIcons.tickets,size: 60)),
                    title: Text('HISTORIQUE DE VOS TICKETS', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700 )),
                  ),

                  //title: Text('HISTORIQUE DE VOS TICKETS',textAlign: TextAlign.center, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700 )),

                  const  Divider(height: 15),
                  SizedBox( height: 0.h, ),
                // ||
                 Obx(() => controller.progress.value==true? 
                 Container(
                      height: 120.h,
                        child: Column(
                            children: [
                              Text("Chargement...",textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 20.sp,fontWeight: FontWeight.w700)),
                              SizedBox( height: 30.h,),
                              Center( child: CircularProgressIndicator(),)
                            ],
                          ),
                  ):
                  Container(padding: EdgeInsets.all(10.sp), ),
                ),

                 Obx(()  => controller.stateSearch.value==true?
                    Scrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        thickness: 10,
                         controller: scollBarController,
                          child: ListView.separated(
                           separatorBuilder: (context, index) => Divider( color: Color.fromARGB(255, 255, 255, 255) ),
                            scrollDirection: Axis.vertical,
                            controller: scollBarController,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(1),
                            // itemCount: 10,
                            itemCount: controller.listeTicketByUsers.length,
                            itemBuilder: (context, int index) =>
                            Card(
                                color: Color.fromARGB(255, 255, 255, 255),
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0) ),
                                elevation: 4,
                                child: Column(
                                  children: [
                                    controller.listeTicketByUsers[index].statut == '1'?
                                    Icon(Icons.check, size: 80.0,color: Colors.green,)
                                    :Icon(Icons.clear_sharp, size: 80.0,color: Colors.red,),
                                          
                                    ListTile(
                                      title:Text('${controller.listeTicketByUsers[index].transporteur}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700), ),
                                      trailing:Text('${controller.listeTicketByUsers[index].tarif} FCFA',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                                      subtitle:Text("${controller.listeTicketByUsers[index]!.villeDepart} => ${controller.listeTicketByUsers[index]!.villeArriver}",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    ),

                                    Container(child: const Column( children: [Divider(height: 10,thickness: 5,indent: 0,endIndent: 0,color: Color.fromARGB(255, 100, 100, 100), ),] )),

                                    ListTile(
                                      title:Text('Voyage : ${controller.listeTicketByUsers[index].typeVoyage}', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700), ),
                                      trailing:Text('Code: ${controller.listeTicketByUsers[index].code}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                      subtitle:Text("voyageur: ${controller.listeTicketByUsers[index]!.nbreticket} personne(s)",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    ),

                                    GestureDetector(
                                          onTap: () { Get.to( ModelTickesViews(

                                            data:DataModelTickes(
                                              // controller.listeTicketByUsers[index].id,
                                               pays,
                                              controller.listeTicketByUsers[index].typeVoyage,
                                              controller.listeTicketByUsers[index].villeArriver,
                                              controller.listeTicketByUsers[index].villeDepart,
                                              controller.listeTicketByUsers[index].transporteur,
                                              controller.listeTicketByUsers[index].gare,
                                              controller.listeTicketByUsers[index].heure,
                                              controller.listeTicketByUsers[index].dateAller,
                                              controller.listeTicketByUsers[index].dateRetour,
                                              controller.listeTicketByUsers[index].tarif,
                                              controller.listeTicketByUsers[index].referenceTicket,
                                              controller.listeTicketByUsers[index].code,
                                              controller.listeTicketByUsers[index].transactionId,
                                              controller.listeTicketByUsers[index].nbreticket,
                                              controller.listeTicketByUsers[index].username,
                                              controller.listeTicketByUsers[index].userId,
                                              controller.listeTicketByUsers[index].statut,
                                            )
                                            ));
                                          },

                                          child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(vertical: 10.h),
                                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                                          decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(0),color: CustomColor.primary
                                          ),
                                        child: const Text("Detail",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontFamily: "poppins", ),),
                                        ),
                                      ),
                                    Padding( padding: const EdgeInsets.all(5.0),)
                                  ],
                                ),
                              ),

                          ),
                          
                    ) :
                    Container(
                    padding: EdgeInsets.all(10.sp),
                     )
                  
                  ),

                Obx(()  => controller.etapes.value==true?
                    const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon( Icons.error_outline_outlined,color: Color(0xffc40619),size: 100,),
                              Text('Aucune historique disponible a ce jour...', style: TextStyle(fontSize: 16,color: const Color(0xffc40619)) ),
                            ],
                          ),
                        ): Container(  padding: EdgeInsets.all(10.sp),
                    
                  )),

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
