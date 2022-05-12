import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:foods/model/api/food_api.dart';
import 'package:foods/model/api/user_api.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/model/user_model.dart';
import 'package:foods/model/view_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  List<UserModel> _user = [];

  List<UserModel> get user => _user;

  ViewState _state = ViewState.none;
  ViewState get state => _state;

  changeState(ViewState s) {
    _state = s;
    notifyListeners();
  }

  getAllUser() async {
    // changeState(FoodViewState.loading);

    try {
      final u = await UserAPI.getUser();
      _user = u;
      notifyListeners();
      changeState(ViewState.none);
    } catch (e) {
      changeState(ViewState.error);
    }
  }

  doLogin(email, password) async {
    // changeState(FoodViewState.loading);

    try {
      final u = await UserAPI.doLogin(email, password);
      _user = u;
      notifyListeners();
      changeState(ViewState.none);
    } catch (e) {
      changeState(ViewState.error);
    }
  }

  List<String>? name = [];
  List<String>? email = [];
  List<String>? password = [];
  List<String>? phone = [];
  List<String>? address = [];
  List<String>? uid = [];

  void setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid!.clear();
    for (int i = 0; i < _user.length; i++) {
      name!.add(_user[i].name!);
      email!.add(_user[i].email);
      password!.add(_user[i].password!);
      phone!.add(_user[i].phone!);
      address!.add(_user[i].address!);
      uid!.add(_user[i].id.toString());
    }
    await prefs.setStringList("name", name!);
    await prefs.setStringList("email", email!);
    await prefs.setStringList("password", password!);
    await prefs.setStringList("phone", phone!);
    await prefs.setStringList("address", address!);
    await prefs.setStringList("id", uid!);
    notifyListeners();
  }

   void addUser(UserModel userModel) {
    _user.add(userModel);
    setData();
    notifyListeners();
  }

  void loginUser(UserModel userModel) {
    _user.add(userModel);
    notifyListeners();
  }

}
