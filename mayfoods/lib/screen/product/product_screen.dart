import 'package:flutter/material.dart';
import 'package:mayfoods/model/product_model.dart';
import 'package:mayfoods/model/product_view_state.dart';
import 'package:mayfoods/screen/cart/cart_screen.dart';
import 'package:mayfoods/screen/product/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('MayFoods'), actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartScreen(),
              ),
            );
          },
          icon: const Icon(Icons.shopping_cart),
        )
      ]),
      body: ProductList(viewModel: viewModel),
    );
  }
}

class ProductList extends StatefulWidget {
  final ProductViewModel viewModel;
  const ProductList({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void didChangeDepedencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<ProductViewModel>(context).getAllProduct();
    });
  }

  Widget gridView(ProductViewModel viewModel) {
    final _menu = widget.viewModel.product;
    return GridView.builder(
        itemCount: widget.viewModel.product.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
        itemBuilder: (context, index) {
          return Consumer<ProductViewModel>(
            builder: (context, ProductViewModel item, widget) {
              final menu = viewModel.product[index];
              return ProductCards(
                  menu: _menu[index],
                  isAdded: item.product.contains(menu),
                  onTap: () {
                    setState(() {
                      item.addCart(menu);
                    });
                  });
            },
          );
        });
  }

  Widget body(ProductViewModel viewModel) {
    final isLoading = viewModel.state == ProductViewState.loading;
    final isError = viewModel.state == ProductViewState.error;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return const Center(child: Text("Gagal mengambil data"));
    }

    return gridView(viewModel);
  }

  // Widget listView(ProductViewModel viewModel) {
  //   return ListView.builder(
  //     itemCount: viewModel.product.length,
  //     itemBuilder: (context, index) {
  //       final food = viewModel.product[index];
  //       return ListTile(
  //         title: Text(food.name),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    ProductViewModel viewModel = Provider.of<ProductViewModel>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.red.withOpacity(0.5),
      child: body(viewModel),
    );
  }
}

class ProductCards extends StatelessWidget {
  const ProductCards(
      {Key? key,
      required this.menu,
      required this.isAdded,
      required this.onTap})
      : super(key: key);
  final Product menu;
  final bool isAdded;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    // ProductViewModel viewModel = Provider.of<ProductViewModel>(context);
    return Card(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child:
                Image.asset('assets/img/ceker-pedas.jpeg', fit: BoxFit.cover),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  key: Key(menu.id.toString()),
                  child: Text(
                    menu.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: onTap,
                  icon: isAdded
                      ? Icon(
                          Icons.shopping_cart,
                          color: Colors.red[900],
                        )
                      : const Icon(Icons.shopping_cart),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
