import 'dart:io';
import 'package:clean_code/domain/repositories/product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository productRepository;

  UpdateProductUseCase(this.productRepository);

  Future<void> execute({required int productId, required String name, required String description, required String price, required String stock, required File image, required String token}) {
    return productRepository.updateProduct(
      productId: productId,
      name: name,
      description: description,
      price: price,
      stock: stock,
      image: image,
      token: token,
    );
  }
}
