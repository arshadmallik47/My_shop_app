import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
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
    // final cart =
    //     Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            );
          },
        ),
        title: const Text(
          'MyShop',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  //productsContainer.showFavoritesOnly();
                  _showOnlyFavorite = true;
                } else {
                  //  productsContainer.showAll();
                  _showOnlyFavorite = false;
                }
              });
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
          Consumer<CartProvider>(
            builder: (_, cart, chil) => ShopBadge(
              value: cart.itemCount.toString(),
              color: Colors.deepOrange,
              child: chil!,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorite),
      drawer: const AppDrawer(),
    );
  }
}
