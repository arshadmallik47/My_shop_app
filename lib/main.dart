// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
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
import 'package:shop_app/screens/splash_screen.dart';
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
          ChangeNotifierProvider<AuthProvider>(
            create: (ctx) => AuthProvider(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
            create: (_) => ProductProvider('', '', []),
            update: (context, auth, previousProducts) {
              if (auth != null && auth.token != null && auth.userId != null) {
                return ProductProvider(
                  auth.token!,
                  auth.userId!,
                  previousProducts?.items ?? [],
                );
              }
              // Handle the case when auth is null or its properties are null.
              // For example, you might return a default ProductProvider instance.
              return ProductProvider('', '', []);
            },
          ),
          // ChangeNotifierProvider(
          //   create: (ctx) => ProductProvider(),
          // ),
          ChangeNotifierProvider(
            create: (ctx) => CartProvider(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, OrdersProvider>(
            // create: (_) => OrdersProvider('', '', []),
            create: (_) => OrdersProvider('', '', []),
            update: (context, auth, previousProducts) {
              if (auth != null && auth.token != null && auth.userId != null) {
                return OrdersProvider(
                  auth.token!,
                  auth.userId!,
                  previousProducts?.orders ?? [],
                );
              }
              // Handle the case when auth is null or its properties are null.
              // For example, you might return a default ProductProvider instance.
              return OrdersProvider('', '', []);
            },
            // update: (context, auth, previousOrders) => OrdersProvider(
            //   auth.token!,
            //   auth.userId!,
            //   previousOrders?.orders ?? [],
            // ),
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
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              }),
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
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const AuthScreen(),
                  ),
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
