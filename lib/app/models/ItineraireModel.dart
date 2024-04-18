import 'dart:convert';

List<Itineraire> ItineraireFromJson(String str) => List<Itineraire>.from(json.decode(str).map((x) => Itineraire.fromJson(x)));

String ItineraireToJson(List<Itineraire> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Itineraire {
  
    Itineraire({
        required this.id,
        required this.villeDepart,
        required this.villeArriver,
        required this.compagnieName,
        required this.gare,
        required this.heure,
        required this.image_name,
        required this.prixAllerRetour,
        required this.prixRetour,
        required this.prix,
        // required this.fraisRemise,
        // required this.vip,
        // required this.allDay,
        // required this.onlyMonday,
        // required this.onlyTuesday,
        // required this.onlyWednesday,
        // required this.onlyThursday,
        // required this.onlyFriday,
        // required this.onlySaturday,
        // required this.onlySunday,
        // required this.statut,
        required this.destinationInter,
    });

    int id;
    String villeDepart;
    String villeArriver;
    String compagnieName;
    String gare;
    String heure;
    String image_name;
    String prixAllerRetour;
    String prixRetour;
    int prix;
    // String fraisRemise;
    // String vip;
    // int allDay;
    // String onlyMonday;
    // String onlyTuesday;
    // String onlyWednesday;
    // String onlyThursday;
    // String onlyFriday;
    // String onlySaturday;
    // String onlySunday;
    // int statut;
    int destinationInter;
 
    factory Itineraire.fromJson(Map<String, dynamic> json) => Itineraire(
          id : json['id'],
          villeDepart : json['ville_depart'].toString(),
          villeArriver : json['ville_arriver'].toString(),
          compagnieName : json['compagnie_name'].toString(),
          gare : json['gare'].toString(),
          heure : json['date_depart'].toString(),
          image_name : json['image_name'].toString(),
          prixAllerRetour : json['aller_retour'].toString(),
          prixRetour : json['prix_retour'].toString(),
          prix : json['prix'],
          // fraisRemise : json['remise_frais'],
          // vip : json['vip'],
          // allDay : json['all_day'],
          // onlyMonday : json['only_monday'],
          // onlyTuesday : json['only_tuesday'],
          // onlyThursday : json['only_thursday'],
          // onlyWednesday : json['only_wednesday'],
          // onlyFriday : json['only_friday'],
          // onlySaturday : json['only_saturday'],
          // onlySunday : json['only_sunday'],
          // statut : json['statut'],
          destinationInter : json['destination_inter']
        
    );

    Map<String, dynamic> toJson() => {
          'id': id, 
          'ville_depart': villeDepart, 
          'ville_arriver':villeArriver, 
          'compagnie_name':compagnieName, 
          'gare':gare,
          'heure':heure,
          'image_name':image_name, 
          'prixAllerRetour':prixAllerRetour,
          'prix_retour':prixRetour, 
          'prix':prix,
          // 'remise_frais' : fraisRemise,  
          // 'vip': vip,
          // 'all_day':allDay,
          // 'only_monday':onlyMonday,
          // 'only_tuesday':onlyTuesday,
          // 'only_thursday':onlyThursday,
          // 'only_wednesday':onlyWednesday,
          // 'only_friday':onlyFriday,
          // 'only_saturday':onlySaturday,
          // 'only_sunday':onlySunday,
          // 'statut': statut,
          'destination_inter' :destinationInter
    };
}
