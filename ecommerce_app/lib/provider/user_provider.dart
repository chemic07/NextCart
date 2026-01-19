import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    email: "",
    name: "",
    password: "",
    address: "",
    type: "",
    token: "",
    cart: [],
  );

  bool _isLoading = true;

  User get user => _user;
  bool get isLoading => _isLoading;

  void setUser(String userJson) {
    _user = User.fromJson(userJson);
    _isLoading = false;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUsrFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
