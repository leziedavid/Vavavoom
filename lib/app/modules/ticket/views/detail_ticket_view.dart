import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/paiement/views/paiement_view.dart';
import 'package:vavavoom/app/modules/ticket/controllers/ticket_controller.dart';
import 'package:vavavoom/app/modules/ticket/views/ticket_view.dart';

class SelectTickeDataModel {
  int id;
  String ville_depart;
  String ville_arriver;
  String transporteur;
  String gare;
  String date_depart;
  String date_retour;
  int tarif;
  String prixRetour;
  String heurs;
  int typeVoyage;
  String images;
  int destinationInter;

  SelectTickeDataModel(
  this.id,
  this.ville_depart,
  this.ville_arriver,
  this.transporteur,
  this.gare,
  this.date_depart,
  this.date_retour,
  this.tarif,
  this.prixRetour,
  this.heurs,
  this.typeVoyage,
  this.images,
  this.destinationInter,
  );
  
}

class DetailTicketView extends GetView {

final SelectTickeDataModel? data;

  const DetailTicketView({ Key? key,this.data, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TicketController controller = Get.put(TicketController());

    return Scaffold(
        appBar: AppBar(
          title:  Text(data!.gare,style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton(
            onPressed: (){ Navigator.pop(context); }, icon: Icon(Icons.arrow_back_sharp, color: Colors.white,),
            ),
      ),

      bottomSheet: GestureDetector(
        onTap: () {
           Get.to( PaiementView(data:PaiementDataModel(
          data!.ville_depart,
              data!.ville_arriver,
              data!.transporteur,
              data!.gare,
              data!.date_depart,
              data!.date_retour,
              controller.montantTTC.value,
              data!.heurs,
              controller.dropdownValue.value,
              data!.typeVoyage,
              data!.images,
              controller.remise.value
              
            )));
        },
        child: Container(
          alignment: Alignment.center,
          height: 50.h,
          decoration: BoxDecoration(color: CustomColor.primary),
          child: const Text( "EFFECTUER LE PAIEMENT", style: TextStyle(fontSize: 18, color: Colors.white),

          ),
        ),
      ),
      body:Container(
        color: Color.fromARGB(255, 236, 231, 231),
        
        child: ListView(
          padding: EdgeInsets.only(top: 15.sp, left: 15.sp, right: 15.sp),

          children: [
          
            Hero(
              tag: "ticket",
              child: GestureDetector(
                onTap: () { Get.to(const DetailTicketView()); },
                child: ClipPath(
                  clipper: const ClipPathModule1(heigth: 2),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      height: 200.h,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar( backgroundColor: CustomColor.primary, radius: 25, backgroundImage: NetworkImage('https://vavavoom.ci/mobile-ads/${data!.images}')),
                              Text(data!.transporteur, style: TextStyle(fontFamily: "poppins",  fontSize: 22.sp, color: CustomColor.primary,fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),

                          Column(children: [DottedDashedLine(height: 0,dashColor: Colors.grey, width: MediaQuery.of(context).size.width - 105.w,axis: Axis.horizontal),], ),
                          SizedBox(height: 10.h, ),
                          Column(
                            children: [
                               data!.typeVoyage==0 ? Text("${data!.ville_depart} -> ${data!.ville_arriver}" ,textAlign:TextAlign.center,style: TextStyle(fontFamily: "poppins",fontSize: 12.sp, color: Color.fromARGB(255, 0, 0, 0)))
                               :Text("${data!.ville_depart} -> ${data!.ville_arriver} -> ${data!.ville_depart}" ,textAlign:TextAlign.center,style: TextStyle(fontFamily: "poppins",fontSize: 12.sp, color: Color.fromARGB(255, 0, 0, 0))),
                              ],),
                          SizedBox(height: 10.h, ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [ 
                                  const Text("Heure",style: TextStyle(fontFamily: "popins",color: Colors.grey), ),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time_sharp,color: CustomColor.primary,
                                      ),
                                      SizedBox( width: 5.w,),
                                      Text(data!.heurs, style: TextStyle( fontSize: 15.sp, fontFamily: 'poppins', color: CustomColor.primary, fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [ const Text("Destination", style: TextStyle(fontFamily: "popins", color: Colors.grey),),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, color: CustomColor.primary,),
                                      Text(data!.ville_arriver,style: TextStyle( fontSize: 15.sp, fontFamily: 'poppins', color: CustomColor.primary,fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              )
                              
                            ],
                          ),
                          // SizedBox(height: 10.h, ),
                          // Column(
                          //   children: [
                          //      data!.typeVoyage==0 ?
                          //      Text("Date : ${data!.date_depart}" ,textAlign:TextAlign.center, style: TextStyle(fontFamily: "poppins",  fontSize: 13.sp, color: CustomColor.primary,fontWeight: FontWeight.w700) )
                          //      :Text("Date : ${data!.date_depart} <-> ${data!.date_retour}" ,textAlign:TextAlign.center, style: TextStyle(fontFamily: "poppins",  fontSize: 13.sp, color: CustomColor.primary,fontWeight: FontWeight.w700 ) ),
                          //     ],),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h,)
            ,
            Container(
              padding: EdgeInsets.all(5.sp),
              decoration: BoxDecoration(  color: CustomColor.primary, borderRadius: BorderRadius.circular(7),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( "Choisir le nombre de voyageur",textAlign: TextAlign.center,style: TextStyle(  fontFamily: "poppins", color: Colors.white,  fontWeight: FontWeight.w700, fontSize: 16.sp), ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Row(
                    children: [
                      Obx(
                        () {
                        return Container(
                          width: 320,
                          height: 35,
                          decoration: BoxDecoration(color: Color(0xffEBEDFE), borderRadius:BorderRadius.circular(10)),
                          child: Center(child: DropdownButton(
                          items: controller.item.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                              onChanged: (String? value) {
                              controller.dropdownValue.value = value!;
                              // controller.getPrice(controller.dropdownValue.value,data!.tarif,data!.typeVoyage);

                              //Si le type est aller retour
                              data!.typeVoyage==1?
                              // si nous avons eu un retour et le pris reetour est null
                                data!.prixRetour=="null"?
                                controller.getPrice(controller.dropdownValue.value,data!.tarif*2,data!.typeVoyage,data!.destinationInter):
                                 //Sinon
                                controller.getPrice(controller.dropdownValue.value,int.parse(data!.prixRetour),data!.typeVoyage,data!.destinationInter)
                                
                              :controller.getPrice(controller.dropdownValue.value,data!.tarif,data!.typeVoyage,data!.destinationInter);

                             },
                            value:controller.dropdownValue.value,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 30,
                            style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 0, 0, 0),),
                            ),
                            ),
                                );
                          },),

                    ],
                  )
                ],
              ),
            )
            ,
            SizedBox( height: 10.h,),

             Obx(
              () { 
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(  "Tarif", style: TextStyle( fontFamily: "poppins",color: Colors.black, fontWeight: FontWeight.w700,  fontSize: 17.sp),),
                      Text("${controller.sommeIntial.value} Fcfa", style: TextStyle( fontFamily: "poppins", color: Colors.black, fontWeight: FontWeight.w700, fontSize: 17.sp),
                      )
                    ],
                  );
              },),

             Obx(
               () { 
                    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TVA 18%", style: TextStyle( fontFamily: "poppins",  color: Colors.black, fontWeight: FontWeight.w700, fontSize: 17.sp),),
                          Text("${controller.tvaApplique.value} Fcfa", style: TextStyle( fontFamily: "poppins", color: Colors.black, fontWeight: FontWeight.w700,fontSize: 17.sp),)
                        ],
                      );
              },),
            const Divider(height: 1, color: Colors.grey,),
              Obx(
                  () {
                    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Frais", style: TextStyle( fontFamily: "poppins",  color: Colors.black, fontWeight: FontWeight.w700, fontSize: 17.sp),),
                          Text("${controller.fraisTrans.value} Fcfa", style: TextStyle( fontFamily: "poppins", color: Colors.black, fontWeight: FontWeight.w700,fontSize: 17.sp),)
                        ],
                      );
                },),
   
            const Divider(height: 1, color: Colors.grey,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( "Total", style: TextStyle(fontFamily: "poppins", color: Colors.black,  fontWeight: FontWeight.w900, fontSize: 19.sp),),
                Obx(() { return Text( "${controller.montantTTC.value}  fcfa",style: TextStyle( fontFamily: "poppins",color: Colors.black, fontWeight: FontWeight.w900,fontSize: 19.sp),); },),
                ],
              ),
            
              const Divider(height: 1),
              SizedBox( height: 10.h,),

              Card(
                child: ListTile(
                  leading: const CircleAvatar( backgroundColor: const Color.fromARGB(255, 255, 0, 0), child:  Text( "i", style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20), ), ),

                      title:  data!.typeVoyage==0 ? Text('TICKET : ALLER SIMPLE',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500, ))
                      :Text('TICKET :  ALLER RETOUR',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500, )),
                      subtitle: data!.typeVoyage==0 ?Text('${data!.date_depart}',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500, )):
                      Text('${data!.date_depart} <-> ${data!.date_retour}',style: TextStyle(fontSize: 15,color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500, )),
                ),
              ),

              // data!.typeVoyage==0 ?
              // ListTile(leading: CircleAvatar(child: Icon(Icons.directions_bus,color:CustomColor.primary,)),title:  Text('TICKET : ALLER SIMPLE', style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.w900)),):
              // ListTile(leading: CircleAvatar(child: Icon(Icons.directions_bus,color:CustomColor.primary,)),title:  Text('TICKET :  ALLER RETOUR', style: TextStyle(fontSize: 18,color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.w900)),),
              //   const  Divider(height: 1),
              // data!.typeVoyage==0 ?
              // ListTile(leading: CircleAvatar(child: Icon(Icons.calendar_month_sharp,color:CustomColor.primary,)),title: Text('${data!.date_depart}', style: TextStyle(fontSize: 18,color: CustomColor.primary,fontWeight: FontWeight.w300)),):
              // ListTile(leading: CircleAvatar(child: Icon(Icons.calendar_month_sharp,color:CustomColor.primary,)),title: Text('${data!.date_depart} <-> ${data!.date_retour}', style: TextStyle(fontSize: 18,color: CustomColor.primary,fontWeight: FontWeight.w500)),),
             
        
          ],
        ),
      ),

    );
  }
}
