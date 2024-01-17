import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;
  const ProductDetailScreen({super.key});
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id
    return Scaffold(
      appBar: AppBar(
        title: const Text(''
            //  title,
            //  style: const TextStyle(color: Colors.white),
            ),
      ),
    );
  }
}
