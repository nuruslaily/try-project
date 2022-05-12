import 'package:dio/dio.dart';
import 'package:mayfoods/model/product_model.dart';

class ProductAPI {
  static Future<List<Product>> getMenu() async {
    final response = await Dio()
        .get("https://my-json-server.typicode.com/nuruslaily/pelatihan/menu");

    List<Product> product = (response.data as List)
        .map((e) => Product(
            id: e['id'],
            category: e['category'],
            name: e['name'],
            price: e['price'],
            description: e['description'],
            image: e['image']))
        .toList();
    print(response.data);
    return product;
  }
}
