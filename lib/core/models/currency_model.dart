// To parse this JSON data, do
//
//     final currencyModel = currencyModelFromJson(jsonString);

import 'dart:convert';

List<CurrencyModel> currencyModelFromJson(String str) =>
    List<CurrencyModel>.from(
        json.decode(str).map((x) => CurrencyModel.fromJson(x)));

String currencyModelToJson(List<CurrencyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrencyModel {
  String currencyNo;
  String currencyName;
  String currencyRates;
  String permission;

  CurrencyModel({
    required this.currencyNo,
    required this.currencyName,
    required this.currencyRates,
    required this.permission,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        currencyNo: json["currency_no"],
        currencyName: json["currency_name"],
        currencyRates: json["currency_rates"],
        permission: json["permission"],
      );

  Map<String, dynamic> toJson() => {
        "currency_no": currencyNo,
        "currency_name": currencyName,
        "currency_rates": currencyRates,
        "permission": permission,
      };
}
