import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;
  const ProductDetailScreen({super.key});
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context)!.settings.arguments as String; // is the id
    final loadedProduct = Provider.of<ProductProvider>(context, listen: false);
    final productTitle = loadedProduct.findById(productId);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          productTitle.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
