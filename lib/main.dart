import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => ProductProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => CartProvider(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => OrdersProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Colors.purple),
            hintColor: Colors.deepOrange,
            fontFamily: 'Lato',

            // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            //primaryColor: Colors.blue,
            useMaterial3: true,
          ),
          home: const ProductOverViewScreen(),
          routes: {
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrdersScreen.routeName: (context) => const OrdersScreen(),
            UserProductScreen.routeName: (context) => const UserProductScreen(),
            EditProductScreen.routeName: (context) => const EditProductScreen(),
          },
        ),
      );
}
