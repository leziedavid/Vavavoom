import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vavavoom/app/constant/Apis.dart';
import 'package:vavavoom/app/models/Banners.dart';
import 'package:vavavoom/app/models/ItineraireModel.dart';
import 'package:vavavoom/app/models/TicketModel.dart';


class ApiManager {

  // HomeController homeController = Get.find();
/// Une liste de toutes les villes de la base de données.
  static Future<dynamic> getGare() async {
    try {
      final response = await http.get(
        Uri.parse("${HostApi.baseUrl}/gare"),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        
        return data.map((item) => item['lieu_ville']).toList();

      } else {
        return data;
      }
    } catch (e) {
      print("*****************");

      print(e.toString());
      return [];
    }
  }

  static Future<dynamic> getGares() async {
    try {
      final response = await http.get(
        Uri.parse("${HostApi.baseUrl}/gare-inter"),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return data.map((item) => item['lieu_ville']).toList();
        
      } else {

        return data;
      }
    } catch (e) {

      print("*****************");
      print(e.toString());
      return [];

    }
  }

  ///Liste de noms de transporteurs.
  static Future<dynamic> getTansporteur() async {
    try {
      final response = await http.get(
        Uri.parse("${HostApi.baseUrl}/compagnie"),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data.map((item) => item['nom_compagnie']).toList();
      } else {
        return data;
      }
    } catch (e) {
      print("*****************");
      print(e.toString());
      return [];
    }
  }

// LISTE DES COMPAGNIE DE TRANSPORT
  static Future<dynamic> getCompagnie() async {
    try {
      final response = await http.get(
        Uri.parse("${HostApi.baseUrl}/compagnie-inter"),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data.map((item) => item['nom_compagnie']).toList();
      } else {
        return data;
      }
    } catch (e) {
      print("*****************");
      print(e.toString());
      return [];
    }
  }

///lISTE DE NOS PARTENAIRE
  static Future<List> getPartner() async {
    try {
      final response = await http.get(Uri.parse("${HostApi.baseUrl}/ads"));
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

//AFFICHAGE DU TIKET APRES RECHERCHE
  static Future<List> getBillets(var compagnieId) async {
    try {
      final response = await http.get(Uri.parse("${HostApi.baseUrl}/ticket-today/$compagnieId"));
      final data = jsonDecode(response.body);
      return data;

    } catch (e) {

      print(e.toString());
      return [];

    }
  }

//LISTE DES FRAIS DE TICKET
  static Future<List> fraisTicket(var id) async {
    try {
      final response = await http.get(Uri.parse("${HostApi.baseUrl}/frais-tickets"));
      final data = jsonDecode(response.body);
      return data;
      
    } catch (e) {

      print(e.toString());
      return [];

    }
  }

// lISTE DES TICKETS DU JOURS
  static Future<List> ticket(var id) async {

    try {
      final response = await http.get(Uri.parse("${HostApi.baseUrl}/ticket-today"));
      final data = jsonDecode(response.body);
      return data;
      
    } catch (e) {

      print(e.toString());
      return [];

    }
  }
  
  static Future<bool>? finddestinations(
      String fullName, String phone, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${HostApi.baseUrl}/userlogin"),

        body: {
          "telephone": phone, 
          "password": password
          },
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        
        return true;
      } else {
        return false;
      }
    } catch (e) {

      print(e.toString());

      return false;
    }
  }

  //HISTORIQUE DES TIQU2 DE L'UTILISATEUR
  static Future<List> getBillet(compagnieId) async {
        try {
            final response = await http.get(
              Uri.parse("${HostApi.baseUrl}/ticket-today/$compagnieId"),
            );

            Iterable list = json.decode(response.body);
            final data = list.map((model) => Ticket.fromJson(model)).toList();
            //  print(list);
            return data;

          } catch (e) {

            print("*****************");

            print(e.toString());
            return [];
        }
          
    }

  static Future<List> getHistorique(String userId) async {

        try {
            final response = await http.get(
              Uri.parse("${HostApi.baseUrl}/user-historique/$userId"),
            );

            Iterable list = json.decode(response.body);
            final data = list.map((model) => Ticket.fromJson(model)).toList();
            // print(list);
            return data;

          } catch (e) {
            print("*****************");

            print(e.toString());
            return [];
        }
          
    }

 static Future<List> dataByScansCodes(String barcode) async {

        try {
            final response = await http.get(
              Uri.parse("${HostApi.baseUrl}/show/$barcode"),
            );
           Iterable list = json.decode(response.body);
          //  print(list);
            final data = list.map((model) => Ticket.fromJson(model)).toList();
            return data;
          } catch (e) {

            print("erreur");
            print(e.toString());

            return [];
        }
          
    }

//  static Future<List> getBilletBycode(String code) async {

//         try {
//             final response = await http.get(
//               Uri.parse("${HostApi.baseUrl}/showcode/$code"),
//             );
//            Iterable list = json.decode(response.body);
//             final data = list.map((model) => Ticket.fromJson(model)).toList();
//             print(list);
//             return data;

//           } catch (e) {
//             print("erreur");
//             print(e.toString());
//             return [];
//         }
          
//     }


    
  static Future<List> getBilletBycode(String codes) async {

      try {
            final response = await http.post(
            Uri.parse("${HostApi.baseUrl}/searchTicketbycode"),
            body:{"codes": codes,},
            );
            Iterable list = json.decode(response.body);
            final data = list.map((model) => Ticket.fromJson(model)).toList();
            print(list);
            return data;

        } catch (e) {
          print(e.toString());
          return [];
        }
          
    }
    
  static Future<List> searchTicket(String phone) async {

      try {
            final response = await http.post(
            Uri.parse("${HostApi.baseUrl}/search-ticket"),
            body:{"phone": phone,},
            );
            Iterable list = json.decode(response.body);
            final data = list.map((model) => Ticket.fromJson(model)).toList();
            print(list);
            return data;

        } catch (e) {
          print(e.toString());
          return [];
        }
          
    }

  //static getTicketSeach(String ville_depart, String ville_arriver, String transporteur) async {

  static Future<List> getDestinationsRetourSeach(String ville_depart, String ville_arriver, String transporteur) async {

            try {
              final response = await http.post(
                Uri.parse("${HostApi.baseUrl}/find-destinations-retour"),
                body: {
                  "ville_depart": ville_depart,
                  "ville_arriver": ville_arriver,
                  "transporteur_un": transporteur,
                },
              );
              // final list = json.decode(response.body);
              Iterable list = json.decode(response.body);
              final data = list.map((model) => Itineraire.fromJson(model)).toList();
              // print(list);
              return data;
            } catch (e) {
              print(e.toString());
              return [];
            }
          
    }
  static Future<List> getTicketSeach(String ville_depart, String ville_arriver, String transporteur) async {

            try {
              final response = await http.post(
                Uri.parse("${HostApi.baseUrl}/find-destinations"),
                body: {
                  "ville_depart": ville_depart,
                  "ville_arriver": ville_arriver,
                  "transporteur_un": transporteur,
                },
              );
              // final list = json.decode(response.body);
              Iterable list = json.decode(response.body);
              final data = list.map((model) => Itineraire.fromJson(model)).toList();
              // print(list);
              return data;
            } catch (e) {
              print(e.toString());
              return [];
            }
          
    }

  static Future<List> fetchBanner() async {
    try {
      final response = await http.get( Uri.parse("${HostApi.baseUrl}/banner"), );
        Iterable donnees = json.decode(response.body);
        final data = donnees.map((model) => BannerModel.fromJson(model)).toList();
       
        return data;

    } catch (e) {
      print(e.toString());
      return [];
    }
  }

}
