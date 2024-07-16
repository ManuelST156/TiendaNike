import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/models/shoe_model.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/cart_model.dart';
import '../widgets/shoe_tile.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  final TextEditingController _textController = TextEditingController();
  late Future<List<Shoe>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();
  }

  Future<List<Shoe>> fetchProducts() async {
    final response =
        await Supabase.instance.client.from('Products').select('*');

    final List<dynamic> data = response as List<dynamic>;
    return data.map((product) => Shoe.fromJson(product)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: AnimSearchBar(
              width: 400,
              textController: _textController,
              onSuffixTap: () {
                setState(() {
                  _textController.clear();
                });
              },
              onSubmitted: (String) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Text(
              'Everyone flies... some fly longer than others',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hot Pics 🔥',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'View All',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Shoe>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products found.'));
                } else {
                  final products = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      Shoe shoe = products[index];
                      return ShoeTile(
                        shoe: shoe,
                        onTap: () {
                          addShoeToCart(shoe);
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void addShoeToCart(Shoe shoe) {
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);
    Provider.of<Cart>(context, listen: false).createCartAndAddProducts();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item Added To Cart'),
      ),
    );
  }
}

/* void createCartAndAddProducts() {




} */