import 'dart:convert';
import 'package:flutter/material.dart';

class ProductModel {
  final int id;
  final String name;
  final int stock;
  final double price;
  final String image;
  late ImageProvider imageProvider;

  ProductModel({
    required this.id,
    required this.name,
    required this.stock,
    required this.price,
    required this.image,
  }) {
    imageProvider = _getImageProvider();
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }

  ImageProvider _getImageProvider() {
    final bytes = base64Decode(image);
    return MemoryImage(bytes);
  }
}
