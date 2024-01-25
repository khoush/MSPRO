import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:typed_data';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Ouvrir un ticket',
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

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  Future<void> _pickImage() async {
    XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    } else {
      print('No image selected.');
    }
  }

 Future<void> _uploadImageToFirestore() async {
  if (_selectedImage != null) {
// Convert to Uint8List

    String image = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('image/$image.jpg');

        final SettableMetadata metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': _selectedImage!.path},
    );
    await storageReference.putFile(File(_selectedImage!.path), metadata);
    await storageReference.getDownloadURL().then((value) async {
      await saveDataToFirestore(value);
    });
  }
}

  Future<void> saveDataToFirestore(String imageURL) async {
    String ticket = _ticketController.text;
    String utilisateur = _userController.text;
    String date = _dateController.text;
    String heure = _heureController.text;
    String responsable = _responsableController.text;
    String email = _emailController.text;
    String client = _clientController.text;
    String objet = _objetController.text;
    String description = _descController.text;

    Map<String, dynamic> data = {
      'Ticket': ticket,
      'Utilisateur': utilisateur,
      'Date': date,
      'Heure': heure,
      'Responsable': responsable,
      'Email': email,
      'Client': client,
      'Objet': objet,
      'Description': description,
      'image': imageURL,
      'client_id': FirebaseAuth.instance.currentUser!.uid,
    };

    await FirebaseFirestore.instance
        .collection('Tickets')
        .add(data);

    print('Data saved successfully');
  }

  void fetchData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Tickets')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      _ticketController.text = data['Ticket'] ?? '';
      _userController.text = data['Utilisateur'] ?? '';
      _dateController.text = data['Date'] ?? '';
      _heureController.text = data['Heure'] ?? '';
      _responsableController.text = data['Responsable'] ?? '';
      _emailController.text = data['Email'] ?? '';
      _clientController.text = data['Client'] ?? '';
      _objetController.text = data['Objet'] ?? '';
      _descController.text = data['Description'] ?? '';
      _imageController.text = data['image'] ?? '';
    }
  }

 @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Champ de texte pour le nom
            
            Container(
              width: 350, // Set the desired width
  height: 50,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: _ticketController,
    enabled: false,
    decoration: InputDecoration(
    hintText: "Ticket N°",
       hintStyle: TextStyle(
      fontSize: 14.0, // ajustez la taille selon vos préférences
      color: Color(0xFF9F9F9F),
    ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
    ),
  ),
),
            SizedBox(height: 9.0),
             Container(
              width: 350, // Set the desired width
  height: 50,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: _userController,
    enabled: false,
    decoration: InputDecoration(
      hintText: "Utilisateur",
       hintStyle: TextStyle(
      fontSize: 14.0, // ajustez la taille selon vos préférences
      color: Color(0xFF9F9F9F),
    ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
    ),
  ),
),
SizedBox(height: 5.0,),
 Container(
              width: 350, // Set the desired width
  height: 50,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: _dateController,
    enabled: false,
    decoration: InputDecoration(
    hintText: "Date et Heure de création",
       hintStyle: TextStyle(
      fontSize: 14.0, // ajustez la taille selon vos préférences
      color: Color(0xFF9F9F9F),
    ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
    ),
  ),
),
           
SizedBox(height: 9.0), 
Container(
  width: 350, // Set the desired width
  height: 50,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: _emailController,
    enabled: false,
    decoration: InputDecoration(
      hintText: "Email",
       hintStyle: TextStyle(
      fontSize: 14.0, // ajustez la taille selon vos préférences
      color: Color(0xFF9F9F9F),
    ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
    ),
  ),
),
SizedBox(height: 9), 
Container(
  width: 350, // Set the desired width
  height: 50,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: _responsableController,
    enabled: true,
    decoration: InputDecoration(
      hintText: "Responsable",
       hintStyle: TextStyle(
      fontSize: 14.0, // ajustez la taille selon vos préférences
      color: Color(0xFF9F9F9F),
    ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
    ),
  ),
),
SizedBox(height: 9), 

Container(
  width: 350, // Set the desired width
  height: 50,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: _clientController,
    enabled: false,
    decoration: InputDecoration(
      hintText: "Client",
       hintStyle: TextStyle(
      fontSize: 14.0, // ajustez la taille selon vos préférences
      color: Color(0xFF9F9F9F),
    ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
    ),
  ),
),
SizedBox(height: 9.0), 
Container(
  width: 350, // Set the desired width
  height: 50,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: _objetController,
    enabled: true,
    decoration: InputDecoration(
      hintText: "Objet",
       hintStyle: TextStyle(
      fontSize: 14.0, // ajustez la taille selon vos préférences
      color: Color(0xFF9F9F9F),
    ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
    ),
  ),
),
SizedBox(height: 9.0), 
Container( width: 350, // Set the desired width
  height: 50,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: _descController,
    enabled: true,
    decoration: InputDecoration(
      hintText: "Description",
       hintStyle: TextStyle(
      fontSize: 14.0, // ajustez la taille selon vos préférences
      color: Color(0xFF9F9F9F),
    ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.white,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
    ),
  ),
),
SizedBox(height: 5,),

_selectedImage != null

  ? Container(
    
         padding: EdgeInsets.all(8),
         
                    decoration: BoxDecoration(
                                            

                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    
                    child: Text(
                      
                      'image: ${_selectedImage!.path}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    
                  )
                : Container(),
                

            // Bouton pour soumettre le formulaire
            SizedBox(height: 9.0),
Container(
  width: 350, // Set the desired width
  height: 50,
  
  child: Row(
    children: [
      // Premier bouton
     // Premier bouton
Expanded(
  child: ElevatedButton(
    onPressed: () {
      // Appeler la fonction pour sauvegarder les données dans Firestore
      _uploadImageToFirestore();
    },
    style: ElevatedButton.styleFrom(
      primary: Color(0xFF002E7F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Text(
      'Valider',
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
            // Handle button click
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF002E7F), // Set the desired color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'Fermer',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white, // Set the desired text color
            ),
          ),
        ),
      ),
    ],
  ),
),

SizedBox(height: 5.0),
Center(
  child: Center(
    child: Container(
      width: 200,
      height: 40,
      child: Row(
        children: [
          ElevatedButton(
            
      onPressed: _pickImage,
      style: ElevatedButton.styleFrom(
        primary: Color(0xffF9F9F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        'Ajouter une pièce jointe',
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
      ),
    ),
        ],
      ),
    ),
  ),
),
SizedBox(height: 3.0),




          ],
        ),
      ),
    );
  }
}