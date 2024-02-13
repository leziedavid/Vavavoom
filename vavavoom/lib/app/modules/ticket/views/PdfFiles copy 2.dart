import 'dart:async';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vavavoum/app/constant/Color.dart';
import 'package:image/image.dart' as img;

class PdfFiles extends StatefulWidget {

  final int id;
  final String typeVoyage;
  final String villeArriver;
  final String villeDepart;
  final String transporteur;
  final String gare;
  final String heure;
  final String dateAller;
  final String dateRetour;
  final String tarif;
  final String referenceTicket;
  final String code;
  final String transactionId;
  final String nbreticket;
  final String username;
  final String userId;
                              
   const PdfFiles({
    Key? key,
      required this.id,
      required this.typeVoyage,
      required this.villeArriver,
      required this.villeDepart,
      required this.transporteur,
      required this.gare,
      required this.heure,
      required this.dateAller,
      required this.dateRetour,
      required this.tarif,
      required this.referenceTicket,
      required this.code,
      required this.transactionId,
      required this.nbreticket,
      required this.username,
      required this.userId,

  }) : super(key: key);

  @override
  PdfFilesState createState() => new PdfFilesState();
}

  // @override
class PdfFilesState extends State<PdfFiles> {
  
  int totalSecs = 15;
  int secsRemaining = 15;
  double progressFraction = 0.0;
  int percentage = 0;
  var etapes = false;
  Timer? timer;

    @override
      void initState() {
      etapes = false;
      super.initState();
    }

  void dispose(){
    timer!.cancel();
    super.dispose();
  }

  void startTimer(){
    etapes=true;
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if(secsRemaining == 0){
        return;
      }
    setState(() {
        secsRemaining -= 1;
        progressFraction = (totalSecs - secsRemaining) / totalSecs;
        percentage = (progressFraction*100).floor();
        
          });
      });
  }
    
  Future<void> makePdf() async{
    startTimer();
    final pdf = p.Document();

  pdf.addPage(
    p.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {

        return p.Center(
          child: p.Container(
            width: 400,
            height: 300,
            padding: p.EdgeInsets.all(10),
            decoration: p.BoxDecoration(
              border: p.Border.all(width: 2),
            ),
            child: p.Column(
              crossAxisAlignment: p.CrossAxisAlignment.start,
              children: [
                // Titre du ticket
                p.Text('Ticket de Bus', style: p.TextStyle(fontSize: 20, fontWeight: p.FontWeight.bold)),
                
                // Informations sur le ticket
                p.SizedBox(height: 10),
                p.Text('Nom du passager: John Doe'),
                p.Text('Numéro de siège: 23A'),
                p.Text('Date et heure du départ: 2024-01-22 15:30'),

                // QR Code (exemple, vous pouvez utiliser un package dédié pour générer des QR codes)
                p.SizedBox(height: 20),
                // p.QrImageViews(url:""),
                p.Text('QR Code: [Insérez votre QR Code ici]'),

                // Plus d'informations sur le ticket
                p.SizedBox(height: 20),
                p.Text('Informations supplémentaires:'),
                p.Text('Trajet: Ville A - Ville B'),
                p.Text('Prix: \$20'),

                // Remerciements
                p.SizedBox(height: 20),
                p.Text('Merci de voyager avec nous!'),
              ],
            ),
          ),
        );
      },
    ),
  );

    List<String> paths;
    paths = await ExternalPath.getExternalStorageDirectories();
    print(paths);

    String pathlink;
    pathlink = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    print(pathlink);

    Directory root = await getApplicationDocumentsDirectory();
    String path = '${pathlink}/test.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
    print("Path  "+path);
    

  }

  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar( 
            leading: Builder( builder: (context) => IconButton(icon: const Icon(Icons.arrow_back_outlined), 
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: (){  Navigator.pop(context);  },
            ),
          ),backgroundColor: CustomColor.primary,
        ),

      body: 
      Container(
        
        color: const Color.fromARGB(255, 225, 225, 225),
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            //  SizedBox( height: 100.h,),
               etapes==true? Column(
                children: [
                  SizedBox(height: 20),
                  Text('$secsRemaining secondes restantes avant la fin du téléchargement',textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  CircularProgressIndicator(
                    value: progressFraction,
                  ),
                  SizedBox(height: 20),
                  Text('$percentage% complete'),
                ],
              ):Container(padding: EdgeInsets.all(10.sp), ),
              
            SizedBox( height: 15.h,),
             etapes==false? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox( height: 80.h,),
                  Container(  padding: EdgeInsets.all(20.sp), ),
                  const Icon(Icons.backup_outlined, size: 80.0,color: Color.fromARGB(255, 238, 103, 14),),
                  SizedBox( height: 20.h,),
                  GestureDetector(
                      onTap: () { makePdf();},
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(0),color: const Color.fromARGB(255, 173, 1, 1)),
                        child:  Text("Télechager votre Ticket ...${widget.code}",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),),
                     ),
                    ),
                ],
                 ):GestureDetector(
                      onTap: () {  Navigator.pop(context); },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(0),color: CustomColor.primary),
                        child: const Text("Retour",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),),
                     ),
                ),

          ],
        ),
      ),
    );


   }
  
}