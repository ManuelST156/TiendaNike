import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';
import '../models/shoe_model.dart';

class CartItem extends StatefulWidget {
  CartItem({super.key, required this.shoe});

  Shoe shoe;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Image.network(
              'https://naoflenqutshacihgmmv.supabase.co/storage/v1/object/public/Productos/${widget.shoe.name}.png'),
          title: Text(widget.shoe.name),
          subtitle: Text(widget.shoe.price.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Provider.of<Cart>(context, listen: false)
                  .removeFromCart(widget.shoe);

              Provider.of<Cart>(context, listen: false)
                  .deleteProductFromCart(widget.shoe.id);
            },
          ),
        ),
      ),
    );
  }
}
