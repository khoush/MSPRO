import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nom_du_projet/screens/statistic.dart';
import 'package:nom_du_projet/screens/third_page.dart';

class DetailsPage extends StatelessWidget {
  String documentID;

  DetailsPage({required this.documentID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Fiche de ticket',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            // Ajoutez ici la logique pour fermer la page
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('Tickets')
                .doc(documentID)
                .get(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(
                      child: Text("Chargement..."),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: buildDetailRow(
                                  'Ticket', snapshot.data!['Ticket']),
                            ),
                            SizedBox(
                                width:
                                    16.0), // Ajoutez un espacement entre les deux boîtes
                            Expanded(
                              child: buildDetailRow(
                                  'Utilisateur', snapshot.data!['Utilisateur']),
                            ),
                          ],
                        ),
                        SizedBox(
                            height:
                                16.0), // Ajoutez un espacement entre les deux rangées

                        SizedBox(
                          height: 5,
                        ),

                        buildDetailRow(
                            'Responsable', snapshot.data!['Responsable']),
                        SizedBox(
                          height: 5,
                        ),

                        buildDetailRow('Email', snapshot.data!['Email']),
                        SizedBox(
                          height: 5,
                        ),

                        buildDetailRow('Client', snapshot.data!['Client']),
                        SizedBox(
                          height: 5,
                        ),

                        buildDetailRow('Objet', snapshot.data!['Objet'],
                            Containerheight: 50.0),
                        SizedBox(
                          height: 5,
                        ),

                        buildDetailRow('Etat', snapshot.data!['Etat'],
                            isBold: true),

                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                
                                    (snapshot.data!['Etat'] == 'annulé' ||
                                            snapshot.data!['Etat'] == 'Cloturé')
                                        ? null
                                        : () {
                                          
                                        },
                                child: Text(
                                  'Annuler',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: snapshot.data!['Etat'] == 'annulé'
                                      ? Colors.grey
                                      : Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Changer le rayon selon vos besoins
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: snapshot.data!['Etat'] == 'En cours'
                                    ? null
                                    : () {
                                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdPage()), // Remplacez "NouvellePage" par le nom de votre nouvelle page
                    );
                                    },
                                child: Text(
                                  'Fermer',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: snapshot.data!['Etat'] == 'En cours'
                                      ? Colors.grey
                                      : Colors.blue[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        13.0), // Changer le rayon selon vos besoins
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // La valeur de l'état en gras
                      ],
                    );
            }),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget buildDetailRow(String label, String value,
      {bool isBold = false, double Containerheight = 60.0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF9F9F9F),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          width: 330.0,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade500,
              width: 1.0,
            ),
            
            borderRadius: BorderRadius.circular(10.0),
            
          ),
          
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),

        // Ajoutez un espacement entre les boîtes
      ],
    );
  }
}
