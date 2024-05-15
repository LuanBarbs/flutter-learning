import 'package:contacts/data/contacts.dart';
import 'package:contacts/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactForm extends StatefulWidget {
  final Contato? editContact;
  final int? editContactIndex;

  const ContactForm({
    super.key,
    this.editContact,
    this.editContactIndex,
  });

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  bool get isEditMode => widget.editContact != null;

  late String _name, _email, _phoneNumber;
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 10,),
          TextFormField(
            onSaved: (value) => _name = value!,
            validator: validateNome,
            initialValue: widget.editContact?.name,
            decoration: InputDecoration(
              labelText: 'Nome',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            onSaved: (value) => _email = value!,
            validator: validateEmail,
            initialValue: widget.editContact?.email,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            onSaved: (value) => _phoneNumber = value!,
            validator: validatePhoneNumber,
            initialValue: widget.editContact?.phoneNumber,
            decoration: InputDecoration(
              labelText: 'Número de telefone',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: onSaveContactButtonPressed,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Salvar Contato', style: TextStyle(color: Colors.black, fontSize: 20),),
                Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.black,
                )
              ],
            )
          )
        ],
      ),
    );
  }

  String? validateNome(String? value) {
    if(value == null || value.isEmpty) {
      return 'Entre com um nome!';
    }
    return null;
  }
  String? validateEmail(String? value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    if(value == null || value.isEmpty) {
      return 'Entre com um email!';
    }
    else if(!emailRegex.hasMatch(value)) {
      return 'Entre com um email válido!';
    }
    return null;
  }
  String? validatePhoneNumber(String? value) {
    final phoneNumberRegex = RegExp(r"^(?:(?:\+|00)?(55)\s?)?(?:\(?([1-9][0-9])\)?\s?)?(?:((?:9\d|[2-9])\d{3})\-?(\d{4}))$");
    if(value == null || value.isEmpty) {
      return 'Entre com um número de telefone!';
    }
    else if(!phoneNumberRegex.hasMatch(value)) {
      return 'Entre com um número de telefone válido!';
    }
    return null;
  }

  void onSaveContactButtonPressed() {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final contactsmodel = ScopedModel.of<ContactsModel>(context);
      final newContact = Contato(
        name: _name,
        email: _email,
        phoneNumber: _phoneNumber,
        isFavorite: widget.editContact?.isFavorite ?? false,
      );
      if(isEditMode) {
        newContact.id = widget.editContact!.id;
        contactsmodel.updateContato(newContact);
      } 
      else {
        if(contactsmodel.contatos!.isEmpty) {
          newContact.id = 1;
        }
        else {
          final lastContact = contactsmodel.contatos?.reduce((a, b) => a.id > b.id ? a : b); 
          newContact.id = lastContact!.id + 1;
        }
        contactsmodel.addContato(newContact);
      }
    }
  }
}