class Contato {
  int id;
  String name, email, phoneNumber;
  bool isFavorite;

  Contato({
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.isFavorite = false,
    this.id = 0,
  });
}