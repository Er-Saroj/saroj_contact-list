// ignore_for_file: avoid_function_literals_in_foreach_calls, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saroj_contact/contact_list_screen.dart';
import 'package:saroj_contact/provider.dart';

void main() {
  List<dynamic> contactsJson = jsonDecode(jsonData);
  List<Contact> contacts =
      contactsJson.map((json) => Contact.fromJson(json)).toList();

  ContactProvider contactProvider = ContactProvider();
  contacts.forEach((contact) => contactProvider.addContact(contact));

  runApp(
    ChangeNotifierProvider(
      create: (context) => contactProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListScreen(),
    );
  }
}

String jsonData = '''[
    {
      "firstName": "saroj",
      "middleName": "Kumar",
      "lastName": "Singh",
      "phoneNumber": "7488212629"
    },
    {
      "firstName": "Guru",
      "middleName": "",
      "lastName": "kr.",
      "phoneNumber": "9876543210"
    },
    {
      "firstName": "Shiboo",
      "middleName": "",
      "lastName": "Sharma",
      "phoneNumber": "9551234567"
    }
  ]''';
