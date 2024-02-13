import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoum/app/constant/Color.dart';
import 'package:vavavoum/app/modules/ticket/views/detail_ticket_view.dart';

// import 'package:vavavoum/app/widgets/Cards/QrImageViews.dart';

import '../controllers/ticket_controller.dart';

class TickeDataModel {
  String ville_depart;
  String ville_arriver;
  String transporteur;
  int typeVoyage;
  String dateAller;
  String dateRetour;

  TickeDataModel(
    this.ville_depart,
    this.ville_arriver,
    this.transporteur,
    this.typeVoyage,
    this.dateAller,
    this.dateRetour

    );
}

class TicketView  extends GetView<TicketController> {
  
final TickeDataModel? data;


  const TicketView({
    Key? key,
    this.data,
  }) : super(key: key);


  
  @override
  Widget build(BuildContext context) {
    
    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

     TicketController ticketController = Get.put(TicketController()); 
    
    var allItineraires = controller.getTickets(data!.ville_depart,data!.ville_arriver,data!.transporteur);
    // controller.onInit();
   ScrollController scollBarController = ScrollController();

    return Scaffold(

      appBar: AppBar(
          title:  Text("${data!.ville_depart} => ${data!.ville_arriver}",style: TextStyle(fontFamily: "poppins",
          fontSize: 17.sp, color: Color.fromARGB(255, 255, 255, 255)) ),
          centerTitle: true,
          backgroundColor: CustomColor.primary,
          leading: IconButton(
            onPressed: (){ Navigator.pop(context); },
            icon: Icon(Icons.arrow_back_sharp,
            color: Colors.white,),
            ),
      ),

      body: Container(
        color: const Color.fromARGB(255, 225, 225, 225),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              decoration: BoxDecoration( borderRadius: BorderRadius.circular(5), color: Colors.white),
              height: 40.h,
              alignment: Alignment.center,
              // child: TextField(
              child: TextFormField(
                onChanged: (value) {
                  ticketController.onClose();
                  ticketController.searchTickes(value,controller.listTickes); 
                  ticketController.onInit();
                  },
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Gare ou compagnie",
                    prefixIcon: Icon(Icons.search)),
              ),
            ),
           
            SizedBox( height: 20.h,),
            
            Obx( () => ticketController.load.value && ticketController.listTickes.isNotEmpty
                ? 
                const Center( child: CircularProgressIndicator(), )
              :Obx(() {
                  return Padding(
                      padding: const EdgeInsets.all(10),
    
                     child: Scrollbar(
                        thumbVisibility: true,
                        trackVisibility: true,
                        thickness: 10,
                         controller: scollBarController,
                          child: ListView.separated(
                           separatorBuilder: (context, index) => Divider( color: const Color.fromARGB(255, 255, 255, 255) ),
                            scrollDirection: Axis.vertical,
                            controller: scollBarController,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(1),
                            itemCount: controller.listTickes.length,
                            itemBuilder: (context, int index) => 
                            Hero(
                                tag: index,
                                child: GestureDetector(
                                  onTap: () { Get.to( DetailTicketView(data:SelectTickeDataModel(
                                        controller.listTickes[index].id,
                                        controller.listTickes[index].villeDepart,
                                        controller.listTickes[index].villeArriver,
                                        controller.listTickes[index].compagnieName,
                                        controller.listTickes[index].gare,
                                        data!.dateAller,
                                        data!.dateRetour,
                                        controller.listTickes[index].prix,
                                        controller.listTickes[index].heure,
                                        data!.typeVoyage,
                                       controller.listTickes[index].image_name,
                                        )));
                                        controller.getPrice(controller.dropdownValue.value,controller.listTickes[index].prix);
                                  },
                                   child: ClipPath(
                                    clipper: const ClipPathModule1(heigth: 2),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric( vertical: 30, horizontal: 30),
                                        height: 170.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                              children: [
                                                // Text('Person ${controller.listTickes[index]["ville_depart"]}'),
                                                CircleAvatar( backgroundColor: CustomColor.primary, radius: 25, backgroundImage: NetworkImage('https://vavavoom.ci/mobile-ads/${controller.listTickes[index].image_name}')),
                   
                                                Column(
                                                  children: [
                                                    const Text( "Gare",style: TextStyle(fontFamily: "poppins"), ),
                                                    Text('${controller.listTickes[index].gare}',style: TextStyle(fontFamily: "poppins",fontSize: 13.sp,color: CustomColor.primary), ),
                                                  ], 
                                                ),
                                                Text('${controller.listTickes[index].compagnieName}', style: TextStyle(fontSize: 13.sp,fontFamily: 'poppins',fontWeight: FontWeight.w700),),
                                              ],
                                            ),
                                            Column(
                                              children: [ DottedDashedLine( height: 0, dashColor: Colors.grey,  width: MediaQuery.of(context).size.width -90.w, axis: Axis.horizontal),],
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      
                                                      Icon(Icons.access_time_sharp,color: CustomColor.primary, ),
                                                      SizedBox(width: 5.w, ),
                                                      Text( '${controller.listTickes[index].heure}',style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontFamily: 'poppins',
                                                            color: CustomColor.primary,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                    ],
                                                  ),
                                                  Text( "${controller.listTickes[index].prix} fcfa",
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontFamily: 'poppins',
                                                        color: CustomColor.primary,
                                                        fontWeight: FontWeight.w700),
                                                  ),

                                                ]),
                                                // QrImageViews(url:"Bonjour"),  
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                
                              ),
                          ),
                          
                        ),
                        
                    );
                }),

            ),

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
