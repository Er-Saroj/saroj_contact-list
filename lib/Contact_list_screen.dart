// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saroj_contact/edit_contact.dart';
import 'package:saroj_contact/provider.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  int? _selectedContactIndex;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        actions: [
          Visibility(
            visible: _selectedContactIndex != null,
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                if (_selectedContactIndex != null) {
                  contactProvider.deleteContact(_selectedContactIndex!);
                  setState(() {
                    _selectedContactIndex = null;
                  });
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.brown[50],
              ),
              height: 50,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search_outlined),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contactProvider.contacts.length,
              itemBuilder: (context, index) {
                final contact = contactProvider.contacts[index];
                // Perform search filtering
                if (_searchController.text.isNotEmpty &&
                    !contact.fullName
                        .toLowerCase()
                        .contains(_searchController.text.toLowerCase())) {
                  return SizedBox
                      .shrink(); // Hide the ListTile if it doesn't match the search
                }
                return InkWell(
                  onLongPress: () {
                    setState(() {
                      _selectedContactIndex = index;
                    });
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditContactScreen(
                          contact: contact,
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      child: Text(
                        contact.fullName[0].toUpperCase(),
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    title: Text(contact.fullName),
                    subtitle: Text(contact.phoneNumber),
                    selected: _selectedContactIndex == index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[600],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditContactScreen()),
          );
        },
      ),
    );
  }
}
