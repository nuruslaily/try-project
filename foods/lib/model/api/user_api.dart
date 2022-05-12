import 'dart:convert';
import 'dart:js';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foods/model/user_model.dart';

class UserAPI {
  static Future<List<UserModel>> getUser() async {
    final response = await Dio().get(
        "https://my-json-server.typicode.com/nuruslaily/pelatihan/profile");

    List<UserModel> user = (response.data as List)
        .map((e) => UserModel(
            id: e['id'],
            name: e['name'],
            email: e['email'],
            password: e['password'],
            phone: e['phone'],
            address: e['address']))
        .toList();

    return user;
  }

  static Future doLogin(email, password) async {
    final response = await Dio().post(
        "https://my-json-server.typicode.com/nuruslaily/pelatihan/profile",
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
        data: jsonEncode({
          "email": email,
          "password": password,
        }));

    final output = jsonDecode(response.data);

    return output;
  }
}
