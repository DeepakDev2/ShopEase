import 'dart:convert';

import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res = await http
          .get(Uri.parse("$uri/api/products?category=$category"), headers: {
        'Content-Type': "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // print("Hello");

          final json = jsonDecode(res.body);
          // print(json);
          for (int i = 0; i < json.length; i++) {
            productList.add(Product.fromJson(json[i]));
          }
        },
      );
    } catch (e) {
      // print("Error");
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({required BuildContext context}) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: "",
      description: "",
      quantity: 0,
      images: [],
      category: "",
      price: 0,
      rating: [],
    );

    try {
      http.Response res =
          await http.get(Uri.parse("$uri/api/deal-of-day"), headers: {
        'Content-Type': "application/json; charset=UTF-8",
        "x-auth-token": userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          // print("Hello");

          final json = jsonDecode(res.body);
          product = Product.fromJson(json);
        },
      );
    } catch (e) {
      // print("Error");
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
