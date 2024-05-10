import 'package:bike_in/tab.dart';
import 'package:flutter/material.dart';

class Spa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const delayDuration = Duration(seconds: 3);

    void redirectToNextPage() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TabsPage()),
      );
    }

    Future.delayed(delayDuration, redirectToNextPage);

    return Scaffold(
      body: Center(
        child: Icon(
          Icons.directions_bike,
          size: 200, // Set the size of the icon
        ),
      ),
    );
  }
}
