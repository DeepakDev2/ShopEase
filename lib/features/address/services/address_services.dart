import 'dart:convert';

import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/models/product.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String userAddress,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: {
          // "Content-Type": "application/json; charset=UTF-8",
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({
          "address": userAddress,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(res.body)["address"]);

            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all product

  void placeOrder(
      {required BuildContext context,
      required String addresss,
      required double totalSum}) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse("$uri/api/order"),
          headers: {
            'Content-Type': "application/json; charset=UTF-8",
            "x-auth-token": userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            "address": addresss,
            "totalPrice": totalSum,
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(cart: []);
          userProvider.setUserFromModel(user);
          showSnackBar(context, "Order Placed Successfully");
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/admin/delete-product"),
        headers: {
          'Content-Type': "application/json; charset=UTF-8",
          "x-auth-token": userProvider.user.token,
        },
        body: jsonEncode({'id': product.id}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
