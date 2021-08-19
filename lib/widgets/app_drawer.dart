import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(
          title: Center(
            child: Text('Bem Vindo Usuário'),
          ),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.production_quantity_limits),
          title: Text('Produtos'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
              AppRoute.products,
            );
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Loja'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
              AppRoute.home,
            );
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Pedidos'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(
              AppRoute.order,
            );
          },
        ),
      ],
    ));
  }
}
