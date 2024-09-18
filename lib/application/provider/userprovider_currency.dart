// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:currency_main/core/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProviderCurrency extends ChangeNotifier {
  List<CurrencyModel> _posts = [];
  List<CurrencyModel> get posts => _posts;
  var isLoading = false;

  Future<void> getData() async {
    isLoading = true;
    notifyListeners();
    var api =
        "https://api.muhammedhafiz.com/new_project/currency/read_currency.php";
    try {
      var response = await http.get(Uri.parse(api));
      if (response.statusCode == 200) {
        var data = List<CurrencyModel>.from(
                jsonDecode(response.body).map((e) => CurrencyModel.fromJson(e)))
            .toList();
        if (data != null) {
          _posts = data;
          isLoading = false;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}
