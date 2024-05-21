import 'dart:io';
import 'package:clean_code/domain/repositories/product_repository.dart';
import 'package:clean_code/domain/use_cases/update_product_usecase.dart';
import 'package:clean_code/infraestructure/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:clean_code/domain/models/product_model.dart';

class MyDialogUpdateProduct extends StatefulWidget {
  final int productId;
  const MyDialogUpdateProduct({super.key, required this.productId});

  @override
  _MyDialogUpdateProductState createState() => _MyDialogUpdateProductState();
}

class _MyDialogUpdateProductState extends State<MyDialogUpdateProduct> {
  File? _imageFile;
  late int productId;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  closeAlert() {
    Navigator.pop(context);
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _updateProduct() async {

    final token = Provider.of<UserProvider>(context, listen: false).user?.token;
     if (_imageFile == null) {
      print('Error: No se ha seleccionado ninguna imagen.');
      return;
    }

    if (token == null) {
      print('Error: No se ha encontrado el token.');
      return;
    }
    
    final repository = Provider.of<ProductRepository>(context, listen: false);

    try {
      await repository.createProduct(
        token: token,
        name: _nameController.text,
        description: _descriptionController.text,
        price: _priceController.text,
        stock: _stockController.text,
        image: _imageFile!,
      );
      closeAlert();
      print('Producto actualizado');
    } catch (e) {
      print('Error al actualizar el producto: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    productId = widget.productId;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 350,
        height: 480,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const Text(
              'Editar Producto',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 22,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 325,
              height: 43,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF88B04F))),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintText: 'Escribe el nombre del producto',
                  hintStyle: const TextStyle(
                    color: Color(0xFFAAAAAF),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 325,
              height: 43,
              child: TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF88B04F))),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintText: 'Precio del producto',
                  hintStyle: const TextStyle(
                    color: Color(0xFFAAAAAF),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 325,
              height: 43,
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF88B04F))),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintText: 'Descripción',
                  hintStyle: const TextStyle(
                    color: Color(0xFFAAAAAF),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 325,
              height: 43,
              child: TextField(
                controller: _stockController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF88B04F))),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: MediaQuery.of(context).size.width * 0.02),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  hintText: 'Stock',
                  hintStyle: const TextStyle(
                    color: Color(0xFFAAAAAF),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 99,
                    height: 81,
                    decoration: BoxDecoration(
                        color: const Color(0xFFA3C177),
                        borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                        onTap: () {
                          _getImage();
                        },
                        child: Image.asset('assets/images/Frame.png'))),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () {
                _updateProduct();
              },
              child: Container(
                width: 144,
                height: 36,
                decoration: BoxDecoration(
                    color: const Color(0xFF88B04F),
                    borderRadius: BorderRadius.circular(74.0)),
                child: const Center(
                    child: Text(
                  'Subir Producto',
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

