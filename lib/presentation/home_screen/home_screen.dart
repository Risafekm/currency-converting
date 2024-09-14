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
  final TextEditingController _amountController = TextEditingController();
  String? _selectedCurrency = 'INR'; // Input currency
  String? _outputCurrency = 'USD'; // Output currency
  String _convertedValue = ''; // Holds the converted value

  // Conversion rates between INR, USD, and EURO
  final Map<String, double> _conversionRates = {
    'INR': 1.0,
    'USD': 0.012,
    'EURO': 0.011,
  };

  // Function to handle currency conversion
  void _convertCurrency() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double conversionRate = _conversionRates[_outputCurrency]! /
        _conversionRates[_selectedCurrency]!;
    double convertedAmount = amount * conversionRate;

    setState(() {
      _convertedValue =
          convertedAmount.toStringAsFixed(2); // Show 2 decimal points
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background container
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
          ),

          // Design container at the bottom
          Positioned(
            bottom: 0,
            child: Container(
              height: size.height * .36,
              width: size.width,
              color: Colors.white,
            ),
          ),

          // Main container for input and output
          Positioned(
            right: 20,
            left: 20,
            bottom: 70,
            child: MainContainer(
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 25, right: 15),
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

                    // Input area
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
                          // TextField for entering the amount
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            width: size.width * .7,
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                _convertCurrency(); // Recalculate on amount change
                              },
                            ),
                          ),

                          // Dropdown for selecting input currency
                          Expanded(
                            child: Container(
                              color: backgroundColor,
                              child: DropdownButton<String>(
                                value: _selectedCurrency,
                                underline: const SizedBox.shrink(),
                                iconEnabledColor: Colors.white,
                                style: const TextStyle(color: Colors.white),
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
                                    _convertCurrency(); // Recalculate on currency change
                                  });
                                },
                              ),
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

                    // Output area
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
                          // Displaying the converted value
                          Container(
                            margin: const EdgeInsets.only(left: 4),
                            width: size.width * .7,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _convertedValue.isEmpty
                                  ? 'Converted Value'
                                  : _convertedValue,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),

                          // Dropdown for selecting output currency
                          Expanded(
                            child: Container(
                              color: backgroundColor,
                              child: DropdownButton<String>(
                                value: _outputCurrency,
                                iconEnabledColor: Colors.white,
                                underline: const SizedBox.shrink(),
                                style: const TextStyle(color: Colors.white),
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
                                    _convertCurrency(); // Recalculate on currency change
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // heading text
          const Positioned(
            top: 290,
            left: 140,
            child: Text(
              'Currency Convertor',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
