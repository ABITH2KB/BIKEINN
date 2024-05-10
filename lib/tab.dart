import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';


import 'botto tab/home.dart';
import 'botto tab/menu.dart';
import 'botto tab/rent.dart';

class TabsPage extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    Home(),
    rent(),
    Menu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: MotionTabBar(
        labels: ["Home", "Bike", "Menu"],
        tabIconSelectedSize: 29,
        initialSelectedTab: "Home",
        tabIconColor: Colors.black,
        tabSelectedColor: Colors.black,
        onTabItemSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        icons: [Icons.home, Icons.bike_scooter, Icons.menu],
        textStyle: TextStyle(color: Colors.blueGrey),
      ),
    );
  }
}
