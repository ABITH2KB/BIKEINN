import 'package:bike_in/botto%20tab/rent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();


  Map<DateTime, List<String>> imageMap = {
    DateTime(2024, 4, 6): ["asset/image/BIKE.jpg", "asset/image/BIKE.jpg"],

  };


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
      });
  }

  Future<void> _saveDataToFirebase() async {
    if (selectedCity != null &&
        _selectedDate != null &&
        _selectedTime != null) {

      await FirebaseFirestore.instance.collection('bookings').add({
        'city': selectedCity,
        'pickup_date': "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}",
        'pickup_time': _selectedTime.format(context),

      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => rent()));
    } else {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Missing Information'),
            content: const Text('Please select city.',style: TextStyle(
              fontSize: 18

            )),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  List<String> cities = [
    'Calicut',
    'Wayanad',
    'kottayam',
    'Kochi',
    'Thalassery',
    'trivandrum',
    'Palakkad',
    'malapuram',
    'banglore',
    'mysore',
  ];

  // Selected city
  String? selectedCity;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 210, bottom: 50),
            child: Icon(Icons.directions_bike, color: Colors.white, size: 50),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 40,
              width: 462,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            Container(
              height: 50,
              width: 462,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    const Text('Select city : '),
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedCity,
                        icon: const Icon(Icons.arrow_circle_down_rounded, size: 30),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCity = newValue;
                          });
                        },
                        items: cities.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 90),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => rent()),
                          );
                        },
                        child: Container(
                          height: 180,
                          width: 280,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: const Image(
                              image: AssetImage("asset/image/BIKE.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),

                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 300,
                  width: 370,
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Book your next ride",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Pickup Date",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: () => _selectDate(context),
                                child: Text(
                                  "${_selectedDate.toLocal()}".split(' ')[0],
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Pickup Time",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: () => _selectTime(context),
                                child: Text(
                                  "${_selectedTime.format(context)}",
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: _saveDataToFirebase,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                          minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                        ),
                        child: const Text('S E A R C H', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Users top picks ", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => rent()));
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('bikes').snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      return Row(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          return GestureDetector(
                            onTap: () {
                              // Navigate to bike details screen passing bike data
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => rent(),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              height: 170,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  data['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
            ),
          ],
        ),
      ),
    ));
  }
}
