import 'dart:convert';
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
}
