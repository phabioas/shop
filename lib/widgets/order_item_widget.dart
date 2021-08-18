import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderItemWidget extends StatefulWidget {
  final Order order;

  OrderItemWidget({
    required this.order,
  });

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat('###.0#', 'pt_BR');

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ListTile(
              title: Text(f.format(widget.order.total)),
              subtitle: Text(
                DateFormat('dd/MM/yyyy HH:mm').format(widget.order.date),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                height: (widget.order.products.length * 25.0) + 10,
                child: ListView(
                  children: widget.order.products.map((product) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${product.quantity} x R\$${f.format(product.price)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
