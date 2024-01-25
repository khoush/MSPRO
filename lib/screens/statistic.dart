
import 'package:flutter/material.dart';
import 'package:nom_du_projet/screens/secondpage.dart';
import 'package:nom_du_projet/screens/third_page.dart';

import 'fifthpage.dart';
import 'firstpage.dart';
import 'fourthpage.dart';






class StatPage extends StatefulWidget {


  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage(),
    ProfilePage(),
    
    
  ];
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     

      

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xFF002E7F), // Changer la couleur des icônes sélectionnées
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
            size: 28.0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num,
            size: 28.0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dvr,
            size: 28.0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history,
            size: 28.0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
            size: 28.0),
            label: '',
          ),
        ],
      ),
    );
  }
}















