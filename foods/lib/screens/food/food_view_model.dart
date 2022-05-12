import 'package:flutter/cupertino.dart';
import 'package:foods/model/api/food_api.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/model/view_state.dart';

class FoodViewModel with ChangeNotifier {
  List<Food> _foods = [];

  List<Food> get foods => _foods;

  ViewState _state = ViewState.none;
  ViewState get state => _state;

  changeState(ViewState s) {
    _state = s;
    notifyListeners();
  }

  getAllFoods() async {
    // changeState(FoodViewState.loading);

    try {
      final f = await FoodAPI.getFoods();
      _foods = f;
      notifyListeners();
      changeState(ViewState.none);
    } catch (e) {
      changeState(ViewState.error);
    }
  }

  List<Food> _cartList = [];

  List<Food> get cartList => _cartList;

  void addCart(Food foodMenu) {
    _cartList.add(foodMenu);
    notifyListeners();
  }

  List<Food> _category = [];

  List<Food> get category => _category;
}

List<Widget> getChildrenWithSeparator(
    {required List<Widget> widgets,
    required Widget separator,
    bool addToLastChild = true}) {
  List<Widget> children = [];
  if (widgets.length > 0) {
    children.add(separator);

    for (int i = 0; i < widgets.length; i++) {
      children.add(widgets[i]);

      if (widgets.length - i == 1) {
        if (addToLastChild) {
          children.add(separator);
        }
      } else {
        children.add(separator);
      }
    }
  }
  return children;
}
