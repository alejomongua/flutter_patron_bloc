import 'dart:convert';

import 'package:intl/intl.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.titulo,
    this.valor,
    this.disponible = true,
    this.fotourl,
  });

  String? id;
  String? titulo;
  double? valor;
  bool disponible;
  String? fotourl;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"],
        disponible: json["disponible"],
        fotourl: json["fotourl"],
      );

  String get precio {
    if (valor == null) return "\$0";

    final format = NumberFormat.compactSimpleCurrency();

    return format.format(valor);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "valor": valor,
        "disponible": disponible,
        "fotourl": fotourl,
      };
}
