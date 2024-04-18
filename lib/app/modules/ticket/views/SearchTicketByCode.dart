import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:vavavoom/app/modules/ticket/views/ModelTickesViews.dart';

import '../controllers/ticket_controller.dart';


class TickeDataModel {
  String ville_depart;
  String ville_arriver;
  String transporteur;

  TickeDataModel(this.ville_depart,this.ville_arriver,this.transporteur);
}

class SearchTicketByCode  extends GetView<TicketController> {
  

  final TickeDataModel? data;


  const SearchTicketByCode({
    Key? key,
    this.data,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {

 TicketController controller = Get.put(TicketController());
 ScrollController scollBarController = ScrollController();
 DashboardController dashboardController = Get.put(DashboardController());

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

    final  codes = TextEditingController();
    final  pays = 0;
    Get.put(TicketController());
  controller.onInit();
  
    void submit() async{controller.getTicketbyCode(codes.text); }

    return Scaffold(

        appBar: AppBar(
          
          title:  Text("RECHERCHER UN TICKET",style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
              controller.cleanData();
              dashboardController.changeValue();
              },
            icon: Icon(Icons.arrow_back_sharp,color: Colors.white,),
            ),
        ),


      body: Container(
        // color: const Color.fromARGB(255, 225, 225, 225),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [

            const ListTile(
                leading: CircleAvatar(child: Icon(CupertinoIcons.barcode)),
                title: Text('Entrer le code missionné sur le ticket',style: TextStyle(fontSize:18,fontFamily:"poppins",fontWeight: FontWeight.w600 ) ),
             ),
            const  Divider(height: 0),
            SizedBox(height: 10.h, ),
            TextFormField(
              maxLength: 4,
              onChanged: (value) { controller.telLength.value = value.length.toString(); },
              controller: codes, keyboardType: TextInputType.number, strutStyle: const StrutStyle(),
              decoration: const InputDecoration( labelText: "Code à 4 chiffres", labelStyle: TextStyle(fontFamily: "poppins"),border: OutlineInputBorder(), ),
            ),

            SizedBox( height: 8.h, ),

              Obx(()  => controller.states.value==false && controller.telLength.value.length <=4 ||controller.states.value==false ?
              GestureDetector(
                    onTap:submit,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),color: CustomColor.primary),
                        child: const Text("Lancer la recherche",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),

                      ),
                    ),
                  ):Center(child: CircularProgressIndicator( color: CustomColor.primary,),)
                ),
                
              SizedBox( height: 10.h,),
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
                            itemCount: controller.listeTicketByCode.length,
                            itemBuilder: (context, int index) =>
                            Card(
                                color: Color.fromARGB(255, 255, 255, 255),
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0) ),
                                elevation: 4,
                                child: Column(
                                  children: [
                                    controller.listeTicketByCode[index].statut == '1'?
                                    Icon(Icons.check, size: 80.0,color: Colors.green,)
                                    :Icon(Icons.clear_sharp, size: 80.0,color: Colors.red,),
                                          
                                    ListTile(
                                      title:Text('${controller.listeTicketByCode[index].transporteur}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700), ),
                                      trailing:Text('${controller.listeTicketByCode[index].tarif} FCFA',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                                      subtitle:Text("${controller.listeTicketByCode[index]!.villeDepart} => ${controller.listeTicketByCode[index]!.villeArriver}",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    ),
                                    Container(child:Column(children: [const Divider(height: 10,thickness: 5,indent: 0,endIndent: 0,color: Color.fromARGB(255, 100, 100, 100), ),])),

                                    ListTile(
                                      title:Text('Voyage : ${controller.listeTicketByCode[index].typeVoyage}', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700), ),
                                      trailing:Text('Code: ${controller.listeTicketByCode[index].code}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                      subtitle:Text("voyageur: ${controller.listeTicketByCode[index]!.nbreticket} personne(s)",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    ),

                                    GestureDetector(
                                          onTap: () { Get.to( ModelTickesViews(

                                            data:DataModelTickes(
                                              // controller.listeTicketByCode[index].id,
                                              pays,
                                              controller.listeTicketByCode[index].typeVoyage,
                                              controller.listeTicketByCode[index].villeArriver,
                                              controller.listeTicketByCode[index].villeDepart,
                                              controller.listeTicketByCode[index].transporteur,
                                              controller.listeTicketByCode[index].gare,
                                              controller.listeTicketByCode[index].heure,
                                              controller.listeTicketByCode[index].dateAller,
                                              controller.listeTicketByCode[index].dateRetour,
                                              controller.listeTicketByCode[index].tarif,
                                              controller.listeTicketByCode[index].referenceTicket,
                                              controller.listeTicketByCode[index].code,
                                              controller.listeTicketByCode[index].transactionId,
                                              controller.listeTicketByCode[index].nbreticket,
                                              controller.listeTicketByCode[index].username,
                                              controller.listeTicketByCode[index].userId,
                                              controller.listeTicketByCode[index].statut,
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

                                     const SizedBox( height: 10,),
                                      Obx(() => controller.listeTicketByCode[index].statut == '0'? GestureDetector(

                                         onTap: () { controller.verify(codes.text);},

                                          child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(vertical: 10.h),
                                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(0),color: Colors.green,),
                                          child: const Text("Valider le ticket",style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontFamily: "poppins", ),),),
                                        ): const Text("") ),

                                      Padding( padding: const EdgeInsets.all(5.0),)
                                  ],
                                ),
                              ),

                          ),
                          
                        ):Container(padding: EdgeInsets.all(10.sp), )
                  ),

              Obx( () => controller.etapes.value==true ?Icon(Icons.info, size: 80.0,color: Color(0xffc40619),):Container(padding: EdgeInsets.all(10.sp)),),
                 
              Obx(()  => controller.etapes.value==true?
                Container(
                    padding: EdgeInsets.all(10.sp),alignment: Alignment.center,width: 250.w, 
                    child:Text("Aucun achat n'est associé à ce code.",textAlign: TextAlign.center, style: TextStyle(fontSize: 20,color: Color(0xffc40619),)),
                     ) : Container(padding: EdgeInsets.all(10.sp),
                    
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
