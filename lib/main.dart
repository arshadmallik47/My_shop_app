import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/services/app_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (ctx)=>ProductProvider(),
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
          home: ProductOverViewScreen(),
          routes: {
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
          },
        ),
      );
}
