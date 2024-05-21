import 'package:clean_code/domain/models/product_model.dart';
import 'package:clean_code/domain/repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _productRepository;

  GetProductByIdUseCase(this._productRepository);

  Future<ProductModel> execute(int productId, String token) async {
    try {
      final product = await _productRepository.getProductById(productId, token);
      return product;
    } catch (error) {
      throw Exception('Error al obtener los datos del producto: $error');
    }
  }
}
