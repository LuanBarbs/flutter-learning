import 'package:contacts/ui/contact/widget/contact_form.dart';
import 'package:flutter/material.dart';

class ContactCreatePage extends StatelessWidget {
  const ContactCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Contato'),
        backgroundColor: Colors.purple,
      ),
      body: const ContactForm(),
    );
  }
}