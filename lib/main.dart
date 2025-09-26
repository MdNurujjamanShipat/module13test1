import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact List',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ContactListPage(),
    );
  }
}

class Contact {
  String name;
  String number;

  Contact({required this.name, required this.number});
}

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final List<Contact> _contacts = [];


  static const Color _appBarColor = Colors.blueGrey;

  void _addContact() {
    setState(() {
      if (_nameController.text.isNotEmpty && _numberController.text.isNotEmpty) {
        _contacts.add(
          Contact(
            name: _nameController.text,
            number: _numberController.text,
          ),
        );
        _nameController.clear();
        _numberController.clear();
      }
    });
  }

  void _deleteContact(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),

          content: const Text('Are you sure for Delete?'),
          actions: <Widget>[

            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.cancel_outlined, color: Colors.blueGrey),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _contacts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.delete_outline, color: Colors.red),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
          style: TextStyle(color: Colors.white), // Ensures title is white
        ),

        backgroundColor: _appBarColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _addContact,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      // Use Blue Grey for the button
                      backgroundColor: _appBarColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];
                return Card(

                  color: index.isOdd ? Colors.white : Colors.blueGrey.shade50,
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: GestureDetector(
                    onLongPress: () => _deleteContact(index),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.black54),
                      title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(contact.number),
                      trailing: IconButton(
                        // Use Blue Grey for the call icon
                        icon: const Icon(Icons.call, color: _appBarColor),
                        onPressed: () {

                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}