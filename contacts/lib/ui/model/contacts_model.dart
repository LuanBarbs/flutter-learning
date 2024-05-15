import 'package:contacts/data/contacts.dart';
import 'package:contacts/data/db/contact_dao.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model {
  final ContactDao _contactDao = ContactDao();
  List<Contato>? _contatos;

  List<Contato>? get contatos => _contatos;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future loadContacts() async {
    _isLoading = true;
    notifyListeners();
    _contatos = await _contactDao.getAllInSortedOrder();
    _isLoading = false;
    notifyListeners();
  }

  void addContato(Contato contato) {
    _contatos ??= [];
    _contatos?.add(contato);
    _contactDao.insert(_contatos, contato);
    notifyListeners();
  }

  void updateContato(Contato contato) {
    notifyListeners();
  }

  void deleteContato(int index) {
    notifyListeners();
  }

  void changeFavoriteStatus(Contato contato) {
    contato.isFavorite = !contato.isFavorite;
    notifyListeners();
  }
}