import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nom_du_projet/components/mybuton.dart';
import 'package:nom_du_projet/screens/statistic.dart';





class LoginScreen extends StatefulWidget {
  
     
   
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
void signUserIn(BuildContext context) async {
  setState(() {
    isLoading = true;
  });

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).then((value) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => StatPage()));
    });
  } on FirebaseAuthException catch (e) {
    wrongMessage(); // Call the method to show the error message
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

void wrongMessage() {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Données incorrectes ',
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
    },
  );
}

    

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/gg.jpg'), 
              fit: BoxFit.cover,
            ),
          ),
      
      child: Padding(
      
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo centré
            Center(
              child: Container(
                width: 110.0, 
                height: 100.0, 
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ProHelp.png'), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
             SizedBox(height: 49.0),

            
           Text('Connectez-vous à votre compte',
                style: TextStyle(
                color: Color(0xFF1f3c90),
                fontSize: 17.0,
                 fontWeight: FontWeight.bold, 
                 ),
                    ),
                    SizedBox(height: 11.0),

                    Text('Introduisser votre login et votre mot de passe ',
                style: TextStyle(
                color: Color(0xFF383838),
                fontSize: 12.0,
                 
                 ),
                    ),

            SizedBox(height: 50.0), 

            
           Container(
            height: 59.0, 
  width: 310.0,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    controller: emailController,
    decoration: InputDecoration(
      hintText: "Nom d'utilisateur",
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

            SizedBox(height: 25.0), 

            
         Container(
          height: 59.0, 
  width: 310.0,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.4),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0,3),
      ),
    ],
  ),
  child: TextFormField(
    obscureText: true,
    controller: passwordController,
    decoration: InputDecoration(
      hintText: "Mot de passe",
      
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

            SizedBox(height: 25.0), 

            MyButton(
                onTap: (){signUserIn(context);},
              ),
               
          
          ],
        ),
      ),
      ),
    );
  }
}