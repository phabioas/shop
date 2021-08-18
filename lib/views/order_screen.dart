import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/order.dart';
import 'package:shop/providers/order_provider.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_item_widget.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrderProvider orderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    final List<Order> orders = orderProvider.orders;

    return Scaffold(
      appBar: AppBar(
        title: Text("Últimos Pedidos"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (ctx, i) => OrderItemWidget(order: orders[i]),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
