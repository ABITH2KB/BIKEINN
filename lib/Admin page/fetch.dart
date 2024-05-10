import 'package:bike_in/Admin%20page/ADD.dart';
import 'package:bike_in/Admin%20page/USER%20LOGIN%20DATA.dart';
import 'package:bike_in/Admin%20page/arrived%20bike.dart';
import 'package:bike_in/Admin%20page/fetch2.dart';
import 'package:bike_in/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class adminn extends StatefulWidget {
  const adminn({Key? key}) : super(key: key);

  @override
  State<adminn> createState() => _adminnState();
}

class _adminnState extends State<adminn> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize:const Size.fromHeight(100) ,
        child: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Icon(Icons.directions_bike, color: Colors.white, size: 39),
        ),
      ),
      body: Column(
        children: [const SizedBox(height: 80),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FetchDataAndDisplay()));
            },
            child: Container(
              width: 420,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      " BOOKINGS ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.book_outlined,size: 34,),
                  ) ],
              ),
            ),
          ),const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => BikeDetailsScreen()));
            },
            child: Container(
              width: 420,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "ARRIVED BIKE",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.electric_bike,size: 34,),
                  ) ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text("",style: TextStyle(
              fontWeight: FontWeight.bold
          )),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AddBikeScreen()));
            },
            child: Container(
              width: 420,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "ADD BIKE",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.info,size: 34,),
                  )
                ],
              ),
            ),
          ),const SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Lap()));
            },
            child: Container(
              width: 420,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "USER LOGIN INFORMATION",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.info,size: 34,),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const Login()));
            },
            child: Container(
              width: 420,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17

                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.settings_power_outlined,size: 34,),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 150,
            color: Colors.transparent,
          )
        ],
      ),

    );
  }
}
