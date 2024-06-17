import 'package:clean_code/domain/use_cases/delete_product_usecase.dart';
import 'package:clean_code/domain/use_cases/get_all_products_usecase.dart';
import 'package:clean_code/domain/use_cases/get_product_byid_usercase.dart';
import 'package:clean_code/domain/use_cases/update_product_usecase.dart';
import 'package:clean_code/infraestructure/repositories/product_repository_impl.dart';
import 'package:clean_code/presentation/providers/connectivity_service.dart';
import 'package:clean_code/presentation/providers/user_provider.dart';
import 'package:clean_code/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ConnectivityService()),
        ProxyProvider<ConnectivityService, ProductRepositoryImpl>(
          update: (_, connectivityService, __) => ProductRepositoryImpl(connectivityService),
        ),
        ProxyProvider<ProductRepositoryImpl, GetAllProductsUseCase>(
          update: (_, productRepository, __) => GetAllProductsUseCase(productRepository),
        ),
        ProxyProvider<ProductRepositoryImpl, GetProductByIdUseCase>(
          update: (_, productRepository, __) => GetProductByIdUseCase(productRepository),
        ),
        ProxyProvider<ProductRepositoryImpl, UpdateProductUseCase>(
          update: (_, productRepository, __) => UpdateProductUseCase(productRepository),
        ),
        ProxyProvider<ProductRepositoryImpl, DeleteProductUseCase>(
          update: (_, productRepository, __) => DeleteProductUseCase(productRepository),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white), 
          useMaterial3: true,
        ),
        home: const LoginPage()); 
  }
}
