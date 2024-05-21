import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:clean_code/domain/models/product_model.dart';
import 'package:clean_code/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<ProductModel>> getAllProducts(String token) async {
    final response = await http.get(
      Uri.parse('http://3.223.7.73/get-saucers-by-store'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('saucers')) {
        List<dynamic> saucersJson = jsonResponse['saucers'];
        List<ProductModel> products = saucersJson.map((saucer) => ProductModel.fromJson(saucer)).toList();
        return products;
      } else {
        throw Exception('Response does not contain "saucers"');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
  @override
  Future<ProductModel> getProductById(int productId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('http://3.223.7.73/get-saucer-by-id/$productId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final productData = json.decode(response.body);
        return ProductModel.fromJson(productData);
      } else {
        throw Exception('Error al obtener los datos del producto');
      }
    } catch (error) {
      throw Exception('Error al obtener los datos del producto: $error');
    }
  }
  
  @override
  Future<void> deleteProduct(String token, int productId) async {
  final url = 'http://3.223.7.73/delete-saucer/$productId';
    final response = await http.delete(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Producto eliminado exitosamente');
      }
    } else {
      throw Exception('Error al eliminar el producto: ${response.reasonPhrase}');
    }
  }

  @override
  Future<void> createProduct({required String name, required String description, required String price, required String stock, required File image, required String token }) async {
      const url = 'http://3.223.7.73/create-saucer';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({'Authorization': 'Bearer $token'});
      request.fields.addAll({
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
      });
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Producto creado exitosamente');
        }
      } else {
        throw Exception('Error al crear el producto: ${response.reasonPhrase}');
      }
    }
    
@override
  Future<void> updateProduct({required int productId, required String name, required String description, required String price, required String stock, required File image, required String token}) async {
    final url = 'http://3.223.7.73/update-saucer/$productId';
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.headers.addAll({'Authorization': 'Bearer $token'});
      request.fields.addAll({
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
      });
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      final response = await request.send();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Producto creado exitosamente');
        }
      } else {
        throw Exception('Error al crear el producto: ${response.reasonPhrase}');
      }
    }
}
  