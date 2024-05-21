import 'package:clean_code/domain/models/product_model.dart';
import 'package:clean_code/domain/repositories/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository _productRepository;

  GetAllProductsUseCase(this._productRepository);

  Future<List<ProductModel>> execute(String token) async {
    return await _productRepository.getAllProducts(token);
  }
}
