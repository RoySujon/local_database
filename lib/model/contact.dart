class Contact {
  int? id;
  String name;
  String phone;
  Contact({this.id, required this.name, required this.phone});
  //FROM MAP
  factory Contact.fromMap(Map<String, dynamic> value) {
    return Contact(id: value['id'], name: value['name'], phone: value['phone']);
  }
  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'phone': phone};
}
