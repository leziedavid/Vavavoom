import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/home/views/home_view.dart';

import '../controllers/ticket_controller.dart';

class SearchDataModel {
  String ville_depart;
  String ville_arriver;
  String transporteur;
  int typeVoyage;
  String dateAller;
  String dateRetour;

  SearchDataModel(
    this.ville_depart,
    this.ville_arriver,
    this.transporteur,
    this.typeVoyage,
    this.dateAller,
    this.dateRetour

    );
}

class SearchResult extends GetView<TicketController> {

final SearchDataModel? data;
  
  const SearchResult({
    Key? key,
   this.data
   }) : super(key: key);
  @override
  
  Widget build(BuildContext context) {

    Get.put(TicketController());

    return Scaffold(
      appBar: AppBar( 
        leading: Builder( builder: (context) => IconButton(icon: const Icon(Icons.arrow_back_outlined), 
        color: Color.fromARGB(255, 255, 255, 255),
        onPressed: () => Get.to(const HomeView())
          // Get.to( () => HomeView()),
       ),
    ),

        // onTap: () async { controller.reloader();},
        backgroundColor: CustomColor.primary,
      ),

      body: 
      Container(
        color: const Color.fromARGB(255, 225, 225, 225),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
         
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  Container( height: 250,
                  decoration: BoxDecoration( image: DecorationImage( image: AssetImage("assets/images/404.png"), fit: BoxFit.contain)),),
                  Container(  margin: EdgeInsets.all(15),
                  child: Text("Aucun itinéraire ne correspond à vos choix. Veuillez choisir une autre destination.",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),) ) 
                ],
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
