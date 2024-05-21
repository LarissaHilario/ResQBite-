import 'package:clean_code/domain/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getAllProducts(String token);
}
