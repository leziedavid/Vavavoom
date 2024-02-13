import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:vavavoum/app/constant/Color.dart';

class PdfFiles extends StatelessWidget {

  const PdfFiles({Key? key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar( 
            leading: Builder( builder: (context) => IconButton(icon: const Icon(Icons.arrow_back_outlined), 
            color: Color.fromARGB(255, 255, 255, 255),
              onPressed: (){ Navigator.pop(context); },
          ),
        ),
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
                        child: const Text("Télechager votre Ticket ...",style: TextStyle(color: Colors.white, fontFamily: "poppins", ),),
                     ),
                    ),
                ],
              )

          ],
        ),
      ),
    );


   }

  Future<void> makePdf() async{

    final pdf = p.Document();

    pdf.addPage(
      p.Page(build: (context){
        return p.Column(
          children: [
            p.Text("AmplifyAbhi"),
            p.Text("AndroidCoding.in"),
            p.Text("Tested")
          ]
        );
      })
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

  
}