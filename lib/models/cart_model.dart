import 'package:flutter/material.dart';
import 'package:nike_store/models/shoe_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Cart extends ChangeNotifier {
  // List of shoes for sale
  List<Shoe> shoeShop = [];

  // List of items in user cart
  List<Shoe> userCart = [];

  // Get list of shoes for sale
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  // Get cart items
  List<Shoe> getUserCart() {
    return userCart;
  }

  // Add items to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  // Remove items from cart
  void removeFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }

  // Create a new cart in Supabase and add products to it
  Future<void> createCartAndAddProducts() async {
    final response = await Supabase.instance.client.from('Carritos').insert({
      'FechaCreacion': DateTime.now().toIso8601String(),
      'EstaActivo': true
    });

    final responseGetId =
        await Supabase.instance.client.from('ultimocarrito').select('*');

    final List<Map<String, dynamic>> productsToAdd = userCart.map((shoe) {
      return {
        'idCarrito': responseGetId[0]["idCarrito"],
        'idProducto': shoe.id,
      };
    }).toList();

    final productsResponse = await Supabase.instance.client
        .from('ProductosCarrito')
        .insert(productsToAdd);
  }

  Future<void> deleteProductFromCart(int productId) async {
    // Delete the product from ProductosCarrito
    final responseGetId =
        await Supabase.instance.client.from('ultimocarrito').select('*');

    final deleteResponse = await Supabase.instance.client
        .from('ProductosCarrito')
        .delete()
        .match({
      'idCarrito': responseGetId[0]["idCarrito"],
      'idProducto': productId
    });
  }
}
