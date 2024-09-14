// ignore_for_file: unused_local_variable, unused_field

import 'package:currency_main/core/const.dart';
import 'package:currency_main/presentation/home_screen/widgets/main_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedCurrency = 'INR';
  String? _outputCurrency = 'USD';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // body container

          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
          ),

          //design container bottom

          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * .36,
              width: size.width,
              color: Colors.white,
            ),
          ),

          //main container section

          Positioned(
            right: 20,
            left: 20,
            bottom: 70,
            child: MainContainer(
                child: Container(
              margin: EdgeInsets.only(left: 15, top: 25, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // input area
                  Container(
                    height: 53,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: .5,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          width: size.width * .7,
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                        //dropdown button
                        Expanded(
                          child: Container(
                            color: backgroundColor,
                            child: DropdownButton<String>(
                                value: _selectedCurrency,
                                underline: const SizedBox.shrink(),
                                iconEnabledColor: Colors.white,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                dropdownColor: backgroundColor,
                                items: const [
                                  DropdownMenuItem(
                                    value: "INR",
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text('INR'),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "USD",
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text('USD'),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "EURO",
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text('EURO'),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCurrency = value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Convert to',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // output  area
                  Container(
                    height: 53,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: .5,
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 4),
                          width: size.width * .7,
                        ),

                        //dropdown button
                        Expanded(
                          child: Container(
                            color: backgroundColor,
                            child: DropdownButton<String>(
                                value: _outputCurrency,
                                iconEnabledColor: Colors.white,
                                underline: const SizedBox.shrink(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                dropdownColor: backgroundColor,
                                items: const [
                                  DropdownMenuItem(
                                    value: "INR",
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text('INR'),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "USD",
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text('USD'),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "EURO",
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text('EURO'),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _outputCurrency = value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
