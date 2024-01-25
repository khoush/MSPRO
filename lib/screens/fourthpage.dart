import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nom_du_projet/screens/statistic.dart';

class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Historique',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController _heuredebController = TextEditingController();
  TextEditingController _heurefinController = TextEditingController();
  List<Map<String, dynamic>> tickets = [];

  void _showDateValidationErrorAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erreur '),
          content: Text('Veuillez entrer des dates valides.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _validateDates() {
    // You need to implement the logic to validate dates
    // For simplicity, let's assume both dates are valid if they are not empty
    return _heuredebController.text.isNotEmpty && _heurefinController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    String? documentID;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('Tickets').doc(documentID).get(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(
                    child: Text("Chargement..."),
                  )
                : Column(
                    children: [
                      SizedBox(height: 40,),
                      // Champ de texte pour le nom
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _heuredebController,
                          enabled: true,
                          decoration: InputDecoration(
                            hintText: "Entre le : jj/mm/AA",
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF9F9F9F),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _heurefinController,
                          enabled: true,
                          decoration: InputDecoration(
                            hintText: "Et le : jj/mm/AA ",
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF9F9F9F),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: 350,
                        height: 60,
                        child: Row(
                          children: [
                            // Premier bouton
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // Validate entered dates
                                  if (!_validateDates()) {
                                    _showDateValidationErrorAlert();
                                    return;
                                  }

                                  // Retrieve and store tickets based on selected date
                                  QuerySnapshot TicketSnapshot = await FirebaseFirestore.instance
                                      .collection('Tickets')
                                      .where('Date', isGreaterThanOrEqualTo: _heuredebController.text)
                                      .where('Date', isLessThanOrEqualTo: _heurefinController.text)
                                      .get();

                                  // Process the ticket data and store it in the 'tickets' list
                                  tickets = TicketSnapshot.docs.map((ticket) => ticket.data() as Map<String, dynamic>).toList();

                                  // Update the UI to show the tickets
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF002E7F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                                child: Text(
                                  'Imprimer',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            // Deuxième bouton
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => StatPage()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF002E7F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13),
                                  ),
                                ),
                                child: Text(
                                  'Fermer',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Display the ticket information using a ListView
                      if (tickets.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            itemCount: tickets.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('Ticket ID: ${tickets[index]['Ticket']}'),
                                subtitle: Text('Date : ${tickets[index]['Date']}'),
                                // Customize the ListTile based on your ticket data structure
                              );
                            },
                          ),
                        ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
