import 'package:clean_code/domain/use_cases/get_all_products_usecase.dart';
import 'package:clean_code/domain/use_cases/get_product_byid_usercase.dart';
import 'package:clean_code/domain/use_cases/update_product_usecase.dart';
import 'package:clean_code/presentation/components/dialog_create_product.dart';
import 'package:clean_code/presentation/components/dialog_delete_product.dart';
import 'package:clean_code/presentation/components/dialog_update_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:clean_code/domain/models/product_model.dart';
import 'package:clean_code/infraestructure/repositories/product_repository_impl.dart';
import 'package:clean_code/presentation/providers/user_provider.dart';
import 'package:clean_code/presentation/components/product_card_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomeAdmiPageState();
}
class _HomeAdmiPageState extends State<HomePage> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    if (token != null) {
      final getAllProductsUseCase = Provider.of<GetAllProductsUseCase>(context, listen: false);
      futureProducts = getAllProductsUseCase.execute(token);
    } else {
      futureProducts = Future.error('User is not authenticated');
    }
  }

  Future<void> _showDeleteDialog(int productId) async {
    try {
      final token =
          Provider.of<UserProvider>(context, listen: false).user?.token;
      final getProductByIdUseCase = Provider.of<GetProductByIdUseCase>(context, listen: false);
      final product = await getProductByIdUseCase.execute(productId, token!);
      showDialog(
        context: context,
        builder: (context) => MyDialogDeleteProduct(
          productId: productId,
          product: product,
        ),
      );
    } catch (error) {
      print('Error al obtener los datos del producto: $error');
    }
  }

  void addProductAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MyDialogAddProduct();
      },
    );
  }

  Future<void> _showUpdateDialog(int productId) async {
    try {
      final token = Provider.of<UserProvider>(context, listen: false).user?.token;
      showDialog(
        context: context,
        builder: (context) => MyDialogUpdateProduct(
          productId: productId,
        ),
      );
    } catch (error) {
      print('Error al obtener los datos del producto: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 29, top: 80, right: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'RESQBITE',
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 5,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 28, top: 40, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'MIS PRODUCTOS',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF464646),
                        fontWeight: FontWeight.w300,
                        fontFamily: 'FiraSansCondensed',
                        letterSpacing: 2,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        addProductAlert();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF88B04F),
                        minimumSize: const Size(5, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/Add.svg',
                            width: 13,
                            height: 13,
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Añadir Producto',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'FiraSansCondensed',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<List<ProductModel>>(
              future: futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!.map((product) {
                      return ProductCard(
                        name: product.name,
                        imageProvider: product.imageProvider,
                        stock: product.stock,
                        price: product.price,
                        onDelete: () {
                          _showDeleteDialog(product.id);
                        },
                        onEdit: () {
                          _showUpdateDialog(product.id);
                        },
                      );
                    }).toList(),
                  );
                } else {
                  return const Text("No products found");
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 560),
                child: Container(
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDDE4D9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/user1.svg',
                            width: 40,
                            height: 40,
                          ),
                          onPressed: () {
                            // Navigate to user profile
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/home.svg',
                            width: 45,
                            height: 45,
                          ),
                          onPressed: () {
                            // Navigate to home
                          },
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/images/location.svg',
                            width: 50,
                            height: 50,
                          ),
                          onPressed: () {
                            // Navigate to location
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
