
import 'package:bike_in/Admin%20page/fetch.dart';
import 'package:bike_in/botto%20tab/profile.dart';
import 'package:bike_in/login.dart';
import 'package:bike_in/menu/help%20and%20support.dart';
import 'package:bike_in/menu/my%20adress.dart';
import 'package:bike_in/menu/my%20boookings.dart';
import 'package:bike_in/menu/terms%20and%20conditions.dart';
import 'package:bike_in/menu/wallet.dart';
import 'package:flutter/material.dart';
class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  State<Menu> createState() => _HomeState();
}
class _HomeState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
    child: Scaffold(
      backgroundColor: Colors.white54,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: 462,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 120,width: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        const Image(image: AssetImage("asset/image/user.jpeg"),height: 90),
                        Column(
                          children: [
                            const Text("ABITH K B",style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            )),
                            const Text('   Account status:  '
                                ,style: TextStyle(
                              color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                            ),),
                            const Text('        update your information',style: TextStyle(
                                color: Colors.white,
                              fontSize: 15
                            ),),
                         const SizedBox(
                           height: 10,
                         ),
                         GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) => const Profile()));
                           },
                           child: Container(
                             height: 50,
                             width: 150,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(24),
                             ),
                             child: const Center(child: Text("PROFILE",style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 20
                             ),)),
                           ),
                           )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        const SizedBox(
          height: 40,
        ),
        Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Book()));
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
                        "MY BOOKINGS",
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
              height: 45,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const Adress()));
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
                        "MY ADRESS",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.location_on_outlined,size: 34,),
                    ) ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const wallet()));
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
                        "wallet",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.monetization_on_rounded,size: 34,),
                    ) ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const help()));
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
                        "Help and Support",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17

                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.help,size: 34,),
                    )
                  ],
                ),
              ),
            ),const SizedBox(
              height: 20,
            ),
            const Text("LEGAL INFORMATION",style: TextStyle(
              fontWeight: FontWeight.bold
            )),
            const SizedBox(
              height: 40,
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const condition()));
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
                        "Terms and conditions",
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
            const SizedBox(
              height: 5,
            ),

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
        )  ],
        ),
      ),
    ));
  }
}
