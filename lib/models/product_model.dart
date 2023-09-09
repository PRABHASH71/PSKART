import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel(
      {required this.image,
      required this.id,
      required this.isFav,
      required this.name,
      required this.price,
      required this.description,
      required this.status,
      this.qty});
  String image;
  String id;
  bool isFav;
  String name;
  String price;
  String description;
  String status;
  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      image: json["image"],
      id: json["id"],
      isFav: false,
      name: json["name"],
      price: json["price"],
      qty: json["qty"],
      description: json["description"],
      status: json["status"]);

  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
        "isFav": isFav,
        "name": name,
        "price": price,
        "description": description,
        "status": status,
        "qty": qty
      };

  @override
  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        image: image,
        id: id,
        isFav: isFav,
        name: name,
        price: price,
        qty: qty ?? this.qty,
        description: description,
        status: status,
      );
}
