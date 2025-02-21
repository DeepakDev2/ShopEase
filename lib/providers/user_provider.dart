import 'dart:convert';

import 'package:amazon/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    address: "",
    email: "",
    id: "",
    name: "",
    password: "",
    token: "",
    type: "",
    cart: [],
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(jsonDecode(user));
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
