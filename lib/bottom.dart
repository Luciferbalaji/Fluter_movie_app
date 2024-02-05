import 'package:flutter/material.dart';
import 'package:movei_app/pages/save_page.dart';
import 'package:movei_app/pages/search_page.dart';
import 'package:movei_app/pages/home_page.dart';

class page extends StatefulWidget {
  const page({Key? key}) : super(key: key);

  @override
  State<page> createState() => _pageState();
}

class _pageState extends State<page> {
  int _selectedIndex = 0; // Change const to int

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const TopMoviesPage(),
      //dummy(),
       SearchScreen(),
      const Save_page()
    ];

    return Scaffold(
      backgroundColor: Colors.black12,
     
      
     

  
      bottomSheet: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
       selectedIconTheme: const IconThemeData(color: Colors.white),
    
        elevation: 0,
        backgroundColor: Colors.transparent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Fav',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
