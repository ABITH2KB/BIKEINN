import 'package:flutter/material.dart';

import 'botto tab/home.dart';
import 'botto tab/menu.dart';
import 'botto tab/rent.dart';


class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;
  TabNavigationItem(
      {required this.page, required this.title, required this.icon});
  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page:Home(),
      icon: Icon(Icons.home),
      title: Text("Home"),
    ),
    TabNavigationItem(
      page: rent(),
      icon: Icon(Icons.screen_search_desktop_outlined,),
      title: Text("Swaipable"),
    ),
    TabNavigationItem(
      page: Menu(),
      icon: Icon(Icons.screen_search_desktop_outlined),
      title: Text("Swaipable"),
    ),
  ];
}




