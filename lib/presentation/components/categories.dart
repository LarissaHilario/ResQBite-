import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoriesComponent extends StatefulWidget {
  const CategoriesComponent({Key? key}) : super(key: key);

  @override
  State<CategoriesComponent> createState() => _CategoriesComponentState();
}

class _CategoriesComponentState extends State<CategoriesComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 70,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF88B04F).withOpacity(.25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Comida',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FiraSansCondensed',
                    ),
                  ),
                  Image.asset(
                    'assets/images/food.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF88B04F).withOpacity(.25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Pastelería',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FiraSansCondensed',
                    ),
                  ),
                  Image.asset(
                    'assets/images/cake.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF88B04F).withOpacity(.25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Panadería',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FiraSansCondensed',
                    ),
                  ),
                  Image.asset(
                    'assets/images/concha.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
            Container(
              width: 70,
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF88B04F).withOpacity(.25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Lácteos',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FiraSansCondensed',
                    ),
                  ),
                  Image.asset(
                    'assets/images/leche.png',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
