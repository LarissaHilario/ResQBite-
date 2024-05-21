import 'package:clean_code/domain/repositories/product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository _productRepository;

  DeleteProductUseCase(this._productRepository);

  Future<void> execute(int productId, String token) async {
    await _productRepository.deleteProduct( token, productId);
  }
}
