import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/auth_screen.dart';
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
          ChangeNotifierProvider.value(
            value: AuthProvider(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
            create: (context) => ProductProvider('', '', []),
            update: (context, auth, previousProducts) => ProductProvider(
              auth.token!,
              auth.userId!,
              previousProducts == null ? [] : previousProducts.items,
            ),
          ),
          // ChangeNotifierProvider(
          //   create: (ctx) => ProductProvider(),
          // ),
          ChangeNotifierProvider(
            create: (ctx) => CartProvider(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
            create: (ctx) => OrdersProvider('', '', []),
            update: (context, auth, previousOrders) => OrdersProvider(
                auth.token!,
                auth.userId!,
                previousOrders == null ? [] : previousOrders.orders),
          ),
          // ChangeNotifierProvider(
          //   create: (ctx) => OrdersProvider(),
          // ),
        ],
        child: Consumer<AuthProvider>(
          builder: (BuildContext context, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(color: Colors.purple),
              hintColor: Colors.deepOrange,
              primaryColor: Colors.purple,
              fontFamily: 'Lato',

              // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              //primaryColor: Colors.blue,
              useMaterial3: true,
            ),
            home: auth.isAuth
                ? const ProductOverViewScreen()
                : const AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (context) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              UserProductScreen.routeName: (context) =>
                  const UserProductScreen(),
              EditProductScreen.routeName: (context) =>
                  const EditProductScreen(),
            },
          ),
        ),
      );
}
