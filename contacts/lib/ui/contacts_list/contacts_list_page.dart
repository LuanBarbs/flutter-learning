import 'package:contacts/ui/contact/contact_create_page.dart';
import 'package:contacts/ui/contacts_list/widget/contacts_tile.dart';
import 'package:contacts/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({super.key});


  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: Colors.blue,
      ),
      body: ScopedModelDescendant<ContactsModel>(
        builder: (context, child, model) {
          return ListView.builder(
            itemCount: model.contatos!.length,
            itemBuilder: (context, index) {
              return ContactTile(contactIndex: index,);
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add, color: Colors.purple),
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ContactCreatePage())
          )
        },
      ),
    );
  }
}