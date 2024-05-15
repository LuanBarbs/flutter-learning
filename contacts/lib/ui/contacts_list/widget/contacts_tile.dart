import 'package:contacts/data/contacts.dart';
import 'package:contacts/ui/contact/contact_edit_page.dart';
import 'package:contacts/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.contactIndex,
  });

  final int contactIndex;

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<ContactsModel>(context);
    final contatoMostrado = model.contatos![contactIndex];
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              model.deleteContato(contactIndex);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Deletar',
          ),
        ],
      ),
      child: _buildContent(contatoMostrado, model, context),
    );
  }

  Container _buildContent(Contato contatoMostrado, ContactsModel model, BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(contatoMostrado.name),
        subtitle: Text(contatoMostrado.email),
        trailing: IconButton(
          onPressed: (){ model.changeFavoriteStatus(contatoMostrado); },
          icon: Icon(
            contatoMostrado.isFavorite ? Icons.star : Icons.star_border,
            color: contatoMostrado.isFavorite ? Colors.amber : Colors.grey,
          ),
        ),
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ContactEditPage(
              editContact: contatoMostrado,
              editContactIndex: contactIndex,
            ))
          );
        },    
      )
    );
  }
}