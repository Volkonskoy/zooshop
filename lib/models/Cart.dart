import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'Product.dart';

class Cart {
  int? id;
  final int userId;
  final ProductDTO product;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': product.id,
    };
  }

  Cart({this.id, required this.userId, required this.product});
}

Future<List<Cart>> fetchCartsByUserId(int userId) async {
  final response = await http.get(Uri.parse('https://localhost:7097/api/Cart/$userId'));

  if (response.statusCode == 200) {
    // Если запрос успешный, парсим JSON
    List<dynamic> cartData = json.decode(response.body);

    // Для каждого товара из корзины получаем подробности о продукте
    List<Cart> carts = [];
    for (var cartItem in cartData) {
      // Для каждого Cart получаем Product по ProductId
      var product = await fetchProductById(cartItem['productId']);
      carts.add(Cart(
        id: cartItem['id'],
        userId: cartItem['userId'],
        product: product,
      ));
    }

    return carts;
  } else {
    throw Exception('Не удалось загрузить товары из корзины');
  }
}

Future<void> addToCart(Cart cart) async {
  final url = Uri.parse('https://localhost:7097/api/Cart'); // Укажите правильный URL для вашего API

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json', // Указываем тип данных, которые отправляем
    },
    body: json.encode(cart.toJson()), // Преобразуем объект Cart в JSON
  );

  if (response.statusCode == 200) {
    print('Товар успешно добавлен в корзину');
    print(response.body);
  } else {
    print('Не удалось добавить товар в корзину. Статус: ${response.statusCode}');
  }
}