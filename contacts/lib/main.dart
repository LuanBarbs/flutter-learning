// ignore: unused_import
import 'package:contacts/ui/contact/contact_create_page.dart';
import 'package:contacts/ui/contacts_list/contacts_list_page.dart';
import 'package:contacts/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ContactsModel()..loadContacts(),
      child: const MaterialApp(
        title: 'Contatos',
        home: ContactsListPage(),
      ),
    );
  }
}
