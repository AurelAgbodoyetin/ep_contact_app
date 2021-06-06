class Contact {
  int? id;
  final String name;
  final String phoneNumber;
  final String email;
  bool isFavorite;
  final String? desc;
  int sex;

  Contact({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.isFavorite,
    required this.desc,
    required this.sex,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phoneNumber,
      "sex": sex,
      "isFavorite": isFavorite ? 1 : 0,
      "desc": desc,
    };
  }

  factory Contact.fromMap(Map<String, dynamic>? cMap) {
    print(cMap);
    return Contact(
      id: cMap?["id"],
      name: cMap?["name"],
      phoneNumber: cMap?["phone"],
      email: cMap?["email"],
      isFavorite: cMap?["isFavorite"] == 1 ? true : false,
      sex: cMap?["sex"],
      desc: cMap?["desc"],
    );
  }
}
