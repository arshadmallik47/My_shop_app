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
    final loadedProduct = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      // appBar: AppBar(

      //   title: Text(
      //     loadedProduct.title,
      //     style: const TextStyle(color: Colors.white),
      //   ),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title,
              ),
              background: Hero(
                tag: loadedProduct.id!,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProduct.price}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              const SizedBox(
                height: 800,
              )
            ]),
          )
        ],
      ),
    );
  }
}
