import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Adress extends StatefulWidget {
  const Adress({Key? key}) : super(key: key);

  @override
  State<Adress> createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  String _currentAddress = 'Fetching address...';

  // @override
  // void initState() {
  //   super.initState();
  //   _getLocation();
  // }

  // Future<void> _getLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     List<Placemark> placemarks = await Geolocator.placemarkFromCoordinates(
  //         position.latitude, position.longitude);
  //
  //     setState(() {
  //       _currentAddress =
  //       '${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}';
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _currentAddress = 'Failed to fetch address: $e';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Address'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your current address is:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _currentAddress,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

