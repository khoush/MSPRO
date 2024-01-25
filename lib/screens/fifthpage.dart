import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nom_du_projet/screens/welcome_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/arr.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Profil',
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
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                    imageUrl = data['imageUrl'];

                    return Container(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Center(
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          _buildInfoRow("Email", data['Email'], Icons.email),
                          _buildInfoRow("Username", data['Username'], Icons.person),
                          _buildInfoRow("Telephone", data['telephone'].toString(), Icons.phone),

                         Center(
  child: Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    child: ElevatedButton(
      onPressed: () async {
        // Ajoutez ici votre logique de déconnexion avec Firebase
        await FirebaseAuth.instance.signOut();

        // Une fois déconnecté, redirigez l'utilisateur vers l'écran de connexion
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.white, // Changez la couleur du bouton
      ),
      child: Text(
        "Se déconnecter",
        style: TextStyle(
          color: Colors.black, // Changez la couleur du texte
        ),
      ),
    ),
  ),
),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData iconData) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: Colors.grey,
                size: 20.0,
              ),
              SizedBox(width: 1.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Text(
              value,
              style: TextStyle(fontSize: 13.0),
            ),
          ),
        ],
      ),
    );
  }
}
