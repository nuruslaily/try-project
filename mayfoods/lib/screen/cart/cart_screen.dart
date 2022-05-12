import 'package:flutter/material.dart';
import 'package:mayfoods/model/product_model.dart';
import 'package:mayfoods/screen/product/product_view_model.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartList =
        Provider.of<ProductViewModel>(context, listen: false).product;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: Container(
          color: Colors.red.withOpacity(0.5),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        cartList[index].name,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Buy',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ],
          )),
    );
  }
}
