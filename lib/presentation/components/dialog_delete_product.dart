import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:clean_code/domain/models/product_model.dart';
import 'package:clean_code/domain/use_cases/delete_product_usecase.dart';
import 'package:clean_code/domain/use_cases/get_product_byid_usercase.dart';
import 'package:clean_code/presentation/providers/user_provider.dart';

class MyDialogDeleteProduct extends StatefulWidget {
  final int productId;

  const MyDialogDeleteProduct({
    Key? key,
    required this.productId, required ProductModel product,
  }) : super(key: key);

  @override
  _MyDialogDeleteProductState createState() => _MyDialogDeleteProductState();
}

class _MyDialogDeleteProductState extends State<MyDialogDeleteProduct> {
  late Future<ProductModel> _productFuture;
  late ProductModel _product;

  @override
  void initState() {
    super.initState();
    _fetchProductData();
  }

  void _fetchProductData() {
    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
    final getProductByIdUseCase = Provider.of<GetProductByIdUseCase>(context, listen: false);
    _productFuture = getProductByIdUseCase.execute(widget.productId, token!);
  }

  Future<void> deleteProduct() async {
    try {
      final token = Provider.of<UserProvider>(context, listen: false).user?.token;
      final deleteProductUseCase = Provider.of<DeleteProductUseCase>(context, listen: false);
      await deleteProductUseCase.execute(widget.productId, token!);
      closeAlert();
    } catch (error) {
      print('Error al eliminar el producto: $error');
    }
  }

  void closeAlert() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 350,
        height: 300,
        child: FutureBuilder<ProductModel>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error al obtener los datos del producto: ${snapshot.error}');
            } else if (snapshot.hasData) {
              _product = snapshot.data!;
              return Column(
                children: [
                  const Text(
                    '¿Estás seguro de eliminar el producto?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 22,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFFA9C581),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    width: 308,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            width: 130,
                            height: 48,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _product.name,
                                  style: const TextStyle(
                                      color: Color(0xFF88B04F), fontSize: 10),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${_product.stock}',
                                        style: const TextStyle(
                                            color: Color(0xFF88B04F),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '\$${_product.price}',
                                        style: const TextStyle(
                                            color: Color(0xFF88B04F),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        // Muestra la imagen utilizando Image.network
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xFFB63D3D),
                            borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        width: 110,
                        height: 36,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/Delete.svg',
                              width: 15,
                            ),
                            TextButton(
                              onPressed: () {
                                deleteProduct();
                              },
                              child: const Text(
                                'Eliminar',
                                style:
                                    TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border.fromBorderSide(
                                BorderSide(color: Color(0xFFA9C582))),
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        width: 110,
                        height: 36,
                        child: TextButton(
                          onPressed: () {
                            closeAlert();
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(color: Color(0xFF000000), fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else {
              return const Text('No se encontraron datos del producto.');
            }
          },
        ),
      ),
    );
  }
}
