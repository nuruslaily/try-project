import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class UserModel with ChangeNotifier{
  final String? id;
  String? name;
  String email;
  String? password;
  String? phone;
  String? address;

  UserModel({
    this.id,
    this.name,
    required this.email,
    this.password,
    this.phone,
    this.address,
  });

  void update(String n,String p){
    name=n;
    phone=p;
    saveNum(p);
    saveName(n);
    notifyListeners();

  }

  readName() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('name')??'';
    value==''?name='Nidhin':name=value;
    notifyListeners();
  }

  saveName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', value);
  }

  readNum() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString('phone')??0;
    value==0?phone="123456789":phone=value.toString();
    notifyListeners();
  }

  saveNum(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('phone',value);
  }

  // readPic() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final value = prefs.getString('pic')??'';
  //   value==''?propic='images/pro.png':imagepath=value;
  //   if(value!='')
  //     {
  //       pic=true;
  //       saveStat(true);
  //     }
  //   notifyListeners();
  // }

  // savePic(String value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('pic',value);
  // }
  saveStat(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('stat',value);
  }

  readStat() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool('stat')??false;
    // value==false?pic=false:pic=value;
    notifyListeners();
  }
}
