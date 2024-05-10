import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Lap extends StatefulWidget {
  @override
  _LapState createState() => _LapState();
}
class _LapState extends State<Lap> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> fetchData() async {
    CollectionReference<Map<String, dynamic>> collectionReference =
    FirebaseFirestore.instance.collection('bookings');

    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await collectionReference.doc('25fZapJsC0m8fcmPeMgA').get();
    return snapshot;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.data() == null) {
              return Text('No data available');
            } else {
              Map<String, dynamic> data = snapshot.data!.data()!;
              return Container(
                width: 300,
                height: 200,
                decoration:BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9), // Shadow color
                      spreadRadius: 5, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 3), // Shadow offset
                    ),
                  ],
                ) ,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('city: ${data['city']}'),
                      Text('drop_date: ${data['drop_date']}'),
                      Text('drop_time: ${data['drop_time']}'),
                      Text('pickup_date: ${data['pickup_date']}'),
                      Text('pickup_time: ${data['pickup_time']}'),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
