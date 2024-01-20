import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/widgets/product_grid.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductOverViewScreen extends StatefulWidget {
  const ProductOverViewScreen({super.key});

  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer =
    //     Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyShop',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.favorite) {
                //productsContainer.showFavoritesOnly();
                _showOnlyFavorite = true;
              } else {
                //  productsContainer.showAll();
                _showOnlyFavorite = false;
              }
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Only Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
          ),
        ],
      ),
      body: const ProductsGrid(),
    );
  }
}
