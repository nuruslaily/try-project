import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foods/model/food_model.dart';
import 'package:foods/screens/component/card_screen.dart';
import 'package:foods/screens/food/food_view_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key, required this.foodViewModel}) : super(key: key);

  final FoodViewModel foodViewModel;
  @override
  Widget build(BuildContext context) {
    if (foodViewModel.foods.isEmpty) {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Favorite",
            style: TextStyle(fontSize: 17, fontFamily: 'Merriweather'),
          ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        child:  Center(
          child: Text("No Favorite Items",
            style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF7C7C7C),),
          ),
        ),
      ),
    );
     
    } else {
      return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            "Favorite",
            style: TextStyle(fontSize: 17, fontFamily: 'Merriweather'),
          ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        child: GridView.builder(
        itemBuilder: (ctx, index) {
          return ProductCards(
            menu: foodViewModel.foods[index],
            );
        },
        itemCount: foodViewModel.foods.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
      )),
      );
    }
  }
}