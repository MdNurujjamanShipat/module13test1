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
      // Keep the theme data clean, but the AppBar will override its color
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
          content: const Text('Are you sure you want to delete this contact?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _contacts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
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
        // === Background Color Fix ===
        // Setting the background color for the AppBar (Title Bar)
        backgroundColor: const Color(0xFF008080), // Teal/blue-green color
        // Ensures icons/text on the AppBar are light (white)
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
                      // Using the same blue-green color for the button
                      backgroundColor: const Color(0xFF008080),
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
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: GestureDetector(
                    onLongPress: () => _deleteContact(index),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(contact.name),
                      subtitle: Text(contact.number),
                      trailing: IconButton(
                        icon: const Icon(Icons.call, color: Color(0xFF008080)),
                        onPressed: () {
                          // Implement call functionality
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