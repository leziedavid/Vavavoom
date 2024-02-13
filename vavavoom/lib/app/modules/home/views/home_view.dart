import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:percent_indicator/percent_indicator.dart';
import 'package:vavavoum/app/constant/Color.dart';
import 'package:vavavoum/app/modules/ticket/views/ticket_view.dart';
import 'package:vavavoum/app/widgets/Dialogs/dateDialog.dart';
import 'package:vavavoum/app/widgets/Dialogs/dialog.dart';
import 'package:vavavoum/app/widgets/Drawer.dart';
import 'package:vavavoum/app/widgets/Inputs/InputCustom.dart';
import 'package:vavavoum/app/widgets/Inputs/InputDate.dart';

import '../controllers/home_controller.dart';

enum Sky { midnight, viridian, cerulean }

Map<Sky, Color> skyColors = <Sky, Color>{
  Sky.midnight: const Color(0xff191970),
  Sky.viridian: const Color(0xff40826d),
  Sky.cerulean: const Color(0xff007ba7),
};

class HomeView extends GetView<HomeController> {

  const HomeView({Key? key}) : super(key: key);
  @override


  Widget build(BuildContext context) {

    Get.put(HomeController());
    controller.onInit();
    return Scaffold(

      bottomSheet: GestureDetector(
        onTap: () async {

            if(controller.villeDepart.value.text == "") {
                  return Flushbar(
                    titleText: Text("Veuillez sélectionner une ville de départ",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                    message: " ",
                    duration: Duration(seconds: 2),
                    backgroundColor: Color.fromARGB(255, 163, 26, 26),
                  ).show(context);

                }else if(controller.villeArrive.value.text == "")
                  {
                    return Flushbar(
                        titleText: Text("Veuillez sélectionner une ville d'arrivée",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                        message: " ",
                        duration: Duration(seconds: 2),
                        backgroundColor: Color.fromARGB(255, 163, 26, 26),
                        ).show(context);

                  }else if(controller.dateDepart.value.text == "")
                    {
                      return Flushbar(
                          titleText: Text("Veuillez sélectionner une date départ",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                          message: " ",
                          duration: Duration(seconds: 2),
                          backgroundColor: Color.fromARGB(255, 163, 26, 26),
                      ).show(context);

                    }else if(controller.optionSelect.value!=0 && controller.dateRetours.value.text == "")
                      {
                          return Flushbar(
                              titleText: Text("Veuillez sélectionner une date de retour",textAlign: TextAlign.center,style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                              message: " ",
                              duration: Duration(seconds: 3),
                              backgroundColor: Color.fromARGB(255, 163, 26, 26),
                          ).show(context);

                      } 
                        
                        // else if(controller.transporteur.value.text == "")
                        //   {
                        //     return Flushbar(
                        //         titleText: Text("Veuillez sélectionner 1 ou 3 transporteurs",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),),
                        //         message: " ",
                        //         duration: Duration(seconds: 2),
                        //         backgroundColor: Color.fromARGB(255, 163, 26, 26),
                        //         ).show(context);

                        // }
                        else{
                        // controller.dispose();
                          const Center( child: CircularProgressIndicator(), );
                          controller.getTickets(controller.villeDepart.value.text,controller.villeArrive.value.text,controller.transporteur.value.text);
                    
                          _dialogBuilder(context);

                          // Get.to(() => TicketView(
                          //       data: TickeDataModel(
                          //       controller.villeDepart.value.text,
                          //       controller.villeArrive.value.text,
                          //       controller.transporteur.value.text,
                          //       controller.groupValue.value,
                          //       controller.dateDepart.value.text,
                          //       controller.dateRetours.value.text,
                          //     )));
                                      
                          //  if(controller.nb.value>0){

                          //         Get.to(() => TicketView(data:TickeDataModel(
                          //             controller.villeDepart.value.text,
                          //             controller.villeArrive.value.text,
                          //             controller.transporteur.value.text,
                          //             controller.groupValue.value,
                          //             controller.dateDepart.value.text,
                          //             controller.dateRetours.value.text,
                          //             )));

                          //       }else{
                                  
                          //         Get.to(() => SearchResult(data:SearchDataModel(
                          //             controller.villeDepart.value.text,
                          //             controller.villeArrive.value.text,
                          //             controller.transporteur.value.text,
                          //             controller.groupValue.value,
                          //             controller.dateDepart.value.text,
                          //             controller.dateRetours.value.text,
                          //             )));
                          //         // openDialogSearchTicker(controller.villeDepart.value.text,controller.villeArrive.value.text,controller.transporteur.value.text);

                          //       }
                            
                            }
    
          },child: Container(
            alignment: Alignment.center,
            height: 50.h,
            decoration: BoxDecoration(color: CustomColor.primary),
            child: const Text( "RECHERCHER", style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
      ),

      appBar: AppBar(
        elevation: 0,
        leading: Builder(
            builder: (context) => IconButton(icon: const Icon(Icons.menu),
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: () => Scaffold.of(context).openDrawer(), 
            ),
          ),

        // title: Image.asset(controller.posts[0]['banner_path'], height: 150.h,  ),
        title: Image.asset("assets/images/logovavavoom-01.jpg", height: 150.h,),
        centerTitle: true, backgroundColor: CustomColor.primary,
      ),

      drawer: const DrawerCustom(),

      body: ListView(
        
        padding: EdgeInsets.only(bottom: 50.h),
        children: [
          Container(
            
            height: 230.h,
            constraints: const BoxConstraints(maxWidth: double.infinity, maxHeight: double.infinity),

            child: Stack(

              children: [

                //  ListView.builder(
                //     itemCount: controller.posts.length,
                //     itemBuilder: (context, index) {
                //        Text(controller.posts[index].bannerPath).toString();
                //        BoxDecoration(color: CustomColor.primary, image: DecorationImage( image: NetworkImage(controller.posts[index].bannerPath!,),  fit: BoxFit.cover, ));
                //      }
                //     ),

                Image.asset("assets/images/banniereapp-phone-screen-01.jpg",width: double.infinity, fit: BoxFit.cover, ),
                Positioned( bottom: 0.sp,  left: 0.sp,  right: 0.sp,
                  child: Obx(
                    () {
                      return Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 25.w),
                        child: CupertinoSlidingSegmentedControl<int>(
                          backgroundColor: CustomColor.primary,
                          thumbColor: CupertinoColors.white,
                          groupValue: controller.groupValue.value,
                          children: {
                            0: Container(
                              height: 45.h,
                              width: 150.w,
                              decoration: BoxDecoration( borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              
                              child: Text("Aller-Simple", style: TextStyle(fontFamily: "poppins",fontWeight: FontWeight.w700, color: controller.groupValue.value == 0 ? Colors.black: Colors.white),
                             
                              ),
                               
                            ),
                            1: Container(
                              height: 45.h,
                              width: 150.w,
                              decoration: BoxDecoration( borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              child: Text( "Aller-Retour", style: TextStyle(  fontFamily: "poppins", fontWeight: FontWeight.w700,color: controller.groupValue.value == 1 ? Colors.black: Colors.white),
                              ),
                            ),
                            
                          },
                          onValueChanged: (value) {
                            controller.isFirstOnglet.value = !controller.isFirstOnglet.value; 
                            controller.groupValue.value = value!;
                            controller.changeMyValue(value);
                            log(value.toString());
                            log(controller.groupValue.value.toString());
                          },

                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),

          
          SizedBox( height: 5.h,),
          InputCustom( icon: Icons.map, controller: controller.villeDepart.value, text: "Ville de départ", onTap: () => openDialog(controller.villeDepart.value,controller.listVille,controller.villeArrive.value.text,"Ville de départ"),),
          SizedBox(height: 5.h, ),

          Container( margin: const EdgeInsets.only(left: 20),alignment: Alignment.centerLeft, child: Icon( Icons.arrow_downward,color: CustomColor.primary, ),),
          SizedBox(height: 5.h, ),

          InputCustom(icon: Icons.location_on, controller: controller.villeArrive.value, text: "Ville d'arrivée", onTap: () => openDialog( controller.villeArrive.value, controller.listVille, controller.villeDepart.value.text,"Ville d'arrivée"),),

          SizedBox( height: 5.h, ),
         Container(margin: const EdgeInsets.only(left: 20), alignment: Alignment.centerLeft, child: Icon( Icons.arrow_downward,color: CustomColor.primary, ),),
          SizedBox( height: 5.h,  ),

          InputCustomDate( icon: Icons.date_range, controller: controller.dateDepart.value, text: "Date de depart", callback: () => selectDate(controller, context),),
          SizedBox( height: 5.h, ),

          Obx( () => controller.loader.value ? InputCustomDate( icon: Icons.date_range, controller: controller.dateRetours.value,  text: "Date de retour", callback: () => selectDate2(controller, context),) : SizedBox(  height: 0.h, ),),

        Container( margin: const EdgeInsets.only(left: 20),alignment: Alignment.centerLeft, child: Icon( Icons.arrow_downward,color: CustomColor.primary, ),),
          SizedBox(height: 5.h, ),

          InputCustom( icon: Icons.car_repair_outlined,controller: controller.transporteur.value,text: "Tansporteur (optionnel)",
            // maxLines: 2,
            onTap: () => openDialogTransporteur(controller.transporteur.value,controller.listTransporteur, "", "Transporteur"),
          ),
           SizedBox( height: 10.h,),
          

        ],
      ),
      );

  }

    Future<void> _dialogBuilder(BuildContext context) {

        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return Obx( () => controller.temps.value>0
                ? AlertDialog( 
                   content: Container(
                      height: 120.h,
                        child: Column(
                            children: [
                              Text("Chargement...",textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 20.sp,fontWeight: FontWeight.w700)),
                              SizedBox( height: 30.h,),
                              Center( child: CircularProgressIndicator(),)
                            ],
                          ),
                      ),

                  )  
                : Obx(() 
                  { 
                    return AlertDialog (
                    icon:Obx( () => controller.isDonnees.value==true
                    ?Icon(Icons.check, size: 50.0,color: Colors.green,):
                    Icon(Icons.info, size: 50.0,color: Color.fromARGB(255, 255, 0, 0),)
                    ),
                    title: Text("${controller.villeDepart.value.text} => ${controller.villeArrive.value.text}",textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 17.sp,fontWeight: FontWeight.w700)),
        
                    content:Obx( () => controller.isDonnees.value==true
                    ?Text("Nous avons trouvée  ${controller.nb.value} Tickets",textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 17.sp,)):
                     Text('Aucun itinéraire ne correspond à vos choix. Veuillez choisir une autre destination.',textAlign: TextAlign.center, style: TextStyle(fontFamily: "poppins",fontSize: 13.sp,color: Color.fromARGB(255, 255, 0, 0),fontWeight: FontWeight.w700))),

                      actions: <Widget>[

                        TextButton(
                          style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge,),
                          child: const Text("Retour",textAlign: TextAlign.center, style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontFamily: "poppins", fontWeight: FontWeight.w700),),
                          onPressed: () { Navigator.of(context).pop(); },
                        ),

                        Obx( () => controller.isDonnees.value==true
                    ? TextButton(
                      style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge,),
                        child: const Text("Voir les résultats",style: TextStyle(color: Color(0xff234A99), fontFamily: "poppins", fontWeight: FontWeight.w700),),
                          onPressed: () {
                            Get.to(() => TicketView(
                                  data: TickeDataModel(
                                  controller.villeDepart.value.text,
                                  controller.villeArrive.value.text,
                                  controller.transporteur.value.text,
                                  controller.groupValue.value,
                                  controller.dateDepart.value.text,
                                  controller.dateRetours.value.text,
                              )));
                          },
                        ): const Text("")
                        ),

                      ],

                    );

                   }),

          );

 
          },
        );
      }


}
