import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text(
              'Hello Friend!',
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, OrdersScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () => Navigator.pushReplacementNamed(
                context, UserProductScreen.routeName),
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              }),
          const Divider(),
        ],
      ),
    );
  }
}
