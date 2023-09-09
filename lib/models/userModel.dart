import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  String? image;
  String? id;
  String? name;
  String? email;
  Usermodel({this.id, this.image, this.name, this.email});
  factory Usermodel.fromJson(map) {
    return Usermodel(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      email: map['email'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'email': email,
      'name': name,
    };
  }

  Usermodel copyWith({
    String? name,
    String? image,
  }) =>
      Usermodel(
        image: image ?? this.image,
        id: id,
        email: email,
        name: name ?? this.name,
      );
}
