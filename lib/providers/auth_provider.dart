// ignore_for_file: avoid_print, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String? token;
  String? userId;
  DateTime? expiryDate;

  bool get isAuth {
    return token != null;
  }

  String? get Token {
    if (expiryDate != null &&
        expiryDate!.isAfter(DateTime.now()) &&
        token != null) {
      return token!;
    }
    return null;
  }

  String? get UserId {
    return userId!;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDzgWxjYFN-I4biShqHUb9nKKa6QTx63us';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      token = responseData['idToken'];
      userId = responseData['localId'];
      expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData['expiresIn']),
        ),
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  // signup user
  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
    // const url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDzgWxjYFN-I4biShqHUb9nKKa6QTx63us';
    // final response = await http.post(
    //   Uri.parse(url),
    //   body: json.encode(
    //     {
    //       'email': email,
    //       'password': password,
    //       'returnSecureToken': true,
    //     },
    //   ),
    // );
    // print(json.decode(response.body));
  }

  // login user
  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  // logout user
  void logout() {
    token = null;
    userId = null;
    expiryDate = null;
    notifyListeners();
  }
}
