import 'package:bike_in/menu/spash%20booked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Hourly extends StatefulWidget {
  final String docId;

  const Hourly({Key? key, required this.docId}) : super(key: key);

  @override
  State<Hourly> createState() => _HourlyState();
}
class _HourlyState extends State<Hourly> {
  late String _model = '';
  late String _name = '';
  late String _price = '';
  late String _year = '';
  late String _status = '';
  bool _buttonPressed = false;
  @override
  void initState() {
    super.initState();
    saveData();
  }
  Future<void> saveData() async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection('bikes')
          .doc(widget.docId)
          .get();
      if (snapshot.exists) {
        var data = snapshot.data()!;
        setState(() {
          _model = data['model'];
          _name = data['name'];
          _price = data['price'] ?? '';
          _status = data['status'];
          _year = data['year'] ?? '';
        });
      } else {
        print('No bike found with provided docId');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 210, bottom: 50),
            child: Icon(Icons.directions_bike, color: Colors.white, size: 50),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("bikes")
            .doc(widget.docId)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, top: 50),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    width: 350,
                    height: 290,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.network(snapshot.data!["imageUrl"]),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 15),
                    child:Container(
                      height: 180,
                      width: 460,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                const Row(
                                  children: [

                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Text(
                                            "${data["pickup_time"]}",
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    const SizedBox(width: 60),
                                    const Text(
                                      "- A T -",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40),
                                      child: Column(
                                        children: [
                                          Text(
                                            "${data["pickup_date"] }",
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Padding(
                                  padding:
                                  EdgeInsets.only(left: 10, right: 40),
                                  child: Divider(
                                    thickness: 1.6,
                                   ),
                                ),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.only(right: 45),
                                  child: Text(
                                    "CITY : ${data["city"]}",

                                    style: const TextStyle(fontSize: 22,
                                    fontWeight: FontWeight.bold),

                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.9),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          'Model: ${snapshot.data!["model"]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Name: ${snapshot.data!["name"]}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Price: ${snapshot.data!["price"]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'year: ${snapshot.data!["year"]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'status: ${snapshot.data!["status"]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buttonPressed
                            ? const SizedBox()
                            : SizedBox(
                          width: 250,
                          height: 50,
                          child: Visibility(
                            visible: snapshot.data!["status"] != "booked",
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                              ),
                              onPressed: () async {
                                setState(() {
                                  _buttonPressed = true;
                                });
                                try {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Bookedd(),
                                    ),
                                  );

                                  await Future.delayed(const Duration(seconds: 2));

                                  await FirebaseFirestore.instance
                                      .collection('bikes')
                                      .doc(widget.docId)
                                      .update({'status': 'booked'});


                                  Map<String, dynamic> newData = {
                                    "model": snapshot.data!["model"],
                                    "name": snapshot.data!["name"],
                                    "year": snapshot.data!["year"],
                                    "status": "booked",
                                    "imageUrl": snapshot.data!["imageUrl"],
                                  };

                                  await FirebaseFirestore.instance
                                      .collection('bookings2')
                                      .add(newData);

                                  print(
                                      "Data successfully stored in 'bookings' collection!");
                                } catch (error) {
                                  print("Failed to store data: $error");
                                }
                              },
                              child: const Text(
                                'BOOK',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    color: Colors.transparent,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
