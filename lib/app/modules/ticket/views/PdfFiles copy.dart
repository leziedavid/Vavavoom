import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:qr_flutter/qr_flutter.dart';
import 'package:vavavoom/app/constant/Color.dart';
import 'package:vavavoom/app/modules/dashboard/views/dashboard_view.dart';
import 'package:vavavoom/app/modules/home/views/home_view.dart';
// import 'dart:math';

class PdfFiles extends StatefulWidget {

  // final int id;
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
      // required this.id,
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
  
  static String? _fileUrls;
  final Dio _dio = Dio();
  bool isLoding =false;
  String? progress;
  double? _percentage;
  var dir;
  
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  int totalSecs = 15;
  int secsRemaining = 15;
  double progressFraction = 0.0;
  int percentage = 0;
  var etapes = false;
  Timer? timer;
  var token,tokens,role,userId,usernames,userName,status,reference,raison, referenceTicket;

    checkLoginStatus() async {

           final sharedPreferences = await SharedPreferences.getInstance();
          if(sharedPreferences.getString("token") != null ||sharedPreferences.getString("role") != null || sharedPreferences.getInt("id") != null|| sharedPreferences.getString("nom") != null )
            {
            setState(() {
                token = sharedPreferences.getString("token");
                role = sharedPreferences.getString("role");
                userName = sharedPreferences.getString("nom");
                userId = sharedPreferences.getInt("id");
              });
              return sharedPreferences.getString("token");
            }

        //  timer = Timer.periodic(Duration(seconds: 3), (timer){
          
            if(role =="chef_gare")
              {
                percentage = 0;
                Get.to(const DashboardView());
                
              } else {
                percentage = 0;
                Get.to(const HomeView());
              }
          //  });
      }

    @override
      void initState() {
      super.initState();
      etapes = false;
      
    _fileUrls= 'https://vavavoom.ci/ticketes/${widget.referenceTicket}';

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings();
    

    // final initSettings = InitializationSettings(android, iOS);
    // flutterLocalNotificationsPlugin.initialize(initSettings,  onSelectNotification: _onSelectNotification);

    _download();
    }


  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      OpenFile.open(obj['filePath']);
    } else {
      showDialog(
        context: context, builder: (_) => AlertDialog(title: Text('Error'),content: Text('${obj['error']}'),
        ),
      );
    }
  }

  Future<void> setup() async {
  // #1
      const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSetting = DarwinInitializationSettings();

      // #2
      const initSettings =InitializationSettings(android: androidSetting, iOS: iosSetting);

      // #3
      // await localNotificationsPlugin.initialize(initSettings).then((_) {

      //     debugPrint('setupPlugin: setup success');
          
      //   }).catchError((Object error) {

      //     debugPrint('Error: $error');
      //   });
        // _download();
        
    }

  Future<void> _startDownload(String savePath) async {

    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
      };
      setState(() {isLoding =true;  });

    try {
        final response = await _dio.download(_fileUrls!,savePath,
 
      );
    result['isSuccess'] = response.statusCode == 200;
    result['filePath'] = savePath;
    } catch (ex) {

      result['error'] = ex.toString();

    } finally {
      
      // await _showNotification(result);
    }
  }

  String generateRandomString(int len) {
      var r = Random();
      const _chars ='AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    }
    
  Future<void> _download() async {
     startTimer();
     if (Platform.isAndroid)
     {
        dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);

     } else if(Platform.isIOS){

        dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
     }

      final String _fileName = 'E-ticket-' + generateRandomString(5) + '-vavavoom.pdf';
      final savePath = "$dir/$_fileName";
      await _startDownload(savePath);
      print(savePath);
      // checkLoginStatus();
      // Navigator.of(context).pop();

    // final isPermissionStatusGranted = await _requestPermissions();
    // if (isPermissionStatusGranted) {

    //   final String _fileName = 'E-ticket-' + generateRandomString(5) + '-vavavoom.pdf';
    //   final savePath = "$dir/$_fileName";

    //   await _startDownload(savePath);
    //   print(savePath);
    //   Navigator.of(context).pop();

    // } else {
    // }

    

  }

  void dispose(){

    timer!.cancel();
    super.dispose();
  }

  void startTimer(){

    etapes=true;
    timer = Timer.periodic(Duration(seconds:1), (_) {

      if(secsRemaining == 0){
        return;
      }
    setState(() {

        secsRemaining -= 1;
        progressFraction = (totalSecs - secsRemaining) / totalSecs;
        percentage = (progressFraction*100).floor();

        });
        
      if (percentage==100) {
        checkLoginStatus();
      }

      });

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
               etapes==true? Column(
                children: [
                  SizedBox(height: 20),
                  Text('$secsRemaining secondes restantes avant la fin du téléchargement',textAlign: TextAlign.center),
                  SizedBox(height: 20),
                  CircularProgressIndicator(value: progressFraction,),
                  SizedBox(height: 20),
                  Text('$percentage% complete'),
                ],
              ):Container(padding: EdgeInsets.all(10.sp), ),
              SizedBox( height: 15.h,),
          ],
        ),
      ),
    );

   }
  
}