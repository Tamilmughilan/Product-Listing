import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2)); 
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    final List<Product> products = (data['products'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
    return products;
  }
}