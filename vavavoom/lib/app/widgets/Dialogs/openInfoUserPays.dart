// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vavavoum/app/models/TicketModel.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:vavavoum/app/widgets/Dialogs/openInfoUserPays.dart';


// class OrangePaie extends StatefulWidget {
//     final Map data;
//     final String url;
//     final String tokens;
//     final String payenToken;
//     final String amount;
//     final String orderId;
//     final String phone;
//     final String nom;
//   OrangePaie({this.data, this.url,this.amount, this.payenToken, this.tokens, this.orderId, this.nom, this.phone});
//   @override
//   _OrangePaieState createState() => new _OrangePaieState();
// }

// class _OrangePaieState extends State<OrangePaie> {

//   // SharedPreferences sharedPreferences;
//   // InAppWebViewController webViewController;

//   String url = "";
//   var transactionId;
//   var user;
//   double progress = 0;
//   var tarif;
//   var tag;
//   var ticket = new List<Ticket>();
//   var token,tokens,role,userId,usernames,userName,status,reference,raison, referenceTicket;
//   bool isLoding =false;
//   Timer timer;

//   getTickets() async {
//     await http.post("https://vavavoom.ci/api/v1/ticket", 
//           headers: {
//         'Content-type': 'application/json',
//         'Accept' : 'application/json',
//      },
//      body: jsonEncode({
//           "ville_depart": widget.data['depart'],
//           "ville_arriver": widget.data['arriver'],
//           "heure_depart": widget.data['heureDepart'],
//           "transporteur": widget.data['transporteur'],
//           "gare": widget.data['gare'],
//           "type_voyage": widget.data['typeVoyage'],
//           "type_ticket": widget.data['typeTicket'],
//           "username": widget.nom +" / "+widget.phone,
//           "user_id": userId != null ? userId.toString() : " ",
//           "tarif": widget.data['prix'].toString(),
//           "nombre_ticket": widget.data['nombreTicket'],
//           "transaction_id": widget.orderId.toString(),
//           "date_depart":widget.data['dateAller'].toString(),
//           "date_retour":widget.data['dateRetour'] !=null ? widget.data['dateRetour'] : " "
//         })).then((response) {
//         print(response.statusCode);  
//           setState(() {
//             Iterable list = json.decode(response.body);
//             ticket = list.map((model) => Ticket.fromJson(model)).toList();
//             print(list);
//           });
//             Navigator.of(context).pushAndRemoveUntil(
//                MaterialPageRoute(
//               builder: (context) => MyTicketScreen(data: ticket),
//               ), (Route<dynamic> route) => false);

//         });
//     }

//   requestToGetTransactionStatus() async {
//     //get token;
//      tokens = widget.tokens;
//     //get transaction statut
//           await http.post("https://api.orange.com/orange-money-webpay/ci/v1/transactionstatus",
//           headers: {
//             'Authorization': 'Bearer $tokens',
//             'Content-Type': 'application/json'
//         },
//         body: jsonEncode({
//           "order_id": widget.orderId,
//           "amount": widget.amount,
//           "pay_token": widget.payenToken
//           })).then((response) {
//               var bodyresponses = jsonDecode(response.body);
//               if(response.statusCode == 201){
//                  setState(() {
//                 status =bodyresponses['status'];
//               });
//               }
//             });
//             print("status=$status");
//     }
  
//    @override
//   void initState() {

//     super.initState();


//      timer = Timer.periodic(Duration(seconds: 3), (timer){
//        requestToGetTransactionStatus();
       
//          if(status=="SUCCESS")
//           {
//                 timer.cancel();
//                 print("timer is stopped");
//                 // requestToSavePaiement();
//                 getTickets();
                
//             } else if(status=="EXPIRED" || status=="FAILED" ) {
//               timer.cancel();
//               // requestToSavePaiement();
//               Navigator.of(context).pop();
//             }
//        });

//   }
//   @override
//   Widget build(BuildContext context) {


//     return Scaffold(

//         body: Container(
//           color:  Colors.white,
//             child: Column(children: <Widget>[
//               Container(
//                   padding: EdgeInsets.all(3.0),
//                   child: progress < 1.0
//                       ? LinearProgressIndicator(value: progress)
//                       : Container(color:  Color(0xff0f5edb),)),
//               Expanded(

//                 child: Container(
//                           child: InAppWebView(initialUrl: widget.url, // initialOptions: InAppWebViewGroupOptions(   crossPlatform: InAppWebViewOptions(   debuggingEnabled: true,
//                           )
//                     ),

//                     onWebViewCreated: (InAppWebViewController controller) {
//                       webViewController = controller;
//                     },
//                     onLoadStart: (InAppWebViewController controller, String url) {
//                       setState(() {
//                         this.url = url;
//                       });
//                     },

//                     onLoadStop: (InAppWebViewController controller, String url) async {
//                       setState(() {
//                         this.url = url;
//                       });
                    
//                      },
//                     onProgressChanged: (InAppWebViewController controller, int progress) {
//                       setState(() {
//                         this.progress = progress / 100;
//                       });
//                     },
                   
//                   ),
//                 ),
//               ),
              
//             ])),
                
//     );
    
//   }


// }