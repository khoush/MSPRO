import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nom_du_projet/screens/detailspage.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  TextEditingController _ticketController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _heureController = TextEditingController();
  TextEditingController _responsableController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _clientController = TextEditingController();
  TextEditingController _objetController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  var searchName = "Etat";

  @override
  
 

  
 void _search() {
    String searchName = _searchController.text;
    print('Searching for: $searchName');
  }



 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Suivre un ticket',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0),
          Container(
            height: 60.0,
            width: 350.0,
            child: Row(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                       stream: FirebaseFirestore.instance
                      .collection('Tickets')
                      .where('Etat', isEqualTo: _searchController.text)
                      .snapshots(),
                       builder: (context, snapshot) {
                       print('Snapshot Data: ${snapshot.data}');
                      if(snapshot.hasError)  {
                         return Text('Something went wrong');

                      }
                       if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
                             }
                       return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF002E7F),
                          borderRadius: BorderRadius.circular(20),
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
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: "Chercher un ticket",
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0xFF002E7F),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0xFF002E7F),
                                width: 1,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0xFF002E7F),
                                width: 1,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color(0xFF002E7F),
                                width: 1,
                              ),
                            ),
                            
                             suffixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.white),
                        onPressed: _search,
                      ),
                            
                          ),
                          
                        ),
                        
                        
                      );


                      
                    }
                  ),
                ),
                SizedBox(width: 10.0),
              

              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              // future: FirebaseFirestore.instance.collection('Tickets').where('client_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
              future: FirebaseFirestore.instance.collection('Tickets').get(),
              builder: (context, snapshot) {
                return
                !snapshot.hasData?
                Center(child: Text("Chargement..."),):
                 ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: 'Ticket   : ',
                                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: snapshot.data!.docs[index]['Ticket'],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: 'Date      : ',
                                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: snapshot.data!.docs[index]['Date'],
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                             
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: 'Objet    : ',
                                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: snapshot.data!.docs[index]['Objet'],
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                      text: 'Etat      : ',
                                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: snapshot.data!.docs[index]['Etat'],
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                  icon: Icon(Icons.visibility, color: Color(0xFF002E7F)),
                  onPressed: () {
                    // Naviguer vers une autre page lorsque l'IconButton est cliqué
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailsPage(documentID: snapshot.data!.docs[index].id,)), // Remplacez "NouvellePage" par le nom de votre nouvelle page
                    );
                  },
                ),
                
                        ],
                      ),
                    );
                  },
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
