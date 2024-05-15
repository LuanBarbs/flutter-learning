import 'package:contacts/data/contacts.dart';
import 'package:contacts/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactEditPage extends StatelessWidget {
  final Contato editContact;
  final int editContactIndex;

  const ContactEditPage({
    super.key,
    required this.editContact,
    required this.editContactIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar"),
        backgroundColor: Colors.purple,
      ),
      body: ContactForm(
        editContact: editContact,
        editContactIndex: editContactIndex,
      ),
    );
  }
}