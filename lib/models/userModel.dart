import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  String? image;
  String? id;
  String? name;
  String? email;
  String? address;
  String? pincode;
  Usermodel(
      {this.id, this.image, this.name, this.email, this.address, this.pincode});
  factory Usermodel.fromJson(map) {
    return Usermodel(
        id: map['id'],
        image: map['image'],
        name: map['name'],
        email: map['email'],
        pincode: map['pincode'],
        address: map['address']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'email': email,
      'name': name,
      'address': address,
      'pincode': pincode,
    };
  }

  Usermodel copyWith({
    String? name,
    String? image,
    String? address,
    String? pincode,
  }) =>
      Usermodel(
        image: image ?? this.image,
        id: id,
        email: email,
        name: name ?? this.name,
        address: address ?? this.address,
        pincode: pincode ?? this.pincode,
      );
}
