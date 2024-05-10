import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bike {
  final String name;
  final String model;
  final int year;
  final String imageUrl;

  Bike({required this.name, required this.model, required this.year, required this.imageUrl});

  factory Bike.fromMap(Map<String, dynamic> map) {
    return Bike(
      name: map['name'],
      model: map['model'],
      year: map['year'],
      imageUrl: map['imageUrl'],
    );
  }
}

class Bikecontainerr extends StatelessWidget {
  final String bikeId;

  Bikecontainerr({required this.bikeId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('bikes').doc(bikeId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('No data found'));
        }

        Bike bike = Bike.fromMap(snapshot.data!.data() as Map<String, dynamic>);

        return Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${bike.name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Model: ${bike.model}'),
              Text('Year: ${bike.year}'),
              SizedBox(height: 10),
              Image.network(
                bike.imageUrl,
                height: 90,
                width: 80,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }
}


