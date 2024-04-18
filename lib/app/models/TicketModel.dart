import 'dart:convert';

List<Ticket> TicketFromJson(String str) => List<Ticket>.from(json.decode(str).map((x) => Ticket.fromJson(x)));

String TicketToJson(List<Ticket> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ticket {
  
    Ticket({
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
    required this.statut,
    });

  int id;
  String typeVoyage;
  String villeArriver;
  String villeDepart;
  String transporteur;
  String gare;
  String heure;
  String dateAller;
  String dateRetour;
  String tarif;
  String referenceTicket;
  String code;
  String transactionId;
  String nbreticket;
  String username;
  String userId;
  String statut;
 
    factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
          id: json['id'],
          typeVoyage: json['type_voyage'].toString(),
          villeDepart: json['ville_depart'].toString(),
          villeArriver: json['ville_arriver'].toString(),
          transporteur: json['transporteur'].toString(),
          gare: json['gare'].toString(),
          heure: json['heure_depart'].toString(),
          dateAller: json['date_depart'].toString(),
          dateRetour: json['date_retour'].toString(),
          tarif: json['tarif'].toString(),
          referenceTicket: json['reference_ticket'].toString(),
          code: json['code'].toString(),
          transactionId: json['paiement_id'].toString(),
          nbreticket: json['nombre_ticket'].toString(),
          username: json['username'].toString(),  
          userId: json['user_id'].toString(),  
          statut: json['statut'].toString(),  
    );

    Map<String, dynamic> toJson() => {
           'id':id,
           'type_voyage':typeVoyage,
           'ville_depart':villeDepart ,
           'ville_arriver':villeArriver,
           'transporteur':transporteur,
           'gare':gare,
           'heure_depart':heure,
           'date_depart':dateAller,
           'date_retour':dateRetour,
           'tarif':tarif,
           'reference_ticket':referenceTicket,
           'code':code,
           'paiement_id':transactionId,
           'nombre_ticket':nbreticket,
           'username':username,
           'user_id':userId,
           'statut':statut,
    };
}
