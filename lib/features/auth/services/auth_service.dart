import 'dart:convert';

import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
// import 'package:amazon/features/home/screens/home_screen.dart';
import 'package:amazon/models/user.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: "",
          name: name,
          password: password,
          address: "",
          type: "",
          token: "",
          email: email,
          cart: []);
      // print(user.toJson().toString());
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: jsonEncode(user.toJson()),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8"
          });
      httpErrorHandle(
          response: res,
          context: (context),
          onSuccess: () {
            showSnackBar(
                context, "Account created! Login wiht the same credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      // print(user.toJson().toString());
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            'Content-Type': "application/json; charset=UTF-8"
          });
      httpErrorHandle(
          response: res,
          context: (context),
          onSuccess: () async {
            // showSnackBar(context, "Working Successful");
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)["token"]);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
            showSnackBar(context, "Login Successful");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({
    required BuildContext context,
    // required String token,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();

      String? token = await pref.getString("x-auth-token");
      if (token == null) {
        pref.setString("x-auth-token", "");
      }
      token = await pref.getString("x-auth-token");
      var tokenRes = await http.post(Uri.parse("$uri/tokenIsValid"),
          headers: <String, String>{
            "Content-type": "application/json: charset=UTF-8",
            "x-auth-token": token!
          });
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              "Content-type": "application/json: charset=UTF-8",
              "x-auth-token": token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
      // print(user.toJson().toString());
      // http.Response res=  await http.post(
      //   Uri.parse("$uri/api/signin"),
      //   body: jsonEncode({
      //     "email":email,
      //     "password":password,
      //   }),
      //   headers: <String,String>{
      //     'Content-Type': "application/json; charset=UTF-8"
      //   }
      // );
      // httpErrorHandle(
      //   response: res,
      //   context: (context),
      //   onSuccess: () async{
      //     // showSnackBar(context, "Working Successful");
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     Provider.of<UserProvider>(context,listen: false).setUser(res.body);
      //     await prefs.setString('x-auth-token',jsonDecode(res.body)["token"]);
      //     Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName,(route)=>false);
      //     showSnackBar(context, "Login Successful");
      //   }
      // );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
