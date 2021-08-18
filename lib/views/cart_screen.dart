import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_provider.dart';
import 'package:shop/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);

    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text('R\$${cart.totalAmount}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6!
                              .color,
                        )),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      orderProvider.addOrder(
                        cart,
                      );
                      cart.clear();
                    },
                    child: Text(
                      'Comprar',
                    ),
                    // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(value)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.intCount,
              itemBuilder: (ctx, i) => CartItemWidget(
                cartItem: cartItems[i],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
