import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  late File _image = File('image_url');
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  late DocumentSnapshot profileSnapshot;
  String imgurl = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }
  Future<void> fetchProfileData() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('signup')
          .doc('ToP9EDda1gRgEUPCTYM8YY0HWNj2')
          .get();
      setState(() {
        profileSnapshot = snapshot;
        nameController.text = profileSnapshot['name'].toString();
        addressController.text = profileSnapshot['address'].toString();
        ageController.text = profileSnapshot['age'].toString();
        _idController.text = profileSnapshot['id'].toString();
        phoneNumberController.text = profileSnapshot['phone'].toString();
        String imageUrl = profileSnapshot['image_url'];
        imgurl = imageUrl;
        if (imageUrl.isNotEmpty) {
          _image = File(imageUrl);
        }
        isLoading = false;
      });
    } catch (error) {
      print('Failed to fetch profile data: $error');
    }
  }
  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  Future<void> saveProfile() async {
    try {
      if (nameController.text.isEmpty ||
          addressController.text.isEmpty ||
          ageController.text.isEmpty ||
          phoneNumberController.text.isEmpty ||
          _idController.text.isEmpty ||
          _image == null) {
        print('All fields are required');
        return;
      }
      final String imageName =
          'signup_${DateTime.now().millisecondsSinceEpoch.toString()}';
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('signup')
          .child(imageName);
      await ref.putFile(_image);
      final String downloadUrl = await ref.getDownloadURL();
      Map<String, dynamic> profileData = {
        'name': nameController.text,
        'address': addressController.text,
        'age': ageController.text,
        'phone': phoneNumberController.text,
        'id': _idController.text,
        'image_url': downloadUrl,
      };
      if (profileSnapshot != null) {

        await FirebaseFirestore.instance
            .collection('signup')
            .doc(profileSnapshot.id)
            .update(profileData);
        print('Profile updated successfully!');
      } else {

        await FirebaseFirestore.instance
            .collection('signup')
            .add(profileData);
        print('Profile uploaded successfully!');
      }
    } catch (error) {
      print('Failed to save profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: _image == null || !_image.existsSync()
                      ? Center(
                    child: Image.network(imgurl),
                  )
                      : Image.file(
                    _image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: getImage,
                child: const Text(
                  'S e l e c t',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Address',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Age',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'id',
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: saveProfile,
                child: const Text(
                  'S a v e',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
