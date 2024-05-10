import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Bike {
  final String name;
  final String model;
  final int year;
  final int price;
  final String status;
  final String imageUrl;

  Bike({
    required this.name,
    required this.model,
    required this.year,
    required this.price,
    required this.status,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'model': model,
      'year': year,
      'price': price,
      'status': status,
      'imageUrl': imageUrl,
    };
  }
}

class AddBikeScreen extends StatefulWidget {
  @override
  _AddBikeScreenState createState() => _AddBikeScreenState();
}

class _AddBikeScreenState extends State<AddBikeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<String> uploadImageToStorage(File imageFile) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref =
    storage.ref().child('images/${imageFile.path}.jpg');
    await ref.putFile(imageFile);
    String imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> _pickImage() async {
    final pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> addBike(Bike bike) async {
    try {
      await _firestore.collection('bikes').add(bike.toMap());
      _nameController.clear();
      _modelController.clear();
      _yearController.clear();
      _priceController.clear();
      _statusController.clear();
      setState(() {
        _selectedImage = null;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Bike added successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error adding bike: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
            const Text('Failed to add bike. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bike'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Bike Name',
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _modelController,
                decoration: InputDecoration(
                  labelText: 'Model',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _statusController,
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text(
                  'Pick Image',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              _selectedImage != null
                  ? Image.file(
                _selectedImage!,
                height: 150,
                width: 150,
              )
                  : const SizedBox(height: 150, width: 150),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Colors.black),
                ),
                onPressed: () async {
                  if (_nameController.text.isNotEmpty &&
                      _modelController.text.isNotEmpty &&
                      _yearController.text.isNotEmpty &&
                      _priceController.text.isNotEmpty &&
                      _statusController.text.isNotEmpty &&
                      _selectedImage != null) {
                    String imageUrl =
                    await uploadImageToStorage(_selectedImage!);
                    Bike newBike = Bike(
                      name: _nameController.text,
                      model: _modelController.text,
                      year: int.tryParse(_yearController.text) ?? 0,
                      price: int.tryParse(_priceController.text) ?? 0,
                      status: _statusController.text,
                      imageUrl: imageUrl,
                    );
                    addBike(newBike);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: const Text(
                              'Please fill all fields and select an image.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  'Add Bike',
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
