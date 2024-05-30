// providers/contact_provider.dart
// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class Contact {
  String? firstName;
  String? middleName;
  String? lastName;
  String phoneNumber;

  Contact({
    this.firstName,
    this.middleName,
    this.lastName,
    required this.phoneNumber,
  });

  String get fullName => '$firstName $middleName $lastName';

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void deleteContact(int index) {
    _contacts.removeAt(index);
    notifyListeners();
  }

  void updateContact(int index, Contact contact) {
    _contacts[index] = contact;
    notifyListeners();
  }
}
