import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final ImageProvider imageProvider;
  final int stock;
  final double price;
  final void Function()? onDelete;
  final void Function()? onEdit;

  const ProductCard({
    Key? key,
    required this.name,
    required this.imageProvider,
    required this.stock,
    required this.price,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        color: const Color(0xFF88B04F).withOpacity(0.51),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.all(22),
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                        width: 200,
                        height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10), // Ajusta el radio según sea necesario
                      ),

                        child: Column(
                          children: [
                        Padding(
                        padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF88B04F),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'FiraSansCondensed',
                                  letterSpacing: 2,
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(width: 5),

                                  Text(
                                    'Stock $stock',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF88B04F),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'FiraSansCondensed',

                                    ),
                                  ),

                                  Text(
                                    ' \$${price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF88B04F),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'FiraSansCondensed',

                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                ],
                              )
                            ],
                          ),
                    )],
                        )),
                  ),
                  const SizedBox(height: 5),
                  Row(

                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: ElevatedButton(
                              onPressed: onDelete,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB63D3D),
                                minimumSize: const Size(5, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/Delete.svg',
                                      width: 13,
                                      height: 13,
                                    ),
                                    const SizedBox(width:3),
                                    const Text(
                                      'Eliminar',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'FiraSansCondensed',
                                      ),
                                    ),
                                  ]),
                            )),
                      ),
                      const SizedBox(width: 5),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: ElevatedButton(
                            onPressed: onEdit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF88B04F),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              minimumSize: const Size(5, 30),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/edit-white.svg',
                                    width: 13,
                                    height: 13,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'Editar',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'FiraSansCondensed',
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SizedBox(
                        width: 80,
                        height: 80,
                        child:  Image(image: imageProvider),
                ),
                  ),
                  )
            ],
          ),
        ));
  }
}
