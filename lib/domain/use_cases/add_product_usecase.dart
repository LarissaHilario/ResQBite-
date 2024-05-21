import 'dart:io';
import 'package:clean_code/domain/repositories/product_repository.dart';

class CreateProductUseCase {
  final ProductRepository productRepository;

  CreateProductUseCase(this.productRepository);

  Future<void> execute({required String name, required String description, required String price, required String stock, required File image, required String token}) {
    return productRepository.createProduct(name: name, description: description, price: price, stock: stock, image: image, token: token);
  }
}