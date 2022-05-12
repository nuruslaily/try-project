import 'package:flutter/material.dart';
import 'package:mayfoods/model/product_model.dart';
import 'package:mayfoods/screen/product/product_screen.dart';
import 'package:mayfoods/screen/product/product_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductViewModel(),
            ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MayFoods',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: const ProductScreen()));
  }
}
