import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Book extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('bookings2').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No bookings available'),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                Map<String, dynamic> data = doc.data()!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            data['imageUrl'].toString(),
                            width: 100,
                            height: 150,
                          ),
                          SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 40,top: 20),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Model: ${data['model']}'.toString()),
                                  Text('Name: ${data['name']}'.toString()),
                                  Text('Year: ${data['year']}'.toString()),
                                  Text('Status: ${data['status']}'.toString()),
                                  // Add more fields as needed
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
