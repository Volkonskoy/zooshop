import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class Product {
  final int id;
  final String name;
  final int price;
  final String image;
  final String desc;

  Product({required this.id, required this.name, required this.price, required this.image, required this.desc});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      desc: json['desc'],
    );
  }
}

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse('https://localhost:7097/api/Product'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((item) => Product.fromJson(item)).toList();
  } else {
    throw Exception('Не удалось загрузить товары');
  }
}