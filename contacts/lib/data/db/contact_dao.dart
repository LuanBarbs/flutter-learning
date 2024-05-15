import 'dart:io';

import 'package:contacts/data/contacts.dart';

class ContactDao {
  final file = File('lib/data/db/bd.txt');
  late String text;

  Future insert(List<Contato>? contact, Contato contato) async {
    text = 
      "${contato.id},${contato.name},${contato.email},${contato.phoneNumber},${contato.isFavorite}";
    file.writeAsStringSync(text, mode: FileMode.append);
    _sortContatos(contact);
  }
  Future update(List<Contato>? contact, Contato contato) async {}
  Future delete(List<Contato>? contact, Contato contato) async {}

  Future<List<Contato>> getAllInSortedOrder() async {
    final lines = file.readAsLinesSync();
    final contatos = <Contato>[];
    int idCounter = 1;
    for(final line in lines) {
      final values = line.split(',');
      final name = values[1];
      final email = values[2];
      final phone = values[3];
      final favorite = values[4];
      late bool favorito;
      if(favorite == "true") {
        favorito = true;
      }
      else {
        favorito = false;
      }
      final contact = Contato(
        id: idCounter,
        name: name,
        email: email,
        phoneNumber: phone,
        isFavorite: favorito,
      );
      contatos.add(contact);
      idCounter++;
    }
    _sortContatos(contatos);
    return contatos;
  }

  void _sortContatos(List<Contato>? _contatos) {
    _contatos!.sort((a, b) {
      if(a.isFavorite && !b.isFavorite) {
        return -1;
      }
      else if(!a.isFavorite && b.isFavorite) {
        return 1;
      }
      else {
        return a.name.compareTo(b.name);
      }
    });
  }
}