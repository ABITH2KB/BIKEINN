import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BikeDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bike Details'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('bikes').snapshots(),
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
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  _navigateToEditScreen(context, document);
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image on the left
                      Image.network(data['imageUrl'], height: 150, width: 150),
                      const SizedBox(width: 10), // Adding space between image and text
                      // Text information on the right
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${data['name']}',style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24
                              )),
                              Text('Model: ${data['model'].toString()}',style: const TextStyle(
                                fontSize: 19,fontWeight: FontWeight.w400
                              )),
                              Text('Year: ${data['year'].toString()}',style: const TextStyle(
                                  fontSize: 19,fontWeight: FontWeight.w400
                              )),
                              Text('Price: ${data['price'].toString().toString()}',style: const TextStyle(
                                  fontSize: 19,fontWeight: FontWeight.w400
                              )),
                              Text('Status: ${data['status']}',style: const TextStyle(
                                  fontSize: 19,fontWeight: FontWeight.w400
                              )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context, DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditBikeScreen(document: document)),
    );
  }
}

class EditBikeScreen extends StatefulWidget {
  final DocumentSnapshot document;
  EditBikeScreen({required this.document});

  @override
  _EditBikeScreenState createState() => _EditBikeScreenState();
}

class _EditBikeScreenState extends State<EditBikeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _modelController;
  late TextEditingController _yearController;
  late TextEditingController _priceController;
  late TextEditingController _statusController;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> data = widget.document.data() as Map<String, dynamic>;
    _nameController = TextEditingController(text: data['name'].toString());
    _modelController = TextEditingController(text: data['model'].toString());
    _yearController = TextEditingController(text: data['year'].toString());
    _priceController = TextEditingController(text: data['price'].toString());
    _statusController = TextEditingController(text: data['status'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Bike Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _modelController,
              decoration: InputDecoration(labelText: 'Model',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _yearController,
              decoration: InputDecoration(labelText: 'Year',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 160),
              child: ElevatedButton(style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)
              ),
                onPressed: () {
                  _updateBikeDetails(context);
                },
                child: const Text('Update',style: TextStyle(
                  color: Colors.white
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateBikeDetails(BuildContext context) {

    int price = int.tryParse(_priceController.text) ?? 0;


    FirebaseFirestore.instance.collection('bikes').doc(widget.document.id).update({
      'name': _nameController.text,
      'model': _modelController.text,
      'year': _yearController.text,
      'price': price,
      'status': _statusController.text,
    }).then((_) {
      Navigator.pop(context);
    }).catchError((error) {

      print("Failed to update bike details: $error");
    });
  }
  @override
  void dispose() {
    _nameController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _priceController.dispose();
    _statusController.dispose();
    super.dispose();
  }
}
