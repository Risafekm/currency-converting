// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_field

import 'dart:convert';
import 'package:currency_main/core/models/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProviderDataSubmit extends ChangeNotifier {
  List<Auth> _posts = [];
  List<Auth> get posts => _posts;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  //addData

  Future<void> addData(String email, String name, BuildContext context) async {
    if (email.isEmpty || name.isEmpty) {
      print('Email and user name cannot be empty');
      return;
    }

    _isLoading = true;
    notifyListeners();

    final apiUrl = Uri.parse(
        'https://api.muhammedhafiz.com/new_project/edu_user/user_authentication.php?user_email=$email&user_pswd=$name');
    final userData = Auth(
      userName: name,
      userEmail: email,
    );

    try {
      final response = await http.post(
        apiUrl,
        body: jsonEncode(userData.toJson()),
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );

      if (response.statusCode == 200) {
        final String responseBody = response.body;
        if (responseBody.isNotEmpty) {
          final data = jsonDecode(responseBody);
          if (data != null && data is Map<String, dynamic>) {
            if (data['status'] == 'success') {
              snackbar(context, text: 'Logged In');
            } else {
              print('Authentication failed: ${data['message']}');
            }
          } else {
            print('Unexpected response format: $data');
          }
        } else {
          print('Empty response body');
        }
      } else {
        print('Failed to add data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  //snackBar

  snackbar(context, {required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            Expanded(child: Text('Successfully $text')),
            const SizedBox(
              width: 20,
            ),
            const Icon(Icons.done, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
