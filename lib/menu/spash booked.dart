import 'dart:async';
import 'package:flutter/material.dart';

class Bookedd extends StatelessWidget {
  const Bookedd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Delayed pop function
    void delayedPop() {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop();
      });
    }

    // Call delayed pop function
    delayedPop();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Your main content
          // This can be your booked bike details or any other content
          // Replace the Container with your actual content
          Container(
            color: Colors.white, // Example background color
            child: Center(
              child: Text(
                '', // Example text
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          // Splash screen indicating the bike is booked
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.7), // Example color with opacity
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 100,
                  ),
                  Text("BOOKED",style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.w700  ),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
