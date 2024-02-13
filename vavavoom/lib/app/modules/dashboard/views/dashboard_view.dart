import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vavavoum/app/constant/Color.dart';
import 'package:vavavoum/app/widgets/Drawer.dart';
import 'package:vavavoum/app/widgets/dashboard/CardDashboard.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

          appBar: AppBar(
              elevation: 0,
              leading: Builder(
                  builder: (context) => IconButton(icon: const Icon(Icons.menu),
                  color: Color.fromARGB(255, 255, 255, 255), onPressed: () => Scaffold.of(context).openDrawer(), ),
                ),
                title: Image.asset("assets/images/logovavavoom-01.jpg", height: 150.h,  ),
                centerTitle: true, backgroundColor: CustomColor.primary,
              ),

      drawer: const DrawerCustom(),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (builder, context) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text("Espace d'Administration !",style: TextStyle(fontFamily: "poppins", fontSize: 20.sp,  ),),
                      const SizedBox( height: 30,),

                        const  Divider(height: 0),
                        const ListTile(
                          leading: CircleAvatar(child: Icon(CupertinoIcons.tickets,size: 40)),
                          title: Text('Pour afficher la liste des tickets du jour'),
                          subtitle: Text( "Cliquez sur la case bleu",style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins", color: Colors.blueAccent)),
                          isThreeLine: true,
                        ),
                      const Divider(height: 0),
                      const SizedBox( height: 20,),

                      const  Divider(height: 0),
                        const ListTile(
                          leading: CircleAvatar(child: Icon(CupertinoIcons.camera,size: 40)),
                          title: Text('Pour vérifier un ticket avec Qrcode,'),
                          subtitle: Text( "Cliquez sur la case verte.",style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins",color:Colors.green )),
                          isThreeLine: true,
                        ),
                      const Divider(height: 0),
                      const SizedBox( height: 20,),

                      const  Divider(height: 0),
                        const ListTile(
                          leading: CircleAvatar(child: Icon(CupertinoIcons.add,size: 40)),
                          title: Text('Pour vérifier un ticket avec le code à 4 chiffres,'),
                          subtitle: Text( "Cliquez sur la case orange.",style: TextStyle( fontWeight: FontWeight.w900, fontFamily: "poppins", color: Color.fromARGB(255, 249, 153, 50))),
                          isThreeLine: true,
                        ),
                      const Divider(height: 0),

                      // RichText(
                      //   text: TextSpan(
                      //     text: 'Pour afficher la liste des tickets du jour, ',
                      //     style: TextStyle(
                      //         fontSize: 17.sp,
                      //         fontWeight: FontWeight.w500,
                      //         fontFamily: "poppins",
                      //         color: Colors.black87),
                      //     children: const <TextSpan>[
                      //       TextSpan(
                      //           text: 'Cliquez sur la case bleu.',
                      //           style: TextStyle(
                      //               color: Colors.blueAccent,
                      //               fontWeight: FontWeight.bold)),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox( height: 20,),
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'Pour vérifier un ticket avec Qrcode, ',
                      //     style: TextStyle(
                      //         fontSize: 17.sp,
                      //         fontWeight: FontWeight.w500,
                      //         fontFamily: "poppins",
                      //         color: Colors.black87),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //           text: 'Cliquez sur la case verte.',
                      //           style: TextStyle(
                      //               color: Colors.green[800],
                      //               fontWeight: FontWeight.bold)),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // RichText(
                      //   text: TextSpan(
                      //     text:'Pour vérifier un ticket avec le code à 4 chiffres, ',
                      //     style: TextStyle(
                      //         fontSize: 17.sp,
                      //         fontWeight: FontWeight.w500,
                      //         fontFamily: "poppins",
                      //         color: Colors.black87),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //           text: 'Cliquez sur la case orange.',
                      //           style: TextStyle(color: Colors.amber[700], fontWeight: FontWeight.bold)),
                      //     ],
                      //   ),
                      // ),

                      const SizedBox( height: 50, ),
                        GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        crossAxisSpacing: 20,
                        children: const [
                          CardDashboard(
                              color: Colors.blue,
                              icon: CupertinoIcons.ticket,
                              text: "Afficher les tickers",
                              link: 1,
                              etape: 1,
                              ),
                          CardDashboard(
                              color: Colors.green,
                              icon: CupertinoIcons.camera,
                              text: "Scanner un Qrcode",
                               link: 0,
                               etape: 0,
                              ),
                          CardDashboard(
                              color: Color.fromARGB(255, 249, 153, 50),
                              icon: CupertinoIcons.add,
                              text: "Vérifier un code",
                              link: 1,
                              etape: 2,
                              ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
