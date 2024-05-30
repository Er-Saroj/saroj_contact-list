// screens/edit_contact_screen.dart
// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saroj_contact/provider.dart';

class EditContactScreen extends StatefulWidget {
  final Contact? contact;
  final int? index;

  EditContactScreen({this.contact, this.index});

  @override
  _EditContactScreenState createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _middleName;
  String? _lastName;
  late String _phoneNumber;

  @override
  void initState() {
    super.initState();
    _firstName = widget.contact?.firstName ?? '';
    _middleName = widget.contact?.middleName ?? '';
    _lastName = widget.contact?.lastName ?? '';
    _phoneNumber = widget.contact?.phoneNumber ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 11.0),
            child: SizedBox(
              height: 50,
              width: 110,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue[900])),
                child: Text(
                  widget.contact == null ? 'Add' : 'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (widget.contact == null) {
                      contactProvider.addContact(
                        Contact(
                          firstName: _firstName,
                          middleName: _middleName,
                          lastName: _lastName,
                          phoneNumber: _phoneNumber,
                        ),
                      );
                    } else {
                      contactProvider.updateContact(
                        widget.index!,
                        Contact(
                          firstName: _firstName,
                          middleName: _middleName,
                          lastName: _lastName,
                          phoneNumber: _phoneNumber,
                        ),
                      );
                    }

                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 8),
                    child: Icon(
                      Icons.person_2_outlined,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 310,
                    child: TextFormField(
                      initialValue: _firstName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'First Name'),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter a first name';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _firstName = value!;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: TextFormField(
                  initialValue: _middleName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Middle Name'),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter a middle name';
                  //   }
                  //   return null;
                  // },
                  onSaved: (value) {
                    _middleName = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45.0),
                child: TextFormField(
                  initialValue: _lastName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Last Name'),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter a last name';
                  //   }
                  //   return null;
                  // },
                  onSaved: (value) {
                    _lastName = value!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 10),
                    child: Icon(Icons.call),
                  ),
                  SizedBox(
                    width: 315,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: _phoneNumber,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phoneNumber = value!;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 10),
                    child: Icon(Icons.mail),
                  ),
                  SizedBox(
                    width: 315,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      //initialValue: _phoneNumber,
                      decoration: InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder()),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter a phone number';
                      //   }
                      //   return null;
                      // },
                      // onSaved: (value) {
                      //   _phoneNumber = value!;
                      // },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
