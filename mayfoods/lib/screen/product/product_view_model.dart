import 'package:flutter/cupertino.dart';
import 'package:mayfoods/model/api/product_api.dart';
import 'package:mayfoods/model/product_model.dart';
import 'package:mayfoods/model/product_view_state.dart';

class ProductViewModel with ChangeNotifier {
  List<Product> _product = [];

  List<Product> get product => _product;

  ProductViewState _state = ProductViewState.none;
  ProductViewState get state => _state;

  changeState(ProductViewState s) {
    _state = s;
    notifyListeners();
  }

  getAllProduct() async {
    try {
      final p = await ProductAPI.getMenu();
      _product = p;
      notifyListeners();
      changeState(ProductViewState.none);
    } catch (e) {
      changeState(ProductViewState.error);
    }
  }

  void addCart(Product foodMenu) {
    _product.add(foodMenu);
    notifyListeners();
  }
}
