import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:vavavoom/app/modules/ticket/views/ModelTickesViews.dart';

import '../controllers/ticket_controller.dart';

class MyHistorique extends GetView<TicketController> {
  const MyHistorique({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
  final  phone = TextEditingController();

  TicketController controller = Get.put(TicketController());
  DashboardController dashboardController = Get.put(DashboardController());
  ScrollController scollBarController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final pays = 0;

  void submit() async{controller.getTicketByPhone(phone.text);}

  return Scaffold(
      appBar: AppBar(
          title:  Text('TROUVER MON TICKET',style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton(
              onPressed: (){ Navigator.pop(context); controller.cleanData();dashboardController.changeValue();},
              icon: Icon(Icons.arrow_back_sharp,color: Colors.white,),
            ),
          ),

      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
              const ListTile(leading: CircleAvatar(child: Icon(CupertinoIcons.phone)),title: Text('Saisir le numéro de téléphone utilisé lors du paiement', style: TextStyle(fontSize: 16,)),),
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
              SizedBox(height: 5.h,),
              Obx(()  => controller.states.value==false && controller.telLength.value.length == 10 ||controller.states.value==false ?  GestureDetector(
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

              SizedBox( height: 16.h,),

                 InkWell(
                  onTap: ()=> _dialogBuilder(context),
                  child: Text("Besoin d'aide ?",textAlign: TextAlign.center, style: TextStyle( fontSize: 17, decoration: TextDecoration.underline)),
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
                                    controller.listeTicketByPhone[index].statut == '1'?
                                      const Icon(Icons.check, size: 80.0,color: Colors.green,)
                                    : const Icon(Icons.clear_sharp, size: 80.0,color: Colors.red,),
                                          
                                    ListTile(
                                      title:Text('${controller.listeTicketByPhone[index].transporteur}', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700), ),
                                      trailing:Text('${controller.listeTicketByPhone[index].tarif} FCFA',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
                                      subtitle:Text("${controller.listeTicketByPhone[index]!.villeDepart} => ${controller.listeTicketByPhone[index]!.villeArriver}",
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    ),

                                     Container(
                                      child:const Column(
                                        children:
                                            [
                                              Divider(height: 10,thickness: 5,indent: 0,endIndent: 0,color: Color.fromARGB(255, 100, 100, 100),),
                                            ]
                                        )),

                                  ListTile(
                                      title:Text('Voyage : ${controller.listeTicketByPhone[index].typeVoyage}', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700), ),
                                      trailing:Text('Code: ${controller.listeTicketByPhone[index].code}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                      subtitle:Text("voyageur: ${controller.listeTicketByPhone[index]!.nbreticket} personne(s)",
                                      style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                                    ),

                                    GestureDetector(
                                          onTap: () { Get.to( ModelTickesViews(

                                            data:DataModelTickes(
                                              // controller.listeTicketByPhone[index].id,
                                              pays,
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
                                              controller.listeTicketByPhone[index].statut,
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
                                       const  Padding( padding: EdgeInsets.all(5.0),)
                                  ],
                                ),
                              ),

                          ),
                          
                    ):Container(padding: EdgeInsets.all(10.sp), )
                  
                  ),

                Obx( () => controller.etapes.value==true ?const Icon(Icons.info, size: 80.0,color: Color(0xffc40619),):Container(padding: EdgeInsets.all(10.sp)),),

                Obx(()  => controller.etapes.value==true?
                    Container(
                          padding: EdgeInsets.all(10.sp),
                          alignment: Alignment.center,
                          width: 250.w,
                          child: const Text("Aucun achat n'est associé à ce numéro.",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: const Color(0xffc40619),)),
                      ) : Container(  padding: EdgeInsets.all(10.sp),
                    
                  )),
          ],
        ),
      ),
    );
  }

    Future<void> _dialogBuilder(BuildContext context) {

        return showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              
              return AlertDialog(
                    content: Container(
                      height: 500.h,
                      child:InteractiveViewer(
                        panEnabled: false,
                        boundaryMargin: EdgeInsets.all(100),
                        minScale: 0.8,
                        maxScale: 2,
                        child:Hero(tag:"", child:  Image.asset("assets/images/Groupe2.png",width: double.infinity, fit: BoxFit.cover,),),
                        // Text("Le téléphone d'achat est la\n  zone encadrée en rouge"),
                      ),
                  ),

                  title: const Text("Le téléphone d'achat est la\n  zone encadrée en rouge",textAlign: TextAlign.center, style: TextStyle(fontSize: 15,fontFamily: 'poppins',fontWeight: FontWeight.w700,color:Color(0xffc40619) )),
                  actions: <Widget>[
                        TextButton(
                        style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge, ),
                        child: const ListTile(title:Text('Fermer',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Color(0xffc40619),fontWeight: FontWeight.w900)),),
                        onPressed: () { Navigator.of(context).pop();  },
                      ),
                    ],

                );
                
            },

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
    return true;
  }
}
