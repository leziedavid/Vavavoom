import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoum/app/constant/Color.dart';
import 'package:vavavoum/app/modules/ticket/views/ModelTickesViews.dart';

import '../controllers/ticket_controller.dart';

class MyHistorique extends GetView<TicketController> {
  const MyHistorique({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
  final  phone = TextEditingController();

 TicketController controller = Get.put(TicketController());

  ScrollController scollBarController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

    void submit() async{
         controller.getTicketByPhone(phone.text);   
          }

  return Scaffold(

      appBar: AppBar(
          title:  Text('TROUVER MON TICKET',style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton(
              onPressed: (){
                 Navigator.pop(context);
                 controller.cleanData();
               },
              icon: Icon(Icons.arrow_back_sharp,
              color: Colors.white,),
            ),
      ),

      body: Container(
        // color: Color.fromARGB(255, 255, 254, 254),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            
                 const ListTile(
                    leading: CircleAvatar(child: Icon(CupertinoIcons.phone)),
                    title: Text('Saisir le numéro de téléphone utilisé lors du paiement', style: TextStyle(fontSize: 16,)),
                  ),
                const  Divider(height: 5),
                SizedBox( height: 10.h,),

                TextFormField( 
                  maxLength: 10,
                  onChanged: (value) { controller.telLength.value = value.length.toString(); },
                  controller: phone, keyboardType: TextInputType.number, strutStyle: const StrutStyle(),
                  decoration: const InputDecoration( 
                    labelText: "Numéro utilisé lors du paiement", 
                    labelStyle: TextStyle(fontFamily: "poppins"),
                    border: OutlineInputBorder(), 
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    ),
                ),

                SizedBox(
                  height: 5.h,
                ),

              Obx(()  => controller.states.value==false && controller.telLength.value.length <=4 ||controller.states.value==false ?  GestureDetector(
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

              SizedBox( height: 8.h,),

              Container(
                alignment: Alignment.center,
                child: Text("Besoin d'aide ?", style: TextStyle(fontSize: 17,decoration: TextDecoration.underline)),
                ),
                SizedBox( height: 8.h,),

    
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
                            itemCount: controller.listeTicketByPhone.length,
                            itemBuilder: (context, int index) =>
                            Card(
                                color: Color.fromARGB(255, 255, 255, 255),
                                shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(0) ),
                                elevation: 4,
                                child: Column(
                                  children: [
                                    controller.listeTicketByPhone[index].statut == '0'?
                                    Icon(Icons.check, size: 80.0,color: Colors.green,)
                                    :Icon(Icons.clear_sharp, size: 80.0,color: Colors.red,),
                                          
                                    ListTile(
                                      title:Text('${controller.listeTicketByPhone[index].transporteur}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700), ),
                                      trailing:Text('${controller.listeTicketByPhone[index].tarif} FCFA',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                                      subtitle:Text("${controller.listeTicketByPhone[index]!.villeDepart} => ${controller.listeTicketByPhone[index]!.villeArriver}",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    ),
                                    Container(
                                          child:Column(
                                             children: [ 
                                                const Divider(height: 10,thickness: 5,indent: 0,endIndent: 0,color: Color.fromARGB(255, 100, 100, 100), ),
                                             ]
                                          )
                                      ),

                                  ListTile(
                                      title:Text('Voyage : ${controller.listeTicketByPhone[index].typeVoyage}', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700), ),
                                      trailing:Text('Code: ${controller.listeTicketByPhone[index].code}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                      subtitle:Text("voyageur: ${controller.listeTicketByPhone[index]!.nbreticket} personne(s)",
                                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    ),

                                    GestureDetector(
                                          onTap: () { Get.to( ModelTickesViews(

                                            data:DataModelTickes(
                                              // controller.listeTicketByPhone[index].id,
                                              controller.listeTicketByPhone[index].typeVoyage,
                                              controller.listeTicketByPhone[index].villeArriver,
                                              controller.listeTicketByPhone[index].villeDepart,
                                              controller.listeTicketByPhone[index].transporteur,
                                              controller.listeTicketByPhone[index].gare,
                                              controller.listeTicketByPhone[index].heure,
                                              controller.listeTicketByPhone[index].dateAller,
                                              controller.listeTicketByPhone[index].dateRetour,
                                              controller.listeTicketByPhone[index].tarif,
                                              controller.listeTicketByPhone[index].referenceTicket,
                                              controller.listeTicketByPhone[index].code,
                                              controller.listeTicketByPhone[index].transactionId,
                                              controller.listeTicketByPhone[index].nbreticket,
                                              controller.listeTicketByPhone[index].username,
                                              controller.listeTicketByPhone[index].userId,
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
                          
                    ):Container(padding: EdgeInsets.all(10.sp), )
                  
                  ),

                Obx( () => controller.etapes.value==true ?Icon(Icons.info, size: 80.0,color: Color.fromARGB(255, 255, 0, 0),):Container(padding: EdgeInsets.all(10.sp)),),

                Obx(()  => controller.etapes.value==true?
                    Container(
                          padding: EdgeInsets.all(10.sp),
                          alignment: Alignment.center,
                          width: 250.w,
                          child: Text("Aucun achat n'est associé à ce numéro.",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: const Color.fromARGB(255, 179, 0, 0),
                          )),
                      ) : Container(  padding: EdgeInsets.all(10.sp),
                    
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
